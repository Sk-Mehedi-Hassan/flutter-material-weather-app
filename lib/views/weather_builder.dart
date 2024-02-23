import 'package:app_9/views/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api/weather_api.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../weather_bloc/weather_bloc.dart';
import 'central_message.dart';

class WeatherBuilder extends StatelessWidget {
  const WeatherBuilder({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, weatherState) {
        switch (weatherState.weatherStatus) {
          case WeatherStatus.initial:
            return const CentralMessage(
              iconData: Icons.travel_explore,
              message: "Search weather",
            );
          case WeatherStatus.loading:
            return const CircularProgressIndicator();
          case WeatherStatus.failure:
            return const CentralMessage(
              iconData: Icons.warning_rounded,
              message: "Weather is unavailable",
            );
          case WeatherStatus.success:
            return WeatherView(
              weatherState: weatherState,
            );
        }
      },
    );
  }
}

class WeatherView extends StatelessWidget {
  const WeatherView({required this.weatherState, super.key});
  final WeatherState weatherState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    late String airQualityDescription;
    late Color cardColor;
    late Color textColor;

    late String uvDescription;

    switch (weatherState.airQuality!.uvIndex) {
      case UvIndexStatus.low:
        uvDescription = "Low";
        break;
      case UvIndexStatus.moderate:
        uvDescription = "Moderate";
        break;
      case UvIndexStatus.high:
        uvDescription = "High";
        break;
      case UvIndexStatus.veryHigh:
        uvDescription = "Very high";
        break;
      case UvIndexStatus.extreme:
        uvDescription = "Extreme";
        break;
    }

