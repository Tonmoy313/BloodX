import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

enum ForegroundLocationFailure {
  denied,
  deniedForever,
  serviceDisabled,
  approximate,
}

class ForegroundLocationException implements Exception {
  const ForegroundLocationException(this.failure);

  final ForegroundLocationFailure failure;
}

class ForegroundLocationService {
  const ForegroundLocationService();

  Future<Position> getPrecisePosition() async {
    var permission = await Permission.locationWhenInUse.status;
    if (!permission.isGranted) {
      permission = await Permission.locationWhenInUse.request();
    }
    if (permission.isPermanentlyDenied || permission.isRestricted) {
      throw const ForegroundLocationException(
        ForegroundLocationFailure.deniedForever,
      );
    }
    if (!permission.isGranted) {
      throw const ForegroundLocationException(
        ForegroundLocationFailure.denied,
      );
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
          timeLimit: Duration(seconds: 15),
        ),
      );
      final accuracy = await Geolocator.getLocationAccuracy();
      if (accuracy != LocationAccuracyStatus.precise) {
        throw const ForegroundLocationException(
          ForegroundLocationFailure.approximate,
        );
      }
      return position;
    } on LocationServiceDisabledException {
      throw const ForegroundLocationException(
        ForegroundLocationFailure.serviceDisabled,
      );
    } on PermissionDeniedException {
      throw const ForegroundLocationException(
        ForegroundLocationFailure.denied,
      );
    }
  }

  Future<void> openRelevantSettings(ForegroundLocationFailure failure) async {
    final opened = switch (failure) {
      ForegroundLocationFailure.deniedForever ||
      ForegroundLocationFailure.approximate => await openAppSettings(),
      ForegroundLocationFailure.serviceDisabled =>
        await Geolocator.openLocationSettings(),
      ForegroundLocationFailure.denied => false,
    };
    if (!opened && failure != ForegroundLocationFailure.denied) {
      throw StateError('Could not open the required location settings.');
    }
  }
}
