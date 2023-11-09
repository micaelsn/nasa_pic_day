import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_pic_day/shared/helpers/errors.dart';
import 'package:nasa_pic_day/shared/helpers/formater.dart';

import '../../../domain/entities/planetary.dart';
import '../../../domain/usecases/get_planetary_usecase.dart';

class HomeStore extends NotifierStore<Failure, List<Planetary>> {
  final GetPlanetaryUseCase getPlanetaryUseCase;
  var controllerSearch = TextEditingController();
  bool isGetMorePlanetary = false;
  late String dateStart;
  late String dateEnd;

  HomeStore(this.getPlanetaryUseCase) : super([]);

  init() async {
    var today = DateTime.now();
    var teenDaysAgo = DateTime(today.year, today.month, today.day - 10);

    dateStart = dateFormatterDateTime(teenDaysAgo);
    dateEnd = dateFormatterDateTime(today);

    await getPlanetary(
      dateStart,
      dateEnd,
    );
  }

  getMorePlanetary() async {
    isGetMorePlanetary = true;
    var date = DateTime.parse(dateStart);
    var threeDaysAgo = DateTime(date.year, date.month, date.day - 1);

    var result = await getPlanetaryUseCase(
        dateStart: dateFormatterDateTime(threeDaysAgo),
        dateEnd: dateFormatterDateTime(threeDaysAgo));

    result.fold(
        (l) => setError(l),
        (r) => {
              update([...state, ...(r as List<Planetary>)]),
              dateStart = dateFormatterDateTime(threeDaysAgo)
            });

    isGetMorePlanetary = false;
  }

  getDateStart(BuildContext context) async {
    var initialDate = DateTime.parse(dateStart);

    var pickDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickDate != null) {
      dateStart = dateFormatterDateTime(pickDate);
      getPlanetary(
        dateStart,
        dateEnd,
      );
    }
  }

  getDateEnd(BuildContext context) async {
    var initialDate = DateTime.parse(dateEnd);

    var pickDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickDate != null) {
      dateEnd = dateFormatterDateTime(pickDate);
      getPlanetary(
        dateStart,
        dateEnd,
      );
    }
  }

  Future<void> getPlanetary(String dateStart, String dateEnd) async {
    setLoading(true);

    var result =
        await getPlanetaryUseCase(dateStart: dateStart, dateEnd: dateEnd);

    result.fold((l) => setError(l), (r) => update(r.reversed.toList()));

    setLoading(false);
  }

  void searchByString(String text) {
    if (text.length > 2) {
      update(state
          .where((element) =>
              element.title.toLowerCase().contains(text.toLowerCase()) ||
              element.date.contains(text.toLowerCase()))
          .toList());
    } else if (text.isEmpty) {
      init();
    }
  }
}
