import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_pic_day/app/modules/home/domain/usecases/get_planetary_usecase.dart';
import 'package:nasa_pic_day/app/modules/home/presentation/home/controllers/home_store.dart';

class GetPlanetaryUseCaseMock extends Mock implements GetPlanetaryUseCase {}

void main() {
  late GetPlanetaryUseCaseMock getPlanetaryUseCaseSpy;
  late HomeStore store;

  setUpAll(() {
    getPlanetaryUseCaseSpy = GetPlanetaryUseCaseMock();
    store = HomeStore(getPlanetaryUseCaseSpy);
  });

  group('HomeStore', () {
    test('state should initialize empty', () {
      expect(store.state.length, 0);
    });

    test('isGetMorePlanetary should initialize false', () {
      expect(store.isGetMorePlanetary, false);
    });

    test('controllerSearch should initialize empty', () {
      expect(store.controllerSearch.text.isEmpty, true);
    });
  });
}
