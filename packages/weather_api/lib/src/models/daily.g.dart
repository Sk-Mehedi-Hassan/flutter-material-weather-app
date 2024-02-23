// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Daily _$DailyFromJson(Map<String, dynamic> json) => Daily(
      dailyTimeList: dateTimeListFromIso8061(json['time'] as List),
      dailyApparentTemperatureMaxList:
          (json['apparent_temperature_max'] as List<dynamic>)
              .map((e) => (e as num).toDouble())
              .toList(),
      dailyApparentTemperatureMinList:
          (json['apparent_temperature_min'] as List<dynamic>)
              .map((e) => (e as num).toDouble())
              .toList(),
      dailyPrecipitationList:
          (json['precipitation_probability_max'] as List<dynamic>)
              .map((e) => e as int)
              .toList(),
    );
