import '../repositories/get_planetary_repository.dart';
import '../types/types.dart';

abstract class GetPlanetaryUseCase {
  Future<ResultPlanetaries> call({String? dateStart, String? dateEnd});
}

class GetPlanetaryUseCaseImpl implements GetPlanetaryUseCase {
  GetPlanetaryRepository repository;

  GetPlanetaryUseCaseImpl(
    this.repository,
  );

  @override
  Future<ResultPlanetaries> call({String? dateStart, String? dateEnd}) =>
      repository.getPlanetary(
        dateStart: dateStart,
        dateEnd: dateEnd,
      );
}
