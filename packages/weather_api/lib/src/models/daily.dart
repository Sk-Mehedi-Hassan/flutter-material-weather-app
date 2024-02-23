// https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&daily=apparent_temperature_max,apparent_temperature_min,precipitation_probability_max
import 'package:json_annotation/json_annotation.dart';
import '../json_map.dart';
import '../conversion_function.dart';
import 'dart:developer' as dev;

part 'daily.g.dart';

@JsonSerializable(createToJson: false)
class Daily {
  @JsonKey(name: 'time', fromJson: dateTimeListFromIso8061)
  final List<DateTime> dailyTimeList;
  @JsonKey(name: 'apparent_temperature_max')
  final List<double> dailyApparentTemperatureMaxList;
  @JsonKey(name: 'apparent_temperature_min')
  final List<double> dailyApparentTemperatureMinList;
  @JsonKey(name: 'precipitation_probability_max')
  final List<int> dailyPrecipitationList;

  const Daily({
    required this.dailyTimeList,
    required this.dailyApparentTemperatureMaxList,
    required this.dailyApparentTemperatureMinList,
    required this.dailyPrecipitationList,
  });

  factory Daily.fromJson(JsonMap json) => _$DailyFromJson(json);

  void logDaily() {
    dev.log('<--------------------------->');
    for (var element in dailyTimeList) {
      dev.log(element.toString());
    }
    dev.log('<--------------------------->');
    for (var element in dailyApparentTemperatureMaxList) {
      dev.log(element.toString());
    }
    dev.log('<--------------------------->');
    for (var element in dailyApparentTemperatureMinList) {
      dev.log(element.toString());
    }
    dev.log('<--------------------------->');
    for (var element in dailyPrecipitationList) {
      dev.log(element.toString());
    }
    dev.log('<--------------------------->');
  }
}
