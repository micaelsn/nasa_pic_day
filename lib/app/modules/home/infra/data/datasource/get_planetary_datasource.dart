import '../../../domain/entities/planetary.dart';

abstract class GetPlanetaryDatasource {
  Future<List<dynamic>> getPlanetary({String? dateStart, String? dateEnd});
}
