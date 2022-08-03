import 'package:dio/dio.dart';

abstract class ClientDio {
  Dio client;

  ClientDio(this.client, String baseUrl) {
    client.options.baseUrl = baseUrl;
    client.options.connectTimeout = 5000;
  }
}

class ClientDioApi extends ClientDio {
  ClientDioApi(Dio client, String baseUrl) : super(client, baseUrl);
}
