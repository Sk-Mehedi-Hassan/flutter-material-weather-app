// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Current _$CurrentFromJson(Map<String, dynamic> json) => Current(
      time: dateTimeFromIso8061(json['time'] as String),
      temperature: (json['temperature_2m'] as num).toDouble(),
      relativeHumidity: json['relative_humidity_2m'] as int,
      apparentTemperature: (json['apparent_temperature'] as num).toDouble(),
      precipitation: (json['precipitation'] as num).toDouble(),
      weatherCode: json['weather_code'] as int,
      seaLevelPressure: (json['pressure_msl'] as num).toDouble(),
      windSpeed: (json['wind_speed_10m'] as num).toDouble(),
    );
