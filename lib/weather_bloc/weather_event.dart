part of 'weather_bloc.dart';

class WeatherEvent {
  final double latitude;
  final double longitude;
  final double elevation;
  final String timezone;
  final String locationName;

  WeatherEvent({
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.timezone,
    required this.locationName,
  });
}
