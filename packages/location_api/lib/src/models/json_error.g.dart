// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonError _$JsonErrorFromJson(Map<String, dynamic> json) => JsonError(
      error: json['error'] as bool,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$JsonErrorToJson(JsonError instance) => <String, dynamic>{
      'error': instance.error,
      'reason': instance.reason,
    };
