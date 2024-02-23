// https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m,precipitation_probability&forecast_days=1

import 'package:json_annotation/json_annotation.dart';
import '../json_map.dart';
import '../conversion_function.dart';
import 'dart:developer' as dev;

part 'hourly.g.dart';

@JsonSerializable(createToJson: false)
class Hourly {
  @JsonKey(name: 'time', fromJson: dateTimeListFromIso8061)
  final List<DateTime> hourlyTimeList;
  @JsonKey(name: 'temperature_2m')
  final List<double> hourlyTemperatureList;
  @JsonKey(name: 'precipitation_probability')
  final List<int> hourlyPrecipitationList;

  const Hourly({
    required this.hourlyTimeList,
    required this.hourlyTemperatureList,
    required this.hourlyPrecipitationList,
  });

  factory Hourly.fromJson(JsonMap json) => _$HourlyFromJson(json);

  void logHourly() {
    dev.log('<--------------------------->');
    for (var element in hourlyTimeList) {
      dev.log(element.toString());
    }
    dev.log('<--------------------------->');
    for (var element in hourlyTemperatureList) {
      dev.log(element.toString());
    }
    dev.log('<--------------------------->');
    for (var element in hourlyPrecipitationList) {
      dev.log(element.toString());
    }
    dev.log('<--------------------------->');
  }
}
