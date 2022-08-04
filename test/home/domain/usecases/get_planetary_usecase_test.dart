import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_pic_day/app/modules/home/domain/entities/planetary.dart';
import 'package:nasa_pic_day/app/modules/home/domain/repositories/get_planetary_repository.dart';
import 'package:nasa_pic_day/app/modules/home/domain/usecases/get_planetary_usecase.dart';

class GetPlanetaryRepositoryMock extends Mock
    implements GetPlanetaryRepository {}

void main() {
  final repository = GetPlanetaryRepositoryMock();
  final usecase = GetPlanetaryUseCaseImpl(repository);
  test('Should return a list of Planetary', () async {
    when(() => repository.getPlanetary(
            dateStart: '2017-07-25', dateEnd: '2017-08-3'))
        .thenAnswer((invocation) async => const Right([]));

    final result = await usecase(dateStart: '2017-07-25', dateEnd: '2017-08-3');

    expect(result.fold(id, id), isA<List<Planetary>>());
  });
}
