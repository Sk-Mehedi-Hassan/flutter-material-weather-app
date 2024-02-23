import 'dart:convert';

import 'models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class AirNotFoundException implements Exception {}

class CurrentNotFoundException implements Exception {}

class HourlyNotFoundException implements Exception {}

class DailyNotFoundException implements Exception {}

class WeatherApi {
  static const String _baseAirQualityUrl = 'air-quality-api.open-meteo.com';
  static const String _airQualityPath = '/v1/air-quality';
  static const String _baseUrl = 'api.open-meteo.com';
  static const String _path = '/v1/forecast';

  static const List<String> _airQualityQuery = ["us_aqi", "uv_index"];
  static const List<String> _currentQuery = [
    "temperature_2m",
    "relative_humid"
        "ity_2m",
    "apparent_temperature",
    "precipitation",
    "weather_code",
    "pressure_msl",
    "wind_speed_10m",
  ];
  static const List<String> _hourlyQuery = [
    "temperature_2m",
    "precipitation_probability",
  ];
  static const List<String> _dailyQuery = [
    "apparent_temperature_max",
    "apparent_temperature_min",
    "precipitation_prob"
        "ability_max",
  ];

  Future<AirQuality> fetchAirQuality(double latitude, double longitude,
      double elevation, String timezone) async {
    final airQualityRequest = Uri.https(
      _baseAirQualityUrl,
      _airQualityPath,
      {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'elevation': elevation.toString(),
        'timezone': timezone,
        'current': _airQualityQuery,
      },
    );

    final airQualityResponse = await http.get(airQualityRequest);

    if (airQualityResponse.statusCode != 200) {
      if (airQualityResponse.statusCode == 400) {
        JsonError.fromJson(jsonDecode(airQualityResponse.body)).logJsonError();
        dev.debugger();
      }
      throw Exception();
    }

    final airQualityJson = jsonDecode(airQualityResponse.body);

    if (airQualityJson.containsKey('current') == false) {
      throw AirNotFoundException();
    }

    return AirQuality.fromJson(airQualityJson['current']);
  }

  Future<Current> fetchCurrent(double latitude, double longitude,
      double elevation, String timezone) async {
    final currentRequest = Uri.https(
      _baseUrl,
      _path,
      {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'elevation': elevation.toString(),
        'timezone': timezone,
        'current': _currentQuery,
      },
    );

    final currentResponse = await http.get(currentRequest);

    if (currentResponse.statusCode != 200) {
      if (currentResponse.statusCode == 400) {
        JsonError.fromJson(jsonDecode(currentResponse.body)).logJsonError();
        dev.debugger();
      }
      throw Exception();
    }

    final currentJson = jsonDecode(currentResponse.body);

    if (currentJson.containsKey('current') == false) {
      throw CurrentNotFoundException();
    }

    return Current.fromJson(currentJson['current']);
  }

  Future<Hourly> fetchHourly(
      double latitude, double longitude, double elevation, String timezone,
      [int forecastDays = 1]) async {
    final hourlyRequest = Uri.https(
      _baseUrl,
      _path,
      {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'elevation': elevation.toString(),
        'timezone': timezone,
        'hourly': _hourlyQuery,
        'forecast_days': forecastDays.toString(),
      },
    );

    final hourlyResponse = await http.get(hourlyRequest);

    if (hourlyResponse.statusCode != 200) {
      if (hourlyResponse.statusCode == 400) {
        JsonError.fromJson(jsonDecode(hourlyResponse.body)).logJsonError();
        dev.debugger();
      }
      throw Exception();
    }

    final hourlyJson = jsonDecode(hourlyResponse.body);

    if (hourlyJson.containsKey('hourly') == false) {
      throw HourlyNotFoundException();
    }

    return Hourly.fromJson(hourlyJson['hourly']);
  }

  Future<Daily> fetchDaily(double latitude, double longitude, double elevation,
      String timezone) async {
    final dailyRequest = Uri.https(
      _baseUrl,
      _path,
      {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'elevation': elevation.toString(),
        'timezone': timezone,
        'daily': _dailyQuery,
      },
    );

    final dailyResponse = await http.get(dailyRequest);

    if (dailyResponse.statusCode != 200) {
      if (dailyResponse.statusCode == 400) {
        JsonError.fromJson(jsonDecode(dailyResponse.body)).logJsonError();
        dev.debugger();
      }
      throw Exception();
    }

    final dailyJson = jsonDecode(dailyResponse.body);

    if (dailyJson.containsKey('daily') == false) {
      throw DailyNotFoundException();
    }

    return Daily.fromJson(dailyJson['daily']);
  }
}
