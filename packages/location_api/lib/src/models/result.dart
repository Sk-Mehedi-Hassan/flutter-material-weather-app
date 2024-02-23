import 'dart:developer' as dev;

import 'package:json_annotation/json_annotation.dart';
import '../json_map.dart';

part 'result.g.dart';

@JsonSerializable(createToJson: false)
class Result {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'latitude')
  final double? latitude;
  @JsonKey(name: 'longitude')
  final double? longitude;
  @JsonKey(name: 'elevation')
  final double? elevation;
  @JsonKey(name: 'timezone')
  final String? timezone;
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'admin1')
  final String? admin1;
  @JsonKey(name: 'admin2')
  final String? admin2;

  const Result({
    this.name,
    this.latitude,
    this.longitude,
    this.elevation,
    this.timezone,
    this.country,
    this.admin1,
    this.admin2,
  });

  factory Result.fromJson(JsonMap json) => _$ResultFromJson(json);

  bool nullExist() {
    if (name == null ||
        latitude == null ||
        longitude == null ||
        elevation == null ||
        timezone == null ||
        country == null ||
        admin1 == null ||
        admin2 == null) {
      return true;
    }
    return false;
  }

  void logResult() {
    name == null ? dev.log('name 1 is null') : dev.log(name!);
    dev.log('<--------------------------->');
    latitude == null
        ? dev.log('latitude 1 is null')
        : dev.log(latitude!.toString());
    dev.log('<--------------------------->');
    longitude == null
        ? dev.log('longitude 1 is null')
        : dev.log(longitude!.toString());
    dev.log('<--------------------------->');
    elevation == null
        ? dev.log('elevation 1 is null')
        : dev.log(elevation!.toString());
    dev.log('<--------------------------->');
    timezone == null
        ? dev.log('timezone 1 is null')
        : dev.log(timezone!.toString());
    dev.log('<--------------------------->');
    country == null
        ? dev.log('country 1 is null')
        : dev.log(country!.toString());
    dev.log('<--------------------------->');
    admin1 == null ? dev.log('admin 1 is null') : dev.log(admin1!);
    dev.log('<--------------------------->');
    admin2 == null ? dev.log('admin 2 is null') : dev.log(admin2!);
    dev.log('<--------------------------->');
  }
}
