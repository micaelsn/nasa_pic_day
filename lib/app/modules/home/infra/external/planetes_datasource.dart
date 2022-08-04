//

import 'package:dio/dio.dart';
import 'package:nasa_pic_day/app/modules/home/domain/entities/planetary.dart';
import 'package:nasa_pic_day/app/modules/home/infra/models/planetary_model.dart';
import 'package:nasa_pic_day/shared/client_dio/client_dio.dart';
import 'package:nasa_pic_day/shared/helpers/consts.dart' as config;
import 'package:nasa_pic_day/shared/helpers/errors.dart';

import '../data/datasource/get_planetary_datasource.dart';

class GetPlanetaryDatasourceImpl implements GetPlanetaryDatasource {
  final ClientDioApi client;

  GetPlanetaryDatasourceImpl(this.client);

  @override
  Future<List<dynamic>> getPlanetary(
      {String? dateStart, String? dateEnd}) async {
    var listPanetary = <dynamic>[];
    try {
      final response = await client.get("/planetary/apod", queryParameters: {
        "api_key": config.APIKEY,
        "start_date": dateStart,
        "end_date": dateEnd,
        "thumbs": true
      });

      if (response.statusCode == 200) {
        listPanetary = response.data as List<dynamic>;
      }
    } on DioError catch (_) {
      throw DatasourceError(message: "Falha");
    }
    return listPanetary;
  }
}
