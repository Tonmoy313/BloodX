import 'package:blood_flutter/core/data/bangladesh_locations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BangladeshLocations', () {
    test('contains all 64 districts', () {
      expect(BangladeshLocations.districts.length, 64);
      expect(BangladeshLocations.districts.contains('Dhaka'), isTrue);
      expect(BangladeshLocations.districts.contains('Chattogram'), isTrue);
      expect(BangladeshLocations.districts.contains('Sylhet'), isTrue);
    });

    test('returns upazilas for Dhaka and other districts', () {
      final dhakaUpazilas = BangladeshLocations.getUpazilas('Dhaka');
      expect(dhakaUpazilas, contains('Dhanmondi'));
      expect(dhakaUpazilas, contains('Mirpur'));
      expect(dhakaUpazilas, contains('Uttara'));

      final ctgUpazilas = BangladeshLocations.getUpazilas('Chattogram');
      expect(ctgUpazilas, contains('Panchlaish'));
    });

    test('returns empty list for null or unknown district', () {
      expect(BangladeshLocations.getUpazilas(null), isEmpty);
      expect(BangladeshLocations.getUpazilas(''), isEmpty);
      expect(BangladeshLocations.getUpazilas('NonExistent'), isEmpty);
    });
  });
}
