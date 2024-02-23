// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      elevation: (json['elevation'] as num).toDouble(),
      timezone: json['timezone'] as String,
      country: json['country'] as String,
      admin1: json['admin1'] as String?,
      admin2: json['admin2'] as String?,
    );
