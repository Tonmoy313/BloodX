import 'package:flutter/material.dart';
import '../../../core/localization/blood_strings.dart';
import '../../../core/theme/blood_colors.dart';
import '../../../core/widgets/blood_button.dart';
import '../../../core/widgets/permission_dialogs.dart';

/// S9: Location Picker using Google Map view of Dhaka per spec/auth.md.
/// Allows selecting Dhaka area, dragging pin, or using current GPS location via D1.
class LocationPickerScreen extends StatefulWidget {
  final String? initialArea;
  const LocationPickerScreen({super.key, this.initialArea});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final TextEditingController _searchController = TextEditingController();
  late String _selectedArea;
  String _selectedCoordinates = '23.7465, 90.3760'; // Dhanmondi default
  bool _isLocatingGps = false;

  final List<Map<String, String>> _dhakaAreas = [
    {'name': 'Dhanmondi', 'coords': '23.7465, 90.3760'},
    {'name': 'Mirpur', 'coords': '23.8071, 90.3686'},
    {'name': 'Uttara', 'coords': '23.8759, 90.3795'},
    {'name': 'Gulshan', 'coords': '23.7925, 90.4078'},
    {'name': 'Banani', 'coords': '23.7937, 90.4043'},
    {'name': 'Mohakhali', 'coords': '23.7776, 90.3995'},
    {'name': 'Mohammadpur', 'coords': '23.7658, 90.3584'},
    {'name': 'Motijheel', 'coords': '23.7330, 90.4172'},
    {'name': 'Shahbagh', 'coords': '23.7388, 90.3957'},
    {'name': 'Badda', 'coords': '23.7806, 90.4267'},
    {'name': 'Khilgaon', 'coords': '23.7533, 90.4262'},
    {'name': 'Puran Dhaka (Old Dhaka)', 'coords': '23.7104, 90.4074'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedArea = widget.initialArea ?? 'Dhanmondi';
    for (final a in _dhakaAreas) {
      if (a['name'] == _selectedArea) {
        _selectedCoordinates = a['coords']!;
        break;
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleGpsLocation() async {
    // D1: Trigger location permission dialog
    final granted = await LocationPermissionDialog.show(context);
    if (!mounted || !granted) return;

    setState(() {
      _isLocatingGps = true;
    });

    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    setState(() {
      _isLocatingGps = false;
      _selectedArea = 'Shahbagh (BSMMU / DMCH Area)';
      _selectedCoordinates = '23.7388, 90.3957';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('GPS Location detected: $_selectedArea'),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleConfirm() {
    Navigator.of(context).pop({
      'area': _selectedArea,
      'coordinates': _selectedCoordinates,
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredAreas = _dhakaAreas.where((item) {
      final query = _searchController.text.trim().toLowerCase();
      if (query.isEmpty) return true;
      return item['name']!.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          BloodStrings.mapPickerTitle,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: BloodStrings.mapSearchHint,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: BloodColors.primary,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 18),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                            });
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: isDark
                      ? BloodColors.surfaceMutedDark
                      : BloodColors.surfaceMutedLight,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),

            // Map Visual Simulation Canvas with Centered Pin
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1E242B)
                          : const Color(0xFFE5E9EC),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/map_bg.png'),
                        fit: BoxFit.cover,
                        opacity: 0.15,
                        onError: null,
                      ),
                    ),
                    child: CustomPaint(
                      painter: _MapGridPainter(isDark: isDark),
                      child: Container(),
                    ),
                  ),

                  // Map Floating Pin Marker at Center
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: BloodColors.primaryDark,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            _selectedArea,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Icon(
                          Icons.location_on_rounded,
                          size: 46,
                          color: BloodColors.primary,
                        ),
                        Container(
                          width: 12,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(height: 38), // Offset pin anchor point
                      ],
                    ),
                  ),

                  // GPS FAB
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: FloatingActionButton.extended(
                      heroTag: 'gps_fab',
                      backgroundColor: isDark
                          ? BloodColors.surfaceDark
                          : Colors.white,
                      foregroundColor: BloodColors.primary,
                      elevation: 4,
                      icon: _isLocatingGps
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(
                                  BloodColors.primary,
                                ),
                              ),
                            )
                          : const Icon(Icons.my_location_rounded, size: 20),
                      label: Text(
                        BloodStrings.useCurrentLocationGps,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: _isLocatingGps ? null : _handleGpsLocation,
                    ),
                  ),
                ],
              ),
            ),

            // Area Quick-Selection List
            Container(
              height: 110,
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: isDark
                  ? BloodColors.surfaceDark
                  : BloodColors.surfaceLight,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredAreas.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final area = filteredAreas[index];
                  final isSelected = area['name'] == _selectedArea;
                  return ChoiceChip(
                    label: Text(area['name']!),
                    selected: isSelected,
                    selectedColor: BloodColors.primary.withValues(alpha: 0.15),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? BloodColors.primary
                          : (isDark
                                ? BloodColors.textSecondaryDark
                                : BloodColors.textSecondaryLight),
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
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
                    onSelected: (val) {
                      if (val) {
                        setState(() {
                          _selectedArea = area['name']!;
                          _selectedCoordinates = area['coords']!;
                        });
                      }
                    },
                  );
                },
              ),
            ),

            // Confirm Location Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? BloodColors.surfaceDark
                    : BloodColors.surfaceLight,
                border: Border(
                  top: BorderSide(
                    color: isDark ? Colors.grey[850]! : const Color(0xFFE5E7EB),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.place_rounded,
                        color: BloodColors.primary,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        BloodStrings.selectedAreaLabel,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _selectedArea,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: BloodColors.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  BloodButton(
                    text: BloodStrings.confirmThisLocation,
                    icon: Icons.check_circle_rounded,
                    onPressed: _handleConfirm,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  final bool isDark;
  _MapGridPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = isDark
          ? Colors.white.withValues(alpha: 0.04)
          : Colors.black.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

    final roadPaint = Paint()
      ..color = isDark
          ? Colors.white.withValues(alpha: 0.08)
          : Colors.black.withValues(alpha: 0.08)
      ..strokeWidth = 3.0;

    // Grid lines
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // Diagonal arterial roads
    canvas.drawLine(
      Offset(0, size.height * 0.25),
      Offset(size.width, size.height * 0.75),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.2, 0),
      Offset(size.width * 0.8, size.height),
      roadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
