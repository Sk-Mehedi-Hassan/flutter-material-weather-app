import 'dart:developer' as dev;

import 'package:json_annotation/json_annotation.dart';
import '../json_map.dart';
import 'result.dart';

part 'results.g.dart';

@JsonSerializable(createToJson: false)
class Results {
  final List<Result>? results;

  const Results({required this.results});

  factory Results.fromJson(JsonMap json) => _$ResultsFromJson(json);

  void logResults() {
    if (results == null) {
      dev.log('no location found');
    } else {
      for (var result in results!) {
        result.logResult();
      }
    }
  }
}
