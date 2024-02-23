import 'package:weather_api/weather_api.dart';

class WeatherRepo {
  final WeatherApi _weatherApi;
  const WeatherRepo({required WeatherApi weatherApi})
      : _weatherApi = weatherApi;

  Future<AirQuality> fetchAirQuality(double latitude, double longitude,
          double elevation, String timezone) =>
      _weatherApi.fetchAirQuality(latitude, longitude, elevation, timezone);
  Future<Current> fetchCurrent(double latitude, double longitude,
          double elevation, String timezone) =>
      _weatherApi.fetchCurrent(latitude, longitude, elevation, timezone);
  Future<Hourly> fetchHourly(double latitude, double longitude,
          double elevation, String timezone) =>
      _weatherApi.fetchHourly(latitude, longitude, elevation, timezone);
  Future<Daily> fetchDaily(double latitude, double longitude, double elevation,
          String timezone) =>
      _weatherApi.fetchDaily(latitude, longitude, elevation, timezone);
}
