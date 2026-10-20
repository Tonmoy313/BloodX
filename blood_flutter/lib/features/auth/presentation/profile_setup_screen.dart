import 'dart:io';

import 'package:blood_client/blood_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/localization/app_language.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/router/app_routes.dart';

import '../controllers/auth_controller.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  final _imagePicker = ImagePicker();
  Sex? _sex;
  DateTime? _dateOfBirth;
  String? _imagePath;
  String? _errorMessage;
  bool _isPickingImage = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _chooseImage() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(BloodStrings.takePhoto),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(BloodStrings.choosePhoto),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source != null) await _pickImage(source);
  }

  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      _isPickingImage = true;
      _errorMessage = null;
    });
    try {
      final image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1200,
      );
      if (image != null && mounted) {
        setState(() => _imagePath = image.path);
      }
    } on PlatformException catch (error) {
      debugPrint('Profile image selection failed: ${error.code}');
      if (mounted) {
        setState(
          () => _errorMessage = BloodStrings.profileImageSelectionFailed,
        );
      }
    } finally {
      if (mounted) setState(() => _isPickingImage = false);
    }
  }

  Future<void> _chooseDateOfBirth() async {
    final today = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: today,
    );
    if (selected != null) {
      setState(() {
        _dateOfBirth = DateTime.utc(
          selected.year,
          selected.month,
          selected.day,
        );
        _errorMessage = null;
      });
    }
  }

  Future<void> _continue() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _errorMessage = BloodStrings.profileNameRequired);
      return;
    }
    if (_sex == null) {
      setState(() => _errorMessage = BloodStrings.profileSexRequired);
      return;
    }
    if (_dateOfBirth == null) {
      setState(() => _errorMessage = BloodStrings.profileDateOfBirthRequired);
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });
    final saved = AuthController.instance.saveOnboardingProfile(
      name: name,
      sex: _sex!,
      dateOfBirth: _dateOfBirth!,
      imagePath: _imagePath,
    );
    if (!mounted) return;
    if (!saved) {
      setState(() {
        _isSubmitting = false;
        _errorMessage = BloodStrings.profileDetailsInvalid;
      });
      return;
    }

    final phone = AuthController.instance.state.rawPhone;
    await AppRoutes.replaceAll(
      context,
      AppRoutes.login,
      arguments: {'initialPhone': phone},
    );
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/${date.year}';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isBn = AppLanguage.instance.isBangla;

    return ListenableBuilder(
      listenable: AppLanguage.instance,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            BloodStrings.profileSetupTitle,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  BloodStrings.profileSetupSubtitle,
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 52,
                            backgroundColor: colors.primaryContainer,
                            backgroundImage: _imagePath == null
                                ? null
                                : FileImage(File(_imagePath!)),
                            onBackgroundImageError: _imagePath == null
                                ? null
                                : (_, _) => setState(() => _imagePath = null),
                            child: _imagePath == null
                                ? Icon(
                                    Icons.person_outline_rounded,
                                    size: 48,
                                    color: colors.onPrimaryContainer,
                                  )
                                : null,
                          ),
                          IconButton.filled(
                            onPressed: _isPickingImage ? null : _chooseImage,
                            tooltip: BloodStrings.profilePhotoLabel,
                            icon: _isPickingImage
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.edit_outlined, size: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        BloodStrings.profilePhotoLabel,
                        style: TextStyle(color: colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  BloodStrings.fullNameLabel,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  maxLength: 100,
                  decoration: InputDecoration(
                    hintText: BloodStrings.fullNameHint,
                    border: const OutlineInputBorder(),
                    counterText: '',
                  ),
                  onChanged: (_) {
                    if (_errorMessage != null) {
                      setState(() => _errorMessage = null);
                    }
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  BloodStrings.sexLabel,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _sexOption(
                        sex: Sex.male,
                        label: BloodStrings.maleLabel,
                        colors: colors,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _sexOption(
                        sex: Sex.female,
                        label: BloodStrings.femaleLabel,
                        colors: colors,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  BloodStrings.dateOfBirthLabel,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: _chooseDateOfBirth,
                  icon: const Icon(Icons.calendar_month_outlined),
                  label: Text(
                    _dateOfBirth == null
                        ? BloodStrings.chooseDateOfBirth
                        : _formatDate(_dateOfBirth!),
                  ),
                  style: OutlinedButton.styleFrom(
                    alignment: isBn
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: colors.error,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 28),
                FilledButton(
                  onPressed: _isSubmitting ? null : _continue,
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          BloodStrings.continueToLogin,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sexOption({
    required Sex sex,
    required String label,
    required ColorScheme colors,
  }) {
    final selected = _sex == sex;
    return ChoiceChip(
      label: Center(child: Text(label)),
      selected: selected,
      showCheckmark: true,
      onSelected: (_) {
        setState(() {
          _sex = sex;
          _errorMessage = null;
        });
      },
      labelStyle: TextStyle(
        color: selected ? colors.onPrimary : colors.onSurface,
        fontWeight: FontWeight.w600,
      ),
      selectedColor: colors.primary,
      backgroundColor: colors.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colors.outlineVariant),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    );
  }
}
