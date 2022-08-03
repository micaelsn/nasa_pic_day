import 'package:dartz/dartz.dart';

import 'package:nasa_pic_day/app/modules/home/domain/entities/planetary.dart';
import 'package:nasa_pic_day/shared/helpers/errors.dart';

import '../repositories/get_planetary_repository.dart';

abstract class GetPlanetaryUseCase {
  Future<Either<Failure, List<Planetary>>> call(
      {String? dateStart, String? dateEnd});
}

class GetPlanetaryUseCaseImpl implements GetPlanetaryUseCase {
  GetPlanetaryRepository repository;

  GetPlanetaryUseCaseImpl(
    this.repository,
  );

  @override
  Future<Either<Failure, List<Planetary>>> call(
          {String? dateStart, String? dateEnd}) =>
      repository.getPlanetary(
        dateStart: dateStart,
        dateEnd: dateEnd,
      );
}