    switch (weatherState.airQuality!.usAQI) {
      case AirQualityStatus.good:
        airQualityDescription = "Good";
        cardColor = colorScheme.primaryContainer;
        textColor = colorScheme.onPrimaryContainer;
        break;
      case AirQualityStatus.moderate:
        airQualityDescription = "Moderate";
        cardColor = colorScheme.primaryContainer;
        textColor = colorScheme.onPrimaryContainer;
        break;
      case AirQualityStatus.sensitive:
        airQualityDescription = "Sensitive";
        cardColor = colorScheme.tertiaryContainer;
        textColor = colorScheme.onTertiaryContainer;
        break;
      case AirQualityStatus.unhealthy:
        airQualityDescription = "Unhealthy";
        cardColor = colorScheme.tertiaryContainer;
        textColor = colorScheme.onTertiaryContainer;
        break;
      case AirQualityStatus.veryUnhealthy:
        airQualityDescription = "Very unhealthy";
        cardColor = colorScheme.errorContainer;
        textColor = colorScheme.onErrorContainer;
        break;
      case AirQualityStatus.hazardous:
        airQualityDescription = "Hazardous";
        cardColor = colorScheme.errorContainer;
        textColor = colorScheme.onErrorContainer;
        break;
    }
    //final weatherState = context.read<WeatherState>();
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: ListView(
        children: [
          CustomCard(
              color: colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${weatherState.current!.temperature.ceil()}"
                            "\u00b0",
                            style: TextStyle(
                              fontSize: textTheme.displayLarge!.fontSize,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            _processWeatherCode(
                                weatherState.current!.weatherCode),
                            style: TextStyle(
                              fontSize: textTheme.bodyLarge!.fontSize,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Feels like ${weatherState.current!.apparentTemperature.ceil()} \u00b0",
                            style: TextStyle(
                              fontSize: textTheme.bodyLarge!.fontSize,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Icon(
                        _weatherCodeIcon(weatherState.current!.weatherCode),
                        fill: 1,
                        color: colorScheme.primary,
                        size: 120,
                      ),
                    )
                  ],
                ),
              )),
          const SizedBox(
            height: 4,
          ),
          CustomCard(
            color: colorScheme.secondaryContainer,
            child: Container(
              padding: const EdgeInsets.all(16),
              height: 150,
              child: Column(
                children: [
                  const Text('Hourly Forecast'),
                  Divider(
                    color: colorScheme.onSecondaryContainer,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: _hourlyWeatherList(
                        weatherState.hourly!.hourlyTimeList,
                        weatherState.hourly!.hourlyTemperatureList,
                        weatherState.hourly!.hourlyPrecipitationList,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          CustomCard(
            color: colorScheme.secondaryContainer,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text('Daily Forecast'),
                  Divider(
                    color: colorScheme.onSecondaryContainer,
                  ),
                  ..._dailyWeatherList(
                    weatherState.daily!.dailyTimeList,
                    weatherState.daily!.dailyApparentTemperatureMinList,
                    weatherState.daily!.dailyApparentTemperatureMaxList,
                    weatherState.daily!.dailyPrecipitationList,
                  ),
                ]),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          CustomCard(
            color: cardColor,
            child: _cardContent(
              Symbols.allergy_rounded,
              textColor,
              "AQI",
              airQualityDescription,
              true,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: CustomCard(
                      color: cardColor,
                      child: _cardContent(
                          Icons.light_mode,
                          textColor,
                          'UV '
                          'index',
                          uvDescription),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: CustomCard(
                      color: colorScheme.secondaryContainer,
                      child: _cardContent(
                        Symbols.humidity_mid_rounded,
                        colorScheme.onSecondaryContainer,
                        'Humidity',
                        "${weatherState.current!.relativeHumidity}%",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: CustomCard(
                      color: colorScheme.secondaryContainer,
                      child: _cardContent(
                        Icons.air,
                        colorScheme.onSecondaryContainer,
                        'Wind',
                        "${weatherState.current!.windSpeed} km/h",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: CustomCard(
                        color: colorScheme.secondaryContainer,
                        child: _cardContent(
                            Symbols.compress,
                            colorScheme.onSecondaryContainer,
                            'Pressure',
                            "${weatherState.current!.seaLevelPressure} mb")),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _cardContent(
      IconData iconData, Color textColor, String title, String value,
      [bool isDivider = false]) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(iconData),
              const SizedBox(
                width: 4,
              ),
              Text(
                title,
                style: TextStyle(color: textColor),
              ),
            ],
          ),
          isDivider
              ? Divider(color: textColor)
              : const SizedBox(
                  height: 4,
                ),
          Text(value, style: TextStyle(color: textColor)),
        ],
      ),
    );
  }

  IconData _precipIcon(int percentage) {
    if (percentage > 40) {
      return Symbols.humidity_high_rounded;
    } else if (percentage > 10) {
      return Symbols.humidity_mid_rounded;
    } else {
      return Symbols.humidity_low_rounded;
    }
  }

  List<Widget> _hourlyWeatherList(
      List<DateTime> timeList, List<double> tempList, List<int> precipList) {
    List<Widget> widgetList = [];
    for (int index = 0; index < timeList.length; index++) {
      Widget widgetColumn = Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            timeList[index].hour.toString().length == 1
                ? Text("${timeList[index].hour.toString().padLeft(2, '0')} AM")
                : Text("${(timeList[index].hour % 12).toString()} PM"),
            const SizedBox(
              height: 8,
            ),
            Text("${tempList[index].toString()}\u00b0"),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _precipIcon(precipList[index]),
                  size: 12,
                ),
                Text("${precipList[index].toString()}%"),
              ],
            ),
          ],
        ),
      );
      widgetList.add(widgetColumn);
    }
    return widgetList;
  }

  List<Widget> _dailyWeatherList(
      List<DateTime> timeList,
      List<double> tempMinList,
      List<double> tempMaxList,
      List<int> precipList) {
    List<Widget> widgetList = [];
    for (int index = 0; index < timeList.length; index++) {
      Widget widgetRow = Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text(_processWeekday(timeList[index].weekday))),
                Icon(
                  _precipIcon(precipList[index]),
                  size: 16,
                ),
                const SizedBox(
                  width: 1,
                ),
                Text("${precipList[index]}%"),
                const SizedBox(
                  width: 20,
                ),
                Text("${tempMinList[index].ceil()}\u00b0"),
                const SizedBox(
                  width: 20,
                ),
                Text("${tempMaxList[index].ceil()}\u00b0"),
              ],
            ),
          ));
      widgetList.add(widgetRow);
    }
    return widgetList;
  }

  String _processWeekday(int weekDayNum) {
    switch (weekDayNum) {
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      default:
        return "No day";
    }
  }

  String _processWeatherCode(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return "Clear sky";
      case 1:
        return "Mainly clear";
      case 2:
        return "Partly cloudy";
      case 3:
        return "Cloudy";
      case 45:
        return "Fog";
      case 48:
        return "Rime fog";
      case 51:
        return "Light drizzle";
      case 53:
        return "Moderate drizzle";
      case 55:
        return "Dense drizzle";
      case 56:
        return "Light freezing drizzle";
      case 57:
        return "Dense freezing drizzle";
      case 61:
        return "Slight rain";
      case 63:
        return "Moderate rain";
      case 65:
        return "Heavy rain";
      case 66:
        return "Light freezing rain";
      case 67:
        return "Heavy freezing rain";
      case 71:
        return "Slight snow fall";
      case 73:
        return "Moderate snow fall";
      case 75:
        return "Moderate snow fall";
      case 77:
        return "Snow grains";
      case 80:
        return "Slight rain shower";
      case 81:
        return "Moderate rain shower";
      case 82:
        return "Heavy rain shower";
      case 85:
        return "Slight snow showers";
      case 86:
        return "Moderate snow showers";
      case 95:
        return "Thunderstorm";
      case 96:
        return "Light thunderstorm hail";
      case 99:
        return "Heavy thunderstorm hail";
      default:
        return "No code match";
    }
  }

  IconData _weatherCodeIcon(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return Symbols.sunny_rounded;
      case 1:
        return Symbols.sunny_rounded;
      case 2:
        return Symbols.partly_cloudy_day;
      case 3:
        return Symbols.cloud;
      case 45:
        return Icons.foggy;
      case 48:
        return Symbols.mist_rounded;
      case 51:
        return Symbols.rainy_light_rounded;
      case 53:
        return Symbols.rainy_light_rounded;
      case 55:
        return Symbols.rainy_light_rounded;
      case 56:
        return Symbols.rainy_snow_rounded;
      case 57:
        return Symbols.rainy_snow_rounded;
      case 61:
        return Symbols.rainy_rounded;
      case 63:
        return Symbols.rainy_rounded;
      case 65:
        return Symbols.rainy_heavy_rounded;
      case 66:
        return Symbols.rainy_snow_rounded;
      case 67:
        return Symbols.rainy_snow_rounded;
      case 71:
        return Symbols.snowing_rounded;
      case 73:
        return Symbols.cloudy_snowing_rounded;
      case 75:
        return Symbols.cloudy_snowing_rounded;
      case 77:
        return Symbols.ac_unit_rounded;
      case 80:
        return Symbols.rainy_rounded;
      case 81:
        return Symbols.rainy_rounded;
      case 82:
        return Symbols.rainy_heavy_rounded;
      case 85:
        return Symbols.snowing_rounded;
      case 86:
        return Symbols.snowing_heavy_rounded;
      case 95:
        return Symbols.thunderstorm_rounded;
      case 96:
        return Symbols.weather_hail_rounded;
      case 99:
        return Symbols.weather_hail_rounded;
      default:
        return Symbols.weather_mix_rounded;
    }
  }
}
