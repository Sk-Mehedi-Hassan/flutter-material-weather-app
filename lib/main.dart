import 'package:app_9/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api/weather_api.dart';
import 'package:weather_repo/weather_repo.dart';
import 'package:location_api/location_api.dart';
import 'package:location_repo/location_repo.dart';

void main() async {
  LocationApi locationApi = LocationApi();
  LocationRepo locationRepo = LocationRepo(locationApi: locationApi);
  WeatherApi weatherApi = WeatherApi();
  WeatherRepo weatherRepo = WeatherRepo(weatherApi: weatherApi);
  // Results results = await locationRepo.fetchLocation(query: 'Satkhira');
  // AirQuality airQuality = await weatherRepo.fetchAirQuality(
  //     results.results![0].latitude,
  //     results.results![0].latitude,
  //     results.results![0].elevation,
  //     results.results![0].timezone);
  // Current current = await weatherRepo.fetchCurrent(
  //     results.results![0].latitude,
  //     results.results![0].latitude,
  //     results.results![0].elevation,
  //     results.results![0].timezone);
  // Hourly hourly = await weatherRepo.fetchHourly(
  //     results.results![0].latitude,
  //     results.results![0].latitude,
  //     results.results![0].elevation,
  //     results.results![0].timezone);
  // Daily daily = await weatherRepo.fetchDaily(
  //     results.results![0].latitude,
  //     results.results![0].latitude,
  //     results.results![0].elevation,
  //     results.results![0].timezone);
  // results.logResults();
  // airQuality.logAirQuality();
  // current.logCurrentWeather();
  // hourly.logHourly();
  // daily.logDaily();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LocationBloc(locationRepo: locationRepo),
        ),
        BlocProvider(
          create: (_) => WeatherBloc(weatherRepo: weatherRepo),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lime,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}
