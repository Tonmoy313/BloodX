import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/localization/blood_strings.dart';
import '../../../core/router/app_routes.dart';

import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/blood_button.dart';
import '../../auth/controllers/auth_controller.dart';

/// S8: Donor Health Details Screen per spec/auth.md and spec/donor.md.
/// Captures blood group, medical eligibility declaration, location (links to S9),
/// and preferred hospital centers. Uses BloodStrings and AppThemeController.
class DonorHealthDetailsScreen extends StatefulWidget {
  const DonorHealthDetailsScreen({super.key});

  @override
  State<DonorHealthDetailsScreen> createState() =>
      _DonorHealthDetailsScreenState();
}

class _DonorHealthDetailsScreenState extends State<DonorHealthDetailsScreen> {
  final TextEditingController _addressController = TextEditingController();
  String _selectedBloodGroup = 'O+';
  String _selectedArea = 'Dhanmondi';
  String _selectedCoordinates = '';
  bool _hasPreciseLocation = false;
  bool _isSaving = false;

  // 5 Required medical screening checkboxes (D-014, D-016)
  bool _checkAge = true;
  bool _checkWeight = true;
  bool _checkHealth = true;
  bool _checkInfectionFree = true;
  bool _checkNoMedication = true;

  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  @override
  void initState() {
    super.initState();
    AppThemeController.instance.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    AppThemeController.instance.removeListener(_onThemeChanged);
    _addressController.dispose();
    super.dispose();
  }

  void _onThemeChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _pickLocation() async {
    final result = await AppRoutes.pushNamed<Map<String, dynamic>>(
      context,
      AppRoutes.locationPicker,
      arguments: {'initialArea': _selectedArea},
    );
    if (result != null && mounted) {
      setState(() {
        _selectedArea = result['area'] as String? ?? _selectedArea;
        _selectedCoordinates = result['coords'] as String? ?? '';
        _hasPreciseLocation = result['hasPreciseLocation'] as bool? ?? false;
        _addressController.text = _selectedArea;
      });
    }
  }

  Future<void> _submitDonorHealth() async {
    if (!_checkAge ||
        !_checkWeight ||
        !_checkHealth ||
        !_checkInfectionFree ||
        !_checkNoMedication) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please confirm all medical eligibility requirements to register as a donor.',
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      AuthController.instance.setDonorOptIn(true);

      if (mounted) {
        setState(() => _isSaving = false);
        AppRoutes.replaceAll(context, AppRoutes.home);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(BloodStrings.donorProfileSaveFailed),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(BloodStrings.donorPromptTitle),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              AppThemeController.instance.isModern
                  ? Icons.palette
                  : Icons.color_lens,
            ),
            onPressed: () => AppThemeController.instance.togglePreset(),
            tooltip: BloodStrings.switchTheme,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                BloodStrings.donorPromptTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                BloodStrings.donorOptInNote,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Blood Group',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedBloodGroup,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.bloodtype,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                items: _bloodGroups
                    .map(
                      (group) => DropdownMenuItem(
                        value: group,
                        child: Text(
                          group,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedBloodGroup = val);
                },
              ),
              const SizedBox(height: 20),
              Text(
                BloodStrings.addressFieldLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: _pickLocation,
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    suffixIcon: const Icon(Icons.chevron_right),
                    hintText: BloodStrings.addressFieldHint,
                  ),
                  child: Text(
                    _addressController.text.isEmpty
                        ? BloodStrings.addressFieldHint
                        : _addressController.text,
                    style: TextStyle(
                      color: _addressController.text.isEmpty
                          ? Theme.of(context).colorScheme.onSurfaceVariant
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              if (_selectedCoordinates.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  'Coordinates: $_selectedCoordinates ${_hasPreciseLocation ? "(Precise GPS)" : "(Area default)"}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              const Text(
                'Medical Eligibility Screening (D-014, D-016)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Please confirm the following standard blood donation criteria:',
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              CheckboxListTile(
                title: const Text('I am between 18 and 60 years of age.'),
                value: _checkAge,
                onChanged: (val) => setState(() => _checkAge = val ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile(
                title: const Text('My weight is at least 50 kg (110 lbs).'),
                value: _checkWeight,
                onChanged: (val) => setState(() => _checkWeight = val ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile(
                title: const Text(
                  'I am in good general health and feeling well today.',
                ),
                value: _checkHealth,
                onChanged: (val) => setState(() => _checkHealth = val ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile(
                title: const Text(
                  'I am free from blood-borne infections (HIV, Hepatitis, etc.).',
                ),
                value: _checkInfectionFree,
                onChanged: (val) =>
                    setState(() => _checkInfectionFree = val ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile(
                title: const Text(
                  'I am not currently taking restricted medications (e.g., antibiotics).',
                ),
                value: _checkNoMedication,
                onChanged: (val) =>
                    setState(() => _checkNoMedication = val ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 32),
              BloodButton(
                text: BloodStrings.continueLabel,
                isLoading: _isSaving,
                onPressed: _submitDonorHealth,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  AuthController.instance.setDonorOptIn(false);
                  AppRoutes.replaceAll(context, AppRoutes.home);
                },
                child: Text(BloodStrings.maybeLater),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
