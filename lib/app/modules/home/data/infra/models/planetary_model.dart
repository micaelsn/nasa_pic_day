import 'dart:convert';

import 'package:nasa_pic_day/shared/helpers/formater.dart';

import '../../../domain/entities/planetary.dart';

class PlanetaryModel extends Planetary {
  PlanetaryModel(
      {required super.copyright,
      required super.date,
      required super.explanation,
      required super.hdurl,
      required super.mediaType,
      required super.serviceVersion,
      required super.title,
      required super.url});

  Map<String, dynamic> toMap() {
    return {
      'copyright': copyright,
      'date': date,
      'explanation': explanation,
      'hdurl': hdurl,
      'media_type': mediaType,
      'service_version': serviceVersion,
      'title': title,
      'url': url,
    };
  }

  factory PlanetaryModel.fromMap(Map<String, dynamic> map) {
    return PlanetaryModel(
      copyright: map['copyright'] ?? '',
      date: map['date'] != null ? dateFormatter(map['date']) : '',
      explanation: map['explanation'] ?? '',
      hdurl: map['hdurl'] ?? '',
      mediaType: map['media_type'] ?? '',
      serviceVersion: map['service_version'] ?? '',
      title: map['title'] ?? '',
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanetaryModel.fromJson(String source) =>
      PlanetaryModel.fromMap(json.decode(source));
}
