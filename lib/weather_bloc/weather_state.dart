part of 'weather_bloc.dart';

enum WeatherStatus { initial, loading, success, failure }

class WeatherState {
  final WeatherStatus weatherStatus;
  final AirQuality? airQuality;
  final Current? current;
  final Hourly? hourly;
  final Daily? daily;
  final String? locationName;

  WeatherState({
    this.weatherStatus = WeatherStatus.initial,
    this.airQuality,
    this.current,
    this.hourly,
    this.daily,
    this.locationName,
  });
}
