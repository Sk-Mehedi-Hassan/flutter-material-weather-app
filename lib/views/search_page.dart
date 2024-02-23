import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../location_bloc/location_bloc.dart';
import '../weather_bloc/weather_bloc.dart';
import 'central_message.dart';
import 'custom_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) {
        return const SearchPage();
      },
    );
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: SearchBar(
                controller: controller,
                trailing: [
                  IconButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          controller.clear();
                          context
                              .read<LocationBloc>()
                              .add(const LocationEvent(locationName: ''));
                        }
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ))
                ],
                elevation: MaterialStateProperty.resolveWith((_) => 0.0),
                textStyle: MaterialStateProperty.resolveWith(
                  (_) => TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                    //color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                // backgroundColor: MaterialStateProperty.resolveWith(
                //     (_) => Theme.of(context).colorScheme.surfaceVariant),
                hintText: "Search",
                onChanged: (query) {
                  context
                      .read<LocationBloc>()
                      .add(LocationEvent(locationName: query));
                },
                onSubmitted: (query) {
                  context
                      .read<LocationBloc>()
                      .add(LocationEvent(locationName: query));
                },
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, locationState) {
                    switch (locationState.locationStatus) {
                      case LocationStatus.initial:
                        return const CustomCard(
                          color: null,
                          child: CentralMessage(
                            iconData: Icons.search,
                            message: "Search Location",
                          ),
                        );
                      case LocationStatus.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case LocationStatus.failure:
                        return const CustomCard(
                          color: null,
                          child: CentralMessage(
                            iconData: Icons.wrong_location_outlined,
                            message: "Location not found",
                          ),
                        );
                      case LocationStatus.success:
                        return CustomCard(
                          color: null,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              {
                                final e =
                                    locationState.results!.results![index];
                                void onLocationTap() {
                                  context.read<WeatherBloc>().add(WeatherEvent(
                                        latitude: e.latitude!,
                                        longitude: e.longitude!,
                                        elevation: e.elevation!,
                                        timezone: e.timezone!,
                                        locationName: e.name!,
                                      ));
                                  //context.read<LocationBloc>().add(
                                  //const LocationEvent(locationName: ''));
                                  Navigator.of(context).pop();
                                }

                                if (e.nullExist() == false) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        onTap: onLocationTap,
                                        title: Text(e.name!),
                                        subtitle: Text(
                                          "${e.admin2!}, ${e.admin1!}, ${e.country!}",
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  );
                                } else {
                                  if (e.admin1 == null && e.admin2 == null) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          onTap: onLocationTap,
                                          title: Text(e.name!),
                                          subtitle: Text(e.country!),
                                        ),
                                        const Divider(),
                                      ],
                                    );
                                  } else if (e.admin1 == null &&
                                      e.admin2 != null) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          onTap: onLocationTap,
                                          title: Text(e.name!),
                                          subtitle: Text(
                                              "${e.admin2!}, ${e.country!}"),
                                        ),
                                        const Divider(),
                                      ],
                                    );
                                  } else if (e.admin1 != null &&
                                      e.admin2 == null) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          onTap: onLocationTap,
                                          title: Text(e.name!),
                                          subtitle: Text(
                                              "${e.admin1!}, ${e.country!}"),
                                        ),
                                        const Divider(),
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          onTap: onLocationTap,
                                          title: Text(e.name!),
                                          subtitle: Text(
                                              "${e.admin2!}, ${e.admin1!}, ${e.country!}"),
                                        ),
                                        const Divider(),
                                      ],
                                    );
                                  }
                                }
                              }
                            },
                            itemCount: locationState.results!.results!.length,
                          ),
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
