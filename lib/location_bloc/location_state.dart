part of 'location_bloc.dart';

enum LocationStatus { initial, loading, success, failure }

class LocationState {
  final LocationStatus locationStatus;
  final Results? results;

  const LocationState({
    this.locationStatus = LocationStatus.initial,
    this.results,
  });
}
