import 'package:bloc/bloc.dart';
import 'package:weather_repo/weather_repo.dart';
import 'package:weather_api/weather_api.dart';
part 'weather_state.dart';
part 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo _weatherRepo;
  WeatherBloc({required WeatherRepo weatherRepo})
      : _weatherRepo = weatherRepo,
        super(WeatherState()) {
    on<WeatherEvent>(_onWeatherEvent);
  }

  Future<void> _onWeatherEvent(
      WeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherState(weatherStatus: WeatherStatus.loading));
    AirQuality airQuality = await _weatherRepo.fetchAirQuality(
      event.latitude,
      event.longitude,
      event.elevation,
      event.timezone,
    );
    Current current = await _weatherRepo.fetchCurrent(
      event.latitude,
      event.longitude,
      event.elevation,
      event.timezone,
    );
    Hourly hourly = await _weatherRepo.fetchHourly(
      event.latitude,
      event.longitude,
      event.elevation,
      event.timezone,
    );
    Daily daily = await _weatherRepo.fetchDaily(
      event.latitude,
      event.longitude,
      event.elevation,
      event.timezone,
    );
    // airQuality.logAirQuality();
    // current.logCurrentWeather();
    // hourly.logHourly();
    // daily.logDaily();
    emit(WeatherState(
      weatherStatus: WeatherStatus.success,
      airQuality: airQuality,
      current: current,
      hourly: hourly,
      daily: daily,
      locationName: event.locationName,
    ));
  }
}
