import 'package:flutter/material.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/theme/blood_colors.dart';
import '../../../core/widgets/blood_button.dart';
import '../../../core/widgets/blood_text_field.dart';
import '../controllers/auth_controller.dart';
import '../../home/presentation/home_placeholder_screen.dart';

/// Register / Profile Completion Screen for new users.
/// Captures Name, Blood Group, and Area in Dhaka.
class RegisterProfileScreen extends StatefulWidget {
  const RegisterProfileScreen({super.key});

  @override
  State<RegisterProfileScreen> createState() => _RegisterProfileScreenState();
}

class _RegisterProfileScreenState extends State<RegisterProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  String? _selectedBloodGroup;
  String? _selectedArea = 'Dhanmondi';
  late bool _donorOptIn;
  String? _nameError;

  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  final List<String> _dhakaAreas = [
    'Dhanmondi',
    'Mirpur',
    'Uttara',
    'Gulshan',
    'Banani',
    'Mohakhali',
    'Mohammadpur',
    'Motijheel',
    'Badda',
    'Khilgaon',
    'Puran Dhaka (Old Dhaka)',
    'Bashundhara R/A',
  ];

  @override
  void initState() {
    super.initState();
    _donorOptIn = AuthController.instance.state.donorOptIn;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleComplete() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _nameError = BloodStrings.nameErrorEmpty;
      });
      return;
    }

    setState(() {
      _nameError = null;
    });

    await AuthController.instance.completeProfile(
      name: name,
      bloodGroup: _selectedBloodGroup ?? 'O+',
      area: _selectedArea ?? 'Dhanmondi',
      isDonor: _donorOptIn,
    );

    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomePlaceholderScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListenableBuilder(
      listenable: AppLanguage.instance,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(BloodStrings.registerTitle),
            actions: [
              TextButton.icon(
                onPressed: () => AppLanguage.instance.toggleLanguage(),
                icon: const Icon(
                  Icons.language_rounded,
                  size: 16,
                  color: BloodColors.primary,
                ),
                label: Text(
                  BloodStrings.languageToggleText,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: BloodColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    BloodStrings.registerTitle,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? BloodColors.textPrimaryDark
                          : BloodColors.textPrimaryLight,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    BloodStrings.registerSubtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? BloodColors.textSecondaryDark
                          : BloodColors.textSecondaryLight,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Full Name Field
                  BloodTextField(
                    label: BloodStrings.nameFieldLabel,
                    hintText: BloodStrings.nameFieldHint,
                    controller: _nameController,
                    errorText: _nameError,
                    prefix: const Icon(
                      Icons.person_outline_rounded,
                      color: BloodColors.primary,
                      size: 20,
                    ),
                    onChanged: (val) {
                      if (_nameError != null) {
                        setState(() {
                          _nameError = null;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),

                  // Blood Group Selection Chips
                  Text(
                    BloodStrings.bloodGroupLabel,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? BloodColors.textPrimaryDark
                          : BloodColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _bloodGroups.map((group) {
                      final isSelected = _selectedBloodGroup == group;
                      return ChoiceChip(
                        label: Text(
                          group,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? Colors.white
                                : (isDark
                                      ? BloodColors.textPrimaryDark
                                      : BloodColors.textPrimaryLight),
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: BloodColors.primary,
                        backgroundColor: isDark
                            ? BloodColors.surfaceMutedDark
                            : BloodColors.surfaceMutedLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected
                                ? BloodColors.primary
                                : (isDark
                                      ? Colors.grey[800]!
                                      : const Color(0xFFE5E7EB)),
                          ),
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _selectedBloodGroup = selected ? group : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Area Selection (Dhaka)
                  Text(
                    BloodStrings.areaLabel,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? BloodColors.textPrimaryDark
                          : BloodColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? BloodColors.surfaceMutedDark
                          : BloodColors.surfaceMutedLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xFF2D2A32)
                            : const Color(0xFFE5E7EB),
                        width: 1.2,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedArea,
                        isExpanded: true,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: BloodColors.primary,
                        ),
                        dropdownColor: isDark
                            ? BloodColors.surfaceDark
                            : BloodColors.surfaceLight,
                        items: _dhakaAreas.map((area) {
                          return DropdownMenuItem<String>(
                            value: area,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 18,
                                  color: BloodColors.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  area,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: isDark
                                        ? BloodColors.textPrimaryDark
                                        : BloodColors.textPrimaryLight,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (newArea) {
                          setState(() {
                            _selectedArea = newArea;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Volunteer Donor Switch Card (D-015: Opt-in)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? BloodColors.surfaceMutedDark
                          : BloodColors.surfaceMutedLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _donorOptIn
                            ? BloodColors.primary.withValues(alpha: 0.4)
                            : (isDark
                                  ? Colors.grey[850]!
                                  : const Color(0xFFE5E7EB)),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                BloodStrings.donorOptInCheckbox,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? BloodColors.textPrimaryDark
                                      : BloodColors.textPrimaryLight,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                BloodStrings.donorOptInNote,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark
                                      ? BloodColors.textMutedDark
                                      : BloodColors.textMutedLight,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _donorOptIn,
                          activeThumbColor: BloodColors.primary,
                          onChanged: (val) {
                            setState(() {
                              _donorOptIn = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Complete Button
                  BloodButton(
                    text: BloodStrings.completeRegistrationButton,
                    icon: Icons.check_rounded,
                    onPressed: _handleComplete,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
