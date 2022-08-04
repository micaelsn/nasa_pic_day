import 'package:dartz/dartz.dart';

import 'package:nasa_pic_day/shared/helpers/errors.dart';

import '../../../domain/entities/planetary.dart';
import '../../../domain/repositories/get_planetary_repository.dart';
import '../datasource/get_planetary_datasource.dart';

class GetPlanetaryRepositoryImpl implements GetPlanetaryRepository {
  GetPlanetaryDatasource datasource;

  GetPlanetaryRepositoryImpl(
    this.datasource,
  );

  @override
  Future<Either<Failure, List<Planetary>>> getPlanetary(
      {String? dateStart, String? dateEnd}) async {
    try {
      var result =
          await datasource.getPlanetary(dateStart: dateStart, dateEnd: dateEnd);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
