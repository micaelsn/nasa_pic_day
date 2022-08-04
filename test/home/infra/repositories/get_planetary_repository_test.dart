import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_pic_day/app/modules/home/domain/entities/planetary.dart';
import 'package:nasa_pic_day/app/modules/home/infra/data/datasource/get_planetary_datasource.dart';
import 'package:nasa_pic_day/app/modules/home/infra/data/repositories/get_planetary_repository.dart';

class GetPlanetaryDatasourceMock extends Mock
    implements GetPlanetaryDatasource {}

void main() {
  final GetPlanetaryDatasource datasource = GetPlanetaryDatasourceMock();
  final repository = GetPlanetaryRepositoryImpl(datasource);
  test('getPlanetary should return a Planetary list and has length equals to 2',
      () async {
    when(
      () => datasource.getPlanetary(),
    ).thenAnswer((_) async => planetaryJson);

    var result = await repository.getPlanetary();
    final list = result.fold(id, id);
    expect(list, isA<List<Planetary>>());
    expect((list as List).length, 2);
  });
}

final planetaryJson = jsonDecode(r'''
[
    {
        "date": "2017-07-25",
        "explanation": "What if you were followed around by a cute floating ball that kept taking your picture? Then you might be an astronaut on today's International Space Station (ISS).  Designed by the Japan Aerospace Exploration Agency (JAXA), the JEM Internal Ball Camera -- informally \"Int-Ball\" -- is a bit larger than a softball, can float and maneuver by itself but also be controlled remotely, can take high resolution images and videos, and is not related to Hello Kitty.  Int-Ball was delivered to the ISS in early June and is designed to allow ground-control to increase the monitoring of ISS equipment and activities while decreasing time demands on human astronauts. Int-Ball moves by turning on small internal fans and sees with a camera located between its two dark eyes.",
        "hdurl": "https://apod.nasa.gov/apod/image/1707/ISSdrone_jaxa_4928.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Int-Ball Drone Activated on the Space Station",
        "url": "https://apod.nasa.gov/apod/image/1707/ISSdrone_jaxa_960.jpg"
    },
    {
        "copyright": "Tom Masterson",
        "date": "2017-07-26",
        "explanation": "You don't have to be at Monument Valley to see the Milky Way arc across the sky like this -- but it helps. Only at Monument Valley USA would you see a picturesque foreground that includes these iconic rock peaks called buttes. Buttes are composed of hard rock left behind after water has eroded away the surrounding soft rock.  In the featured image taken a month ago, the closest butte on the left and the butte to its right are known as the Mittens, while Merrick Butte can be seen farther to the right. Green airglow fans up from the horizon.  High overhead stretches a band of diffuse light that is the central disk of our spiral Milky Way Galaxy. The band of the Milky Way can be spotted by almost anyone on almost any clear night when far enough from a city and surrounding bright lights, but a sensitive digital camera is needed to capture these colors in a dark night sky.",
        "hdurl": "https://apod.nasa.gov/apod/image/1707/MonumentValley_Masterson_2048.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "The Milky Way over Monument Valley",
        "url": "https://apod.nasa.gov/apod/image/1707/MonumentValley_Masterson_1080.jpg"
    }
]
''');
