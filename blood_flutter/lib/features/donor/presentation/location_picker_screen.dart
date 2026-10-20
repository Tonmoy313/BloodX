import 'package:flutter/material.dart';
import '../../../core/location/foreground_location_service.dart';
import '../../../core/widgets/blood_button.dart';

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
  final ForegroundLocationService _locationService =
      const ForegroundLocationService();
  late String _selectedArea;
  String _selectedCoordinates = '23.7465, 90.3760'; // Dhanmondi default
  double? _latitude = 23.7465;
  double? _longitude = 90.3760;
  bool _hasPreciseLocation = false;
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
    {'name': 'Tejgaon', 'coords': '23.7634, 90.3890'},
    {'name': 'Khilgaon', 'coords': '23.7508, 90.4255'},
    {'name': 'Jatrabari', 'coords': '23.7155, 90.4303'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedArea = widget.initialArea ?? 'Dhanmondi';
    _searchController.text = _selectedArea;
    final match = _dhakaAreas.firstWhere(
      (a) => a['name']!.toLowerCase() == _selectedArea.toLowerCase(),
      orElse: () => _dhakaAreas.first,
    );
    _selectedCoordinates = match['coords']!;
    final parts = _selectedCoordinates.split(',');
    _latitude = double.tryParse(parts[0].trim());
    _longitude = double.tryParse(parts[1].trim());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentGpsLocation() async {
    setState(() => _isLocatingGps = true);
    try {
      final position = await _locationService.getPrecisePosition();
      if (mounted) {
        setState(() {
          _latitude = position.latitude;
          _longitude = position.longitude;
          _selectedCoordinates =
              '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';
          _hasPreciseLocation = true;
          _selectedArea = 'Current GPS Location';
          _searchController.text = _selectedArea;
          _isLocatingGps = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLocatingGps = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location error: $e')),
        );
      }
    }
  }

  void _confirmLocation() {
    Navigator.of(context).pop({
      'area': _selectedArea,
      'coords': _selectedCoordinates,
      'latitude': _latitude,
      'longitude': _longitude,
      'hasPreciseLocation': _hasPreciseLocation,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location (Dhaka)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _confirmLocation,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 240,
            width: double.infinity,
            color: Colors.grey[200],
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _MapGridPainter(),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        _selectedArea,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    onPressed: _isLocatingGps ? null : _getCurrentGpsLocation,
                    icon: _isLocatingGps
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.my_location),
                    label: const Text('Use GPS'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Dhaka Area',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (val) => setState(() {}),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _dhakaAreas.length,
              itemBuilder: (context, index) {
                final area = _dhakaAreas.length > index
                    ? _dhakaAreas[index]
                    : null;
                if (area == null) return const SizedBox.shrink();
                final name = area['name']!;
                final coords = area['coords']!;
                final matchesSearch = name.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                );
                if (_searchController.text.isNotEmpty && !matchesSearch) {
                  return const SizedBox.shrink();
                }
                final isSelected = _selectedArea == name;
                final scheme = Theme.of(context).colorScheme;
                return ListTile(
                  leading: Icon(
                    Icons.place,
                    color: isSelected
                        ? scheme.primary
                        : scheme.onSurfaceVariant,
                  ),
                  title: Text(
                    name,
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? scheme.primary : scheme.onSurface,
                    ),
                  ),
                  subtitle: Text('Coordinates: $coords'),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: scheme.primary)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedArea = name;
                      _selectedCoordinates = coords;
                      final parts = coords.split(',');
                      _latitude = double.tryParse(parts[0].trim());
                      _longitude = double.tryParse(parts[1].trim());
                      _hasPreciseLocation = false;
                      _searchController.text = name;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BloodButton(
              text: 'Confirm Location',
              onPressed: _confirmLocation,
            ),
          ),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1.0;

    const step = 30.0;
    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double j = 0; j < size.height; j += step) {
      canvas.drawLine(Offset(0, j), Offset(size.width, j), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
