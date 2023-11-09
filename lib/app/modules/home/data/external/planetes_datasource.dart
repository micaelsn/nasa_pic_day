//

import 'package:dio/dio.dart';
import 'package:nasa_pic_day/app/modules/home/domain/entities/planetary.dart';
import 'package:nasa_pic_day/app/modules/home/data/infra/models/planetary_model.dart';
import 'package:nasa_pic_day/shared/client_dio/client_dio.dart';
import 'package:nasa_pic_day/shared/helpers/consts.dart' as config;
import 'package:nasa_pic_day/shared/helpers/errors.dart';

import '../infra/data/datasource/get_planetary_datasource.dart';

class GetPlanetaryDatasourceImpl implements GetPlanetaryDatasource {
  final ClientDio client;

  GetPlanetaryDatasourceImpl(this.client);

  @override
  Future<List<Planetary>> getPlanetary(
      {String? dateStart, String? dateEnd}) async {
    List<Planetary> listPanetary = [];
    try {
      final response =
          await client.client.get("/planetary/apod", queryParameters: {
        "api_key": config.APIKEY,
        "start_date": dateStart,
        "end_date": dateEnd,
        "thumbs": true
      });

      if (response.statusCode == 200) {
        listPanetary = (response.data as List)
            .map((e) => PlanetaryModel.fromMap(e))
            .toList();
      }
    } on DioError catch (_) {
      throw ServerFailure(message: "Ops... Falha na requisição");
    } on Exception catch (_) {
      throw DatasourceError(message: "Ops... Erro ao realizar requisição");
    }
    return listPanetary;
  }
}
