// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hourly _$HourlyFromJson(Map<String, dynamic> json) => Hourly(
      hourlyTimeList: dateTimeListFromIso8061(json['time'] as List),
      hourlyTemperatureList: (json['temperature_2m'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      hourlyPrecipitationList:
          (json['precipitation_probability'] as List<dynamic>)
              .map((e) => e as int)
              .toList(),
    );
