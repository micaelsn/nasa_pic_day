import '../../../domain/entities/planetary.dart';

abstract class GetPlanetaryDatasource {
  Future<List<Planetary>> getPlanetary({String? dateStart, String? dateEnd});
}
