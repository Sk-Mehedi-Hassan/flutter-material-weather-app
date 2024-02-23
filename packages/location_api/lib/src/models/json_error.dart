import 'package:json_annotation/json_annotation.dart';
import 'package:location_api/src/json_map.dart';
import 'dart:developer' as dev;

part 'json_error.g.dart';

@JsonSerializable()
class JsonError {
  final bool error;
  final String reason;

  const JsonError({required this.error, required this.reason});

  factory JsonError.fromJson(JsonMap json) => _$JsonErrorFromJson(json);

  void logJsonError() {
    dev.log(error.toString());
    dev.log('<--------------------------->');
    dev.log(reason);
    dev.log('<--------------------------->');
  }
}
