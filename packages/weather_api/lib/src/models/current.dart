import 'package:json_annotation/json_annotation.dart';
import 'package:weather_api/src/conversion_function.dart';
import '../json_map.dart';
import 'dart:developer' as dev;

part 'current.g.dart';

// https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,pressure_msl,surface_pressure,wind_speed_10m
@JsonSerializable(createToJson: false)
class Current {
  @JsonKey(name: 'time', fromJson: dateTimeFromIso8061)
  final DateTime time;
  @JsonKey(name: 'temperature_2m')
  final double temperature;
  @JsonKey(name: 'relative_humidity_2m')
  final int relativeHumidity;
  @JsonKey(name: 'apparent_temperature')
  final double apparentTemperature;
  @JsonKey(name: 'precipitation')
  final double precipitation;
  @JsonKey(name: 'weather_code')
  final int weatherCode;
  @JsonKey(name: 'pressure_msl')
  final double seaLevelPressure;
  @JsonKey(name: 'wind_speed_10m')
  final double windSpeed;

  const Current({
    required this.time,
    required this.temperature,
    required this.relativeHumidity,
    required this.apparentTemperature,
    required this.precipitation,
    required this.weatherCode,
    required this.seaLevelPressure,
    required this.windSpeed,
  });

  factory Current.fromJson(JsonMap json) => _$CurrentFromJson(json);

  void logCurrentWeather() {
    dev.log('<--------------------------->');
    dev.log(time.toString());
    dev.log('<--------------------------->');
    dev.log(temperature.toString());
    dev.log('<--------------------------->');
    dev.log(relativeHumidity.toString());
    dev.log('<--------------------------->');
    dev.log(apparentTemperature.toString());
    dev.log('<--------------------------->');
    dev.log(precipitation.toString());
    dev.log('<--------------------------->');
    dev.log(weatherCode.toString());
    dev.log('<--------------------------->');
    dev.log(seaLevelPressure.toString());
    dev.log('<--------------------------->');
    dev.log(windSpeed.toString());
    dev.log('<--------------------------->');
  }
}
