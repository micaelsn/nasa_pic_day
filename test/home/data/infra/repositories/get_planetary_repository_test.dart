import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_pic_day/app/modules/home/data/external/planetes_datasource.dart';
import 'package:nasa_pic_day/app/modules/home/domain/entities/planetary.dart';
import 'package:nasa_pic_day/app/modules/home/domain/repositories/get_planetary_repository.dart';
import 'package:nasa_pic_day/app/modules/home/data/infra/data/datasource/get_planetary_datasource.dart';
import 'package:nasa_pic_day/app/modules/home/data/infra/data/repositories/get_planetary_repository.dart';
import 'package:nasa_pic_day/shared/client_dio/client_dio.dart';
import 'package:nasa_pic_day/shared/helpers/errors.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late GetPlanetaryDatasource datasource;
  late GetPlanetaryRepository repository;
  late ClientDio api;
  late Dio dio;

  setUp(() {
    dio = MockDio();
    api = ClientDioApi(dio, "");
    datasource = GetPlanetaryDatasourceImpl(api);
    repository = GetPlanetaryRepositoryImpl(datasource);
  });

  group(GetPlanetaryRepositoryImpl, () {
    test(
        'getPlanetary should return a Planetary list and has length equals to 2',
        () async {
      // Arrange
      final bodyJson =
          File('test/assets/json/planetary_list.json').readAsStringSync();
      when(
        () => dio.get(any()),
      ).thenAnswer((_) async => Response(
          statusCode: 200, data: jsonDecode(bodyJson), requestOptions: any()));

      // Act
      var result = await repository.getPlanetary();
      final list = result.fold(id, id);

      // Assert
      verify(
        () => datasource.getPlanetary(),
      ).called(1);
      expect(list, isA<List<Planetary>>());
      expect((list as List).length, 2);
    });

    test('getPlanetary should return a ServerFailure when throws a BadRequest',
        () async {
      // Arrange
      when(
        () => datasource.getPlanetary(),
      ).thenThrow((_) async => ServerFailure());

      // Act
      var result = await repository.getPlanetary();

      // Assert
      verify(
        () => datasource.getPlanetary(),
      ).called(1);
      expect(
        result.fold(id, id),
        isA<DatasourceError>(),
      );
    });
  });
}
