// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_quality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirQuality _$AirQualityFromJson(Map<String, dynamic> json) => AirQuality(
      usAQI: airQualityStatusFromIndex(json['us_aqi'] as int),
      uvIndex: uvIndexStatusFromIndex(json['uv_index'] as double),
    );
