import 'package:dartz/dartz.dart';

import '../../../../../shared/helpers/errors.dart';
import '../entities/planetary.dart';

abstract class GetPlanetaryRepository {
  Future<Either<Failure, List<Planetary>>> getPlanetary(
      {String? dateStart, String? dateEnd});
}
