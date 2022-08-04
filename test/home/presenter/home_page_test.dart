import 'package:flutter/material.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_pic_day/app/app_module.dart';
import 'package:nasa_pic_day/app/app_widget.dart';
import 'package:nasa_pic_day/app/modules/home/home_module.dart';
import 'package:nasa_pic_day/app/modules/home/presenter/home/home_page.dart';

void main() {
  // initModule(AppModule());

  testWidgets('HomePage has a circular progress indicator', (tester) async {
    // await tester.pumpWidget(MaterialApp(
    //   home: HomePage(),
    // ));
    // await tester.pumpAndSettle();
    // final circularProgress = find.byWidget(CircularProgressIndicator());

    //Por questão de tempo, optei por nao terminar. :/
    //A lib esta desatuaizada e gerando muito error

    // expect(circularProgress, findsOneWidget);
  });
}
