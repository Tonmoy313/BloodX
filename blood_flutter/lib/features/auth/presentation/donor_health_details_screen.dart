import 'dart:async';
import 'dart:io';

import 'package:blood_client/blood_client.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../../../core/data/bangladesh_locations.dart';
import '../../../core/location/foreground_location_service.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/network/serverpod_client.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/blood_colors.dart';
import '../../../core/widgets/blood_button.dart';
import '../../../core/widgets/permission_dialogs.dart';
import '../controllers/auth_controller.dart';

/// Donor onboarding is split into two phases:
/// Phase 1: Core profile (sex, dob, blood group, last donation, 3 preferred areas with cascading dropdowns, realtime GPS location).
/// Phase 2: Readiness check (weight & health questionnaire evaluated by server readiness_check model).
class DonorHealthDetailsScreen extends StatefulWidget {
  const DonorHealthDetailsScreen({super.key});

  @override
  State<DonorHealthDetailsScreen> createState() =>
      _DonorHealthDetailsScreenState();
}

class _DonorHealthDetailsScreenState extends State<DonorHealthDetailsScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final ForegroundLocationService _locationService =
      const ForegroundLocationService();

  int _step = 0;
  bool _isSaving = false;
  bool _isLocatingGps = false;

  // Phase 1 - Profile Details
  String? _sex;
  DateTime? _dateOfBirth;
  String _selectedBloodGroup = 'O+';
  String _bloodGroupSource = 'self';
  DateTime? _lastDonatedAt;
  bool _apheresisWilling = false;

  // Phase 1 - 3 Preferred Locations (Cascading District -> Upazila)
  String? _primaryDistrict = 'Dhaka';
  String? _primaryUpazilla = 'Dhanmondi';

  String? _secondaryDistrict = 'Dhaka';
  String? _secondaryUpazilla = 'Mirpur';

  String? _tertiaryDistrict;
  String? _tertiaryUpazilla;

  // Phase 1 - Realtime Location
  double? _latitude = 23.7465;
  double? _longitude = 90.3760;
  String _selectedCoordinates = '23.746500, 90.376000';
  bool _hasGpsAcquired = false;

  final Set<String> _selectedHospitals = {
    'Dhaka Medical College Hospital (DMCH)',
  };

  // Phase 2 - Readiness Questionnaire
  final List<bool?> _answers = List<bool?>.filled(7, null);

  static const _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  static const _dhakaHospitals = [
    'Dhaka Medical College Hospital (DMCH)',
    'Bangabandhu Sheikh Mujib Medical University (BSMMU)',
    'BIRDEM General Hospital',
    'National Institute of Cardiovascular Diseases (NICVD)',
    'Kurmitola General Hospital',
    'Mugda Medical College Hospital',
    'National Heart Foundation',
    'Evercare Hospital Dhaka',
    'Square Hospital',
    'United Hospital',
    'Shaheed Suhrawardy Medical College Hospital',
  ];

  List<String> get _readinessQuestions => [
    BloodStrings.donorQuestionAge,
    BloodStrings.donorQuestionWeight,
    BloodStrings.donorQuestionWell,
    BloodStrings.donorQuestionFever,
    BloodStrings.donorQuestionMedication,
    BloodStrings.donorQuestionHydrated,
    BloodStrings.donorQuestionCooldown,
  ];

  List<String> _districts = BangladeshLocations.districts;
  Map<String, List<String>> _locationsMap =
      BangladeshLocations.districtUpazilas;

  @override
  void initState() {
    super.initState();
    _fetchServerAreas();
  }

  Future<void> _fetchServerAreas() async {
    try {
      final serverLocations = await client.area.getAllLocations();
      if (serverLocations.isNotEmpty && mounted) {
        setState(() {
          _locationsMap = serverLocations;
          _districts = serverLocations.keys.toList()..sort();
        });
      }
    } catch (_) {
      // Gracefully fall back to local BangladeshLocations
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool birthDate}) async {
    final today = DateUtils.dateOnly(DateTime.now());
    final initialDate = birthDate
        ? (_dateOfBirth ?? DateTime(today.year - 25, today.month, today.day))
        : (_lastDonatedAt ?? today);
    final selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: today,
    );
    if (selected == null || !mounted) return;
    setState(() {
      if (birthDate) {
        _dateOfBirth = DateUtils.dateOnly(selected);
      } else {
        _lastDonatedAt = DateUtils.dateOnly(selected);
      }
    });
  }

  Future<void> _handleGpsLocation() async {
    setState(() => _isLocatingGps = true);
    try {
      final position = await _locationService.getPrecisePosition();
      if (!mounted) return;
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
        _selectedCoordinates =
            '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
        _hasGpsAcquired = true;
      });
      _showMessage(
        '${BloodStrings.locationAcquiredBadge}: $_selectedCoordinates',
        isError: false,
      );
    } on ForegroundLocationException catch (error) {
      if (!mounted) return;
      final retry = await LocationPermissionFallbackDialog.show(context);
      if (!mounted || !retry) return;
      if (error.failure == ForegroundLocationFailure.denied ||
          error.failure == ForegroundLocationFailure.serviceDisabled) {
        await _locationService.openRelevantSettings(error.failure);
      }
    } catch (_) {
      if (!mounted) return;
      _showMessage(BloodStrings.donorRealtimeLocationRequired, isError: true);
    } finally {
      if (mounted) setState(() => _isLocatingGps = false);
    }
  }

  Future<void> _pickLocationOnMap() async {
    final result = await AppRoutes.pushNamed<Map<String, String>>(
      context,
      AppRoutes.locationPicker,
      arguments: {
        'initialArea': _primaryUpazilla ?? _primaryDistrict ?? 'Dhanmondi',
      },
    );
    if (result == null || !mounted) return;
    setState(() {
      _latitude = double.tryParse(result['latitude'] ?? '') ?? _latitude;
      _longitude = double.tryParse(result['longitude'] ?? '') ?? _longitude;
      final precise = result['precise'] == 'true';
      if (_latitude != null && _longitude != null) {
        _selectedCoordinates =
            '${_latitude!.toStringAsFixed(6)}, ${_longitude!.toStringAsFixed(6)}';
        _hasGpsAcquired = precise;
      }
    });
  }

  Future<void> _saveProfileStep() async {
    if (_dateOfBirth == null || _sex == null) {
      _showMessage(BloodStrings.donorProfileRequired, isError: true);
      return;
    }
    final weightKg = double.tryParse(_weightController.text.trim());
    if (weightKg == null ||
        !weightKg.isFinite ||
        weightKg < 20 ||
        weightKg > 300) {
      _showMessage(BloodStrings.donorWeightRequired, isError: true);
      return;
    }
    if (_primaryDistrict == null ||
        _primaryUpazilla == null ||
        _secondaryDistrict == null ||
        _secondaryUpazilla == null) {
      _showMessage(BloodStrings.donorLocationsRequired, isError: true);
      return;
    }
    if (_latitude == null || _longitude == null) {
      _showMessage(BloodStrings.donorRealtimeLocationRequired, isError: true);
      return;
    }

    setState(() => _isSaving = true);
    try {
      final addressText = _addressController.text.trim().isNotEmpty
          ? _addressController.text.trim()
          : '$_primaryUpazilla, $_primaryDistrict';

      await client.donorProfile.saveMyProfile(
        dateOfBirth: DateTime.utc(
          _dateOfBirth!.year,
          _dateOfBirth!.month,
          _dateOfBirth!.day,
        ),
        sex: _sex!,
        bloodGroup: _selectedBloodGroup,
        bloodGroupSource: _bloodGroupSource,
        weightKg: weightKg,
        lastDonatedAt: _lastDonatedAt == null
            ? null
            : DateTime.utc(
                _lastDonatedAt!.year,
                _lastDonatedAt!.month,
                _lastDonatedAt!.day,
              ),
        apheresisWilling: _apheresisWilling,
        primaryArea: [_primaryDistrict!, _primaryUpazilla!],
        secondaryAreas: [_secondaryDistrict!, _secondaryUpazilla!],
        tertiaryAreas: (_tertiaryDistrict != null && _tertiaryUpazilla != null)
            ? [_tertiaryDistrict!, _tertiaryUpazilla!]
            : null,
        address: addressText,
        latitude: _latitude!,
        longitude: _longitude!,
        preferredCenters: _selectedHospitals.toList(),
      );
      if (mounted) setState(() => _step = 1);
    } on ServerpodClientException catch (error) {
      _showMessage(
        error.message.isEmpty
            ? BloodStrings.donorProfileSaveFailed
            : error.message,
        isError: true,
      );
    } on SocketException {
      _showMessage(BloodStrings.donorProfileSaveFailed, isError: true);
    } on TimeoutException {
      _showMessage(BloodStrings.donorProfileSaveFailed, isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _submitReadinessCheck() async {
    final weightKg = double.tryParse(_weightController.text.trim());
    if (weightKg == null ||
        !weightKg.isFinite ||
        weightKg < 20 ||
        weightKg > 300) {
      _showMessage(BloodStrings.donorWeightRequired, isError: true);
      return;
    }
    if (_answers.any((answer) => answer == null)) {
      _showMessage(BloodStrings.eligIncompleteWarning, isError: true);
      return;
    }

    setState(() => _isSaving = true);
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final passed = await client.donorProfile.submitReadinessCheck(
        weightKg: weightKg,
        answers: _answers.cast<bool>(),
        locale: AppLanguage.instance.isBangla ? 'bn' : 'en',
        appVersion: packageInfo.version,
      );
      if (!mounted) return;
      if (!passed) {
        _showMessage(BloodStrings.donorReadinessDeferredMessage, isError: true);
        return;
      }

      await AuthController.instance.saveDonorHealthDetails(
        bloodGroup: _selectedBloodGroup,
        area: '$_primaryUpazilla, $_primaryDistrict',
        locationCoordinates: _selectedCoordinates,
        preferredHospitals: _selectedHospitals.toList(),
      );
      if (!mounted) return;
      AppRoutes.replaceAll(context, AppRoutes.home);
    } on ServerpodClientException catch (error) {
      _showMessage(
        error.message.isEmpty
            ? BloodStrings.donorProfileSaveFailed
            : error.message,
        isError: true,
      );
    } on SocketException {
      _showMessage(BloodStrings.donorProfileSaveFailed, isError: true);
    } on TimeoutException {
      _showMessage(BloodStrings.donorProfileSaveFailed, isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showMessage(String message, {required bool isError}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? BloodColors.error : const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return BloodStrings.selectDate;
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final questions = _readinessQuestions;
    return ListenableBuilder(
      listenable: AppLanguage.instance,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            _step == 0
                ? BloodStrings.donorStepOneTitle
                : BloodStrings.donorStepTwoTitle,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          leading: _step == 1
              ? IconButton(
                  onPressed: () => setState(() => _step = 0),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                )
              : null,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            children: [
              _stepIndicator(),
              const SizedBox(height: 16),
              Text(
                _step == 0
                    ? BloodStrings.donorHealthSubtitle
                    : BloodStrings.donorReadinessDraftNote,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark
                      ? BloodColors.textSecondaryDark
                      : BloodColors.textSecondaryLight,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              if (_step == 0) ..._buildProfileStep(isDark),
              if (_step == 1) ..._buildReadinessStep(isDark, questions),
              const SizedBox(height: 28),
              BloodButton(
                text: _step == 0
                    ? BloodStrings.donorContinue
                    : BloodStrings.donorSubmitReadiness,
                icon: _step == 0 ? Icons.arrow_forward_rounded : Icons.check,
                isLoading: _isSaving,
                onPressed: _isSaving
                    ? null
                    : (_step == 0 ? _saveProfileStep : _submitReadinessCheck),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stepIndicator() => Row(
    children: [
      Expanded(
        child: Container(
          height: 6,
          decoration: BoxDecoration(
            color: BloodColors.primary,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Container(
          height: 6,
          decoration: BoxDecoration(
            color: _step == 1
                ? BloodColors.primary
                : BloodColors.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Text(
        _step == 0 ? '1 / 2' : '2 / 2',
        style: const TextStyle(
          color: BloodColors.primary,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );

  List<Widget> _buildProfileStep(bool isDark) => [
    _sectionLabel(BloodStrings.donorSexLabel, isDark),
    Wrap(
      spacing: 10,
      children: [
        _choiceChip('male', BloodStrings.donorSexMale),
        _choiceChip('female', BloodStrings.donorSexFemale),
      ],
    ),
    const SizedBox(height: 18),
    _sectionLabel(BloodStrings.donorDateOfBirthLabel, isDark),
    OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () => _pickDate(birthDate: true),
      icon: const Icon(
        Icons.calendar_month_rounded,
        color: BloodColors.primary,
      ),
      label: Text(
        _formatDate(_dateOfBirth),
        style: TextStyle(
          fontSize: 15,
          fontWeight: _dateOfBirth == null
              ? FontWeight.normal
              : FontWeight.w600,
        ),
      ),
    ),
    const SizedBox(height: 18),
    _sectionLabel(BloodStrings.bloodGroupLabel, isDark),
    Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _bloodGroups.map((group) {
        final selected = _selectedBloodGroup == group;
        return ChoiceChip(
          label: Text(group),
          selected: selected,
          selectedColor: BloodColors.primary,
          labelStyle: TextStyle(
            color: selected ? Colors.white : null,
            fontWeight: FontWeight.w700,
          ),
          onSelected: (value) {
            if (value) setState(() => _selectedBloodGroup = group);
          },
        );
      }).toList(),
    ),
    const SizedBox(height: 16),
    _sectionLabel(BloodStrings.donorBloodGroupSourceLabel, isDark),
    SegmentedButton<String>(
      segments: [
        ButtonSegment(
          value: 'self',
          label: Text(BloodStrings.donorBloodGroupSelf),
        ),
        ButtonSegment(
          value: 'lab',
          label: Text(BloodStrings.donorBloodGroupLab),
        ),
      ],
      selected: {_bloodGroupSource},
      onSelectionChanged: (value) =>
          setState(() => _bloodGroupSource = value.first),
    ),
    const SizedBox(height: 16),
    Card(
      elevation: 0,
      color: isDark
          ? BloodColors.surfaceDark
          : BloodColors.primary.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: BloodColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.monitor_weight_outlined,
                  color: BloodColors.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  BloodStrings.donorReadinessWeight,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                hintText: 'e.g. 65',
                suffixText: 'kg',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    const SizedBox(height: 16),
    _sectionLabel(BloodStrings.donorLastDonationLabel, isDark),
    OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () => _pickDate(birthDate: false),
      icon: const Icon(
        Icons.event_available_rounded,
        color: BloodColors.primary,
      ),
      label: Text(
        _lastDonatedAt == null
            ? BloodStrings.selectDate
            : _formatDate(_lastDonatedAt),
        style: TextStyle(
          fontSize: 15,
          fontWeight: _lastDonatedAt == null
              ? FontWeight.normal
              : FontWeight.w600,
        ),
      ),
    ),
    const SizedBox(height: 8),
    SwitchListTile.adaptive(
      contentPadding: EdgeInsets.zero,
      value: _apheresisWilling,
      title: Text(BloodStrings.donorApheresisLabel),
      onChanged: (value) => setState(() => _apheresisWilling = value),
    ),
    const Divider(height: 32),
    // Preferred Locations Section (Cascading Dropdowns)
    _sectionHeaderWithBadge(
      title: BloodStrings.primaryAreaTitle,
      isRequired: true,
      isDark: isDark,
    ),
    const SizedBox(height: 8),
    _buildCascadingLocationSelector(
      selectedDistrict: _primaryDistrict,
      selectedUpazila: _primaryUpazilla,
      onDistrictChanged: (newDistrict) {
        setState(() {
          _primaryDistrict = newDistrict;
          _primaryUpazilla = null;
        });
      },
      onUpazilaChanged: (newUpazila) {
        setState(() => _primaryUpazilla = newUpazila);
      },
      isDark: isDark,
    ),
    const SizedBox(height: 18),
    _sectionHeaderWithBadge(
      title: BloodStrings.secondaryAreaTitle,
      isRequired: true,
      isDark: isDark,
    ),
    const SizedBox(height: 8),
    _buildCascadingLocationSelector(
      selectedDistrict: _secondaryDistrict,
      selectedUpazila: _secondaryUpazilla,
      onDistrictChanged: (newDistrict) {
        setState(() {
          _secondaryDistrict = newDistrict;
          _secondaryUpazilla = null;
        });
      },
      onUpazilaChanged: (newUpazila) {
        setState(() => _secondaryUpazilla = newUpazila);
      },
      isDark: isDark,
    ),
    const SizedBox(height: 18),
    _sectionHeaderWithBadge(
      title: BloodStrings.tertiaryAreaTitle,
      isRequired: false,
      isDark: isDark,
    ),
    const SizedBox(height: 8),
    _buildCascadingLocationSelector(
      selectedDistrict: _tertiaryDistrict,
      selectedUpazila: _tertiaryUpazilla,
      allowClear: true,
      onDistrictChanged: (newDistrict) {
        setState(() {
          _tertiaryDistrict = newDistrict;
          _tertiaryUpazilla = null;
        });
      },
      onUpazilaChanged: (newUpazila) {
        setState(() => _tertiaryUpazilla = newUpazila);
      },
      isDark: isDark,
    ),
    const Divider(height: 32),
    // Realtime GPS Location Section
    _sectionLabel(BloodStrings.realtimeLocationSectionTitle, isDark),
    Text(
      BloodStrings.realtimeLocationDesc,
      style: TextStyle(
        fontSize: 13,
        color: isDark
            ? BloodColors.textSecondaryDark
            : BloodColors.textSecondaryLight,
      ),
    ),
    const SizedBox(height: 12),
    Card(
      elevation: 0,
      color: isDark
          ? BloodColors.surfaceDark
          : BloodColors.primary.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: _hasGpsAcquired
              ? const Color(0xFF10B981)
              : BloodColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: _hasGpsAcquired
                      ? const Color(0xFF10B981).withValues(alpha: 0.15)
                      : BloodColors.primary.withValues(alpha: 0.1),
                  child: Icon(
                    _hasGpsAcquired
                        ? Icons.my_location_rounded
                        : Icons.location_searching_rounded,
                    color: _hasGpsAcquired
                        ? const Color(0xFF10B981)
                        : BloodColors.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _hasGpsAcquired
                            ? BloodStrings.locationAcquiredBadge
                            : BloodStrings.useCurrentLocationGps,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: _hasGpsAcquired
                              ? const Color(0xFF10B981)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _selectedCoordinates,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? BloodColors.textSecondaryDark
                              : BloodColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _isLocatingGps ? null : _handleGpsLocation,
                    icon: _isLocatingGps
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.gps_fixed_rounded, size: 18),
                    label: Text(BloodStrings.getRealtimeLocationButton),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.outlined(
                  tooltip: BloodStrings.pickLocationOnMap,
                  onPressed: _pickLocationOnMap,
                  icon: const Icon(Icons.map_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    const SizedBox(height: 16),
    TextField(
      controller: _addressController,
      maxLength: 250,
      decoration: InputDecoration(
        labelText: BloodStrings.addressLabel,
        hintText: BloodStrings.addressHint,
        prefixIcon: const Icon(Icons.home_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    const SizedBox(height: 12),
    _sectionLabel(BloodStrings.preferredCentersLabel, isDark),
    Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _dhakaHospitals.map((hospital) {
        final selected = _selectedHospitals.contains(hospital);
        return FilterChip(
          label: Text(hospital),
          selected: selected,
          onSelected: (value) {
            setState(() {
              if (value) {
                _selectedHospitals.add(hospital);
              } else if (_selectedHospitals.length > 1) {
                _selectedHospitals.remove(hospital);
              }
            });
          },
        );
      }).toList(),
    ),
  ];

  Widget _buildCascadingLocationSelector({
    required String? selectedDistrict,
    required String? selectedUpazila,
    required ValueChanged<String?> onDistrictChanged,
    required ValueChanged<String?> onUpazilaChanged,
    required bool isDark,
    bool allowClear = false,
  }) {
    final upazilas = selectedDistrict != null
        ? (_locationsMap[selectedDistrict] ??
              BangladeshLocations.getUpazilas(selectedDistrict))
        : const <String>[];
    return Card(
      elevation: 0,
      color: isDark
          ? BloodColors.surfaceDark
          : BloodColors.surfaceLight.withValues(alpha: 0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isDark
              ? BloodColors.surfaceMutedDark
              : BloodColors.surfaceMutedLight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              initialValue: selectedDistrict,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: BloodStrings.selectDistrictLabel,
                prefixIcon: const Icon(
                  Icons.location_city_rounded,
                  color: BloodColors.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
              items: [
                if (allowClear)
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('— None —'),
                  ),
                ..._districts.map(
                  (d) => DropdownMenuItem(value: d, child: Text(d)),
                ),
              ],
              onChanged: onDistrictChanged,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: upazilas.contains(selectedUpazila)
                  ? selectedUpazila
                  : null,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: BloodStrings.selectUpazilaLabel,
                prefixIcon: const Icon(
                  Icons.place_rounded,
                  color: BloodColors.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
              hint: Text(
                selectedDistrict == null
                    ? 'First select a district'
                    : 'Choose Upazila/Thana',
              ),
              items: upazilas
                  .map(
                    (u) => DropdownMenuItem(value: u, child: Text(u)),
                  )
                  .toList(),
              onChanged: selectedDistrict == null ? null : onUpazilaChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeaderWithBadge({
    required String title,
    required bool isRequired,
    required bool isDark,
  }) => Row(
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: isDark
              ? BloodColors.textPrimaryDark
              : BloodColors.textPrimaryLight,
        ),
      ),
      const SizedBox(width: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: isRequired
              ? BloodColors.primary.withValues(alpha: 0.12)
              : Colors.grey.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          isRequired ? 'MUST' : 'OPTIONAL',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: isRequired ? BloodColors.primary : Colors.grey,
          ),
        ),
      ),
    ],
  );

  List<Widget> _buildReadinessStep(bool isDark, List<String> questions) => [
    _sectionLabel(BloodStrings.eligibilityHeader, isDark),
    for (var index = 0; index < questions.length; index++)
      _readinessQuestion(index, questions[index], isDark),
  ];

  Widget _readinessQuestion(int index, String question, bool isDark) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: isDark
            ? BloodColors.surfaceMutedDark
            : BloodColors.surfaceMutedLight,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: isDark
                  ? BloodColors.textPrimaryDark
                  : BloodColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 10),
          SegmentedButton<bool>(
            segments: [
              ButtonSegment(
                value: true,
                label: Text(BloodStrings.donorReadinessYes),
              ),
              ButtonSegment(
                value: false,
                label: Text(BloodStrings.donorReadinessNo),
              ),
            ],
            selected: _answers[index] == null ? {} : {_answers[index]!},
            onSelectionChanged: (value) =>
                setState(() => _answers[index] = value.first),
          ),
        ],
      ),
    ),
  );

  Widget _choiceChip(String value, String label) => ChoiceChip(
    label: Text(label),
    selected: _sex == value,
    selectedColor: BloodColors.primary,
    labelStyle: TextStyle(
      color: _sex == value ? Colors.white : null,
      fontWeight: FontWeight.w700,
    ),
    onSelected: (selected) {
      if (selected) setState(() => _sex = value);
    },
  );

  Widget _sectionLabel(String text, bool isDark) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: isDark
            ? BloodColors.textPrimaryDark
            : BloodColors.textPrimaryLight,
      ),
    ),
  );
}
