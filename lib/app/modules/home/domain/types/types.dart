import 'package:dartz/dartz.dart';
import 'package:nasa_pic_day/shared/helpers/errors.dart';

import '../entities/planetary.dart';

typedef ResultPlanetaries = Either<Failure, List<Planetary>>;
