import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nasa_pic_day/shared/helpers/errors.dart';

abstract class ClientDio {
  Dio client;

  ClientDio(this.client, String baseUrl) {
    if (baseUrl.isNotEmpty) {
      client.options.baseUrl = baseUrl;
      client.options.connectTimeout = 5000;
    }
  }
}

class ClientDioApi extends ClientDio {
  ClientDioApi(Dio client, String baseUrl) : super(client, baseUrl);

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    if (await checkInternetConnection()) {
      return await client.get(path, queryParameters: queryParameters);
    } else {
      throw InternetConnectionFailure(message: 'Error Connection');
    }
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {}
    return false;
  }
}
