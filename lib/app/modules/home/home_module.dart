import 'package:flutter_modular/flutter_modular.dart';
import 'domain/repositories/get_planetary_repository.dart';
import 'domain/usecases/get_planetary_usecase.dart';
import 'infra/data/datasource/get_planetary_datasource.dart';
import 'infra/data/repositories/get_planetary_repository.dart';
import 'infra/external/planetes_datasource.dart';
import 'stores/home_store.dart';

import 'presenter/home/home_page.dart';
import 'presenter/picture_details/picture_details_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<GetPlanetaryUseCase>(
        (i) => GetPlanetaryUseCaseImpl(i())),
    Bind.lazySingleton<GetPlanetaryRepository>(
        (i) => GetPlanetaryRepositoryImpl(i())),
    Bind.lazySingleton<GetPlanetaryDatasource>(
        (i) => GetPlanetaryDatasourceImpl(i())),
    Bind.lazySingleton((i) => HomeStore(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
    ChildRoute('/picture-details',
        child: (_, args) => PictureDetailsPage(
              planetaryModel: args.data,
            )),
  ];
}
