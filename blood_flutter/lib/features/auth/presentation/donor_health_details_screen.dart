import 'package:flutter/material.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/blood_colors.dart';
import '../../../core/widgets/blood_button.dart';
import '../controllers/auth_controller.dart';

/// S8: Donor Health Details Screen per spec/auth.md and spec/donor.md.
/// Captures blood group, medical eligibility declaration, location (links to S9),
/// and preferred hospital centers.
class DonorHealthDetailsScreen extends StatefulWidget {
  const DonorHealthDetailsScreen({super.key});

  @override
  State<DonorHealthDetailsScreen> createState() =>
      _DonorHealthDetailsScreenState();
}

class _DonorHealthDetailsScreenState extends State<DonorHealthDetailsScreen> {
  String _selectedBloodGroup = 'O+';
  String _selectedArea = 'Dhanmondi';
  String _selectedCoordinates = '23.7465, 90.3760';

  // 5 Required medical screening checkboxes (D-014, D-016)
  bool _checkAge = true;
  bool _checkWeight = true;
  bool _checkHealth = true;
  bool _checkCooldown = true;
  bool _checkMedication = true;

  final Set<String> _selectedHospitals = {'Dhaka Medical College Hospital (DMCH)'};

  final List<String> _bloodGroups = [
    'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'
  ];

  final List<String> _dhakaHospitals = [
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

  bool get _allEligibilityPassed =>
      _checkAge && _checkWeight && _checkHealth && _checkCooldown && _checkMedication;

  Future<void> _pickLocationOnMap() async {
    // S9: Pick current location using Google Map
    final result = await AppRoutes.pushNamed<Map<String, String>>(
      context,
      AppRoutes.locationPicker,
      arguments: {'initialArea': _selectedArea},
    );

    if (result != null && mounted) {
      setState(() {
        _selectedArea = result['area'] ?? _selectedArea;
        _selectedCoordinates = result['coordinates'] ?? _selectedCoordinates;
      });
    }
  }

  Future<void> _handleSave() async {
    if (!_allEligibilityPassed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(BloodStrings.eligIncompleteWarning),
          backgroundColor: BloodColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    await AuthController.instance.saveDonorHealthDetails(
      bloodGroup: _selectedBloodGroup,
      area: _selectedArea,
      locationCoordinates: _selectedCoordinates,
      preferredHospitals: _selectedHospitals.toList(),
    );

    if (!mounted) return;

    // Navigate to App home
    AppRoutes.replaceAll(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListenableBuilder(
      listenable: AppLanguage.instance,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              BloodStrings.donorHealthTitle,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    BloodStrings.donorHealthSubtitle,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDark
                          ? BloodColors.textSecondaryDark
                          : BloodColors.textSecondaryLight,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 1. Blood Group Selection
                  Text(
                    BloodStrings.bloodGroupLabel,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? BloodColors.textPrimaryDark
                          : BloodColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _bloodGroups.map((group) {
                      final isSelected = _selectedBloodGroup == group;
                      return ChoiceChip(
                        label: Text(group),
                        selected: isSelected,
                        selectedColor: BloodColors.primary,
                        backgroundColor: isDark
                            ? BloodColors.surfaceMutedDark
                            : BloodColors.surfaceMutedLight,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : (isDark
                                  ? BloodColors.textPrimaryDark
                                  : BloodColors.textPrimaryLight),
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected
                                ? BloodColors.primary
                                : (isDark ? Colors.grey[800]! : const Color(0xFFE5E7EB)),
                          ),
                        ),
                        onSelected: (val) {
                          if (val) {
                            setState(() {
                              _selectedBloodGroup = group;
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 28),

                  // 2. Location Area Field (Click triggers S9 Map Picker)
                  Text(
                    BloodStrings.locationFieldLabel,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? BloodColors.textPrimaryDark
                          : BloodColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _pickLocationOnMap,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: isDark
                            ? BloodColors.surfaceMutedDark
                            : BloodColors.surfaceMutedLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: BloodColors.primary.withValues(alpha: 0.4),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.map_rounded,
                            color: BloodColors.primary,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedArea,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: isDark
                                        ? BloodColors.textPrimaryDark
                                        : BloodColors.textPrimaryLight,
                                  ),
                                ),
                                Text(
                                  _selectedCoordinates,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark
                                        ? BloodColors.textMutedDark
                                        : BloodColors.textMutedLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: BloodColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              BloodStrings.pickLocationOnMap,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: BloodColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // 3. Medical Eligibility Screening Checkboxes
                  Text(
                    BloodStrings.eligibilityHeader,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? BloodColors.textPrimaryDark
                          : BloodColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildEligibilityTile(
                    title: BloodStrings.eligAge,
                    value: _checkAge,
                    onChanged: (v) => setState(() => _checkAge = v ?? false),
                    isDark: isDark,
                  ),
                  _buildEligibilityTile(
                    title: BloodStrings.eligWeight,
                    value: _checkWeight,
                    onChanged: (v) => setState(() => _checkWeight = v ?? false),
                    isDark: isDark,
                  ),
                  _buildEligibilityTile(
                    title: BloodStrings.eligHealth,
                    value: _checkHealth,
                    onChanged: (v) => setState(() => _checkHealth = v ?? false),
                    isDark: isDark,
                  ),
                  _buildEligibilityTile(
                    title: BloodStrings.eligCooldown,
                    value: _checkCooldown,
                    onChanged: (v) => setState(() => _checkCooldown = v ?? false),
                    isDark: isDark,
                  ),
                  _buildEligibilityTile(
                    title: BloodStrings.eligMedication,
                    value: _checkMedication,
                    onChanged: (v) => setState(() => _checkMedication = v ?? false),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 24),

                  // 4. Preferred Nearby Hospitals
                  Text(
                    BloodStrings.preferredHospitalsLabel,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? BloodColors.textPrimaryDark
                          : BloodColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _dhakaHospitals.map((hospital) {
                      final isSelected = _selectedHospitals.contains(hospital);
                      return FilterChip(
                        label: Text(
                          hospital,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? BloodColors.primary
                                : (isDark
                                    ? BloodColors.textSecondaryDark
                                    : BloodColors.textSecondaryLight),
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: BloodColors.primary.withValues(alpha: 0.15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: isSelected
                                ? BloodColors.primary
                                : (isDark ? Colors.grey[800]! : const Color(0xFFE5E7EB)),
                          ),
                        ),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedHospitals.add(hospital);
                            } else {
                              if (_selectedHospitals.length > 1) {
                                _selectedHospitals.remove(hospital);
                              }
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // D-016 Volunteer note callout
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark
                          ? BloodColors.surfaceMutedDark
                          : BloodColors.surfaceMutedLight,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isDark ? Colors.grey[800]! : const Color(0xFFE5E7EB),
                      ),
                    ),
                    child: Text(
                      BloodStrings.donorVolunteerNote,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? BloodColors.textMutedDark
                            : BloodColors.textMutedLight,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Save & Complete Button
                  BloodButton(
                    text: BloodStrings.saveAndProceed,
                    icon: Icons.check_circle_rounded,
                    onPressed: _handleSave,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEligibilityTile({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isDark
                ? BloodColors.textPrimaryDark
                : BloodColors.textPrimaryLight,
          ),
        ),
        activeColor: BloodColors.primary,
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        dense: true,
      ),
    );
  }
}
