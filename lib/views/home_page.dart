import 'package:app_9/lib.dart';
import 'package:app_9/views/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'weather_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: const WeatherAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: WeatherBuilder(textTheme: textTheme),
          ),
        ),
      ),
    );
  }
}

class WeatherAppBar extends StatefulWidget implements PreferredSizeWidget {
  const WeatherAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<WeatherAppBar> createState() => _WeatherAppBarState();
}

class _WeatherAppBarState extends State<WeatherAppBar> {
  @override
  Widget build(BuildContext context) {
    //final SearchController searchController = SearchController();
    return AppBar(
      title: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state.weatherStatus == WeatherStatus.initial ||
              state.weatherStatus == WeatherStatus.loading ||
              state.weatherStatus == WeatherStatus.failure) {
            return const Text("");
          }
          return Text(
            state.locationName!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          );
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(SearchPage.route());
          },
        ),
      ],
    );
  }
}
