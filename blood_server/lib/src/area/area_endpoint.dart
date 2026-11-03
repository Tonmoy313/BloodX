import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class AreaEndpoint extends Endpoint {
  /// Unauthenticated endpoint: allows client to fetch available districts and upazilas
  @override
  bool get requireLogin => false;

  /// Returns the distinct list of all 64 districts in Bangladesh.
  Future<List<String>> getDistricts(Session session) async {
    final districts = await Area.db.find(
      session,
      where: (row) => row.type.equals(AreaType.district),
      orderBy: (row) => row.name,
    );
    return districts.map((a) => a.name).toList(growable: false);
  }

  /// Returns upazilas for a given district.
  Future<List<String>> getUpazilas(
    Session session, {
    required String district,
  }) async {
    final upazilas = await Area.db.find(
      session,
      where: (row) =>
          row.type.equals(AreaType.upazilla) & row.district.equals(district),
      orderBy: (row) => row.name,
    );
    return upazilas.map((a) => a.name).toList(growable: false);
  }

  /// Returns a map of District -> List of Upazilas.
  Future<Map<String, List<String>>> getAllLocations(Session session) async {
    final allAreas = await Area.db.find(
      session,
      where: (row) => row.type.equals(AreaType.upazilla),
      orderBy: (row) => row.name,
    );
    final result = <String, List<String>>{};
    for (final area in allAreas) {
      result.putIfAbsent(area.district, () => []).add(area.name);
    }
    return result;
  }
}
