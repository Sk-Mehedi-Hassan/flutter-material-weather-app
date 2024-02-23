import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'models/models.dart';

class LocationRequestException implements Exception {}

class LocationNotFoundException implements Exception {}

class LocationApi {
  static const String _baseLocationUrl = 'geocoding-api.open-meteo.com';
  static const String _pathUrl = '/v1/search';

  Future<Results> fetchLocation(
      {required String locationName, int count = 30}) async {
    if (locationName.length < 2) {
      return const Results(results: []);
    }
    final locationRequest = Uri.https(
      _baseLocationUrl,
      _pathUrl,
      {
        'name': locationName,
        'count': count.toString(),
      },
    );

    final locationResponse = await http.get(locationRequest);

    if (locationResponse.statusCode != 200) {
      if (locationResponse.statusCode == 400) {
        JsonError.fromJson(jsonDecode(locationResponse.body)).logJsonError();
        dev.debugger();
      }
      throw Exception();
    }

    final locationJson = jsonDecode(locationResponse.body);
    return Results.fromJson({'results': locationJson['results']});
  }
}
