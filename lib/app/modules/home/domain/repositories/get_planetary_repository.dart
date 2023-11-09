import '../types/types.dart';

abstract class GetPlanetaryRepository {
  Future<ResultPlanetaries> getPlanetary({String? dateStart, String? dateEnd});
}
