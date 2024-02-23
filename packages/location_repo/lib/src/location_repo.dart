import 'package:location_api/location_api.dart';

class LocationRepo {
  final LocationApi _locationApi;
  const LocationRepo({required LocationApi locationApi})
      : _locationApi = locationApi;

  Future<Results> fetchLocation({required String query}) =>
      _locationApi.fetchLocation(locationName: query);
}
