import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_pic_day/shared/client_dio/client_dio.dart';
import 'package:nasa_pic_day/shared/helpers/consts.dart' as config;

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ClientDioApi(Dio(), config.API_BASE_URL))
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
  ];
}
