import 'package:json_annotation/json_annotation.dart';
import '../json_map.dart';
import '../conversion_function.dart';
import 'dart:developer' as dev;

part 'air_quality.g.dart';

// https://air-quality-api.open-meteo.com/v1/air-quality?latitude=52.52&longitude=13.41&current=us_aqi,uv_index

@JsonSerializable(createToJson: false)
class AirQuality {
  @JsonKey(name: 'us_aqi', fromJson: airQualityStatusFromIndex)
  final AirQualityStatus usAQI;
  @JsonKey(name: 'uv_index', fromJson: uvIndexStatusFromIndex)
  final UvIndexStatus uvIndex;

  const AirQuality({required this.usAQI, required this.uvIndex});

  factory AirQuality.fromJson(JsonMap json) => _$AirQualityFromJson(json);

  void logAirQuality() {
    dev.log('<--------------------------->');
    dev.log(usAQI.toString());
    dev.log('<--------------------------->');
    dev.log(uvIndex.toString());
    dev.log('<--------------------------->');
  }
}
