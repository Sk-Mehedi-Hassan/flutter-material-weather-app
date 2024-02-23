enum AirQualityStatus {
  good,
  moderate,
  sensitive,
  unhealthy,
  veryUnhealthy,
  hazardous,
}

enum UvIndexStatus {
  low,
  moderate,
  high,
  veryHigh,
  extreme,
}

AirQualityStatus airQualityStatusFromIndex(int aqi) {
  switch (aqi) {
    case > 300:
      return AirQualityStatus.hazardous;
    case > 200:
      return AirQualityStatus.veryUnhealthy;
    case > 150:
      return AirQualityStatus.unhealthy;
    case > 50:
      return AirQualityStatus.sensitive;
    default:
      return AirQualityStatus.good;
  }
}

UvIndexStatus uvIndexStatusFromIndex(double uvIndex) {
  switch (uvIndex) {
    case > 10:
      return UvIndexStatus.extreme;
    case > 7:
      return UvIndexStatus.veryHigh;
    case > 5:
      return UvIndexStatus.high;
    case > 2:
      return UvIndexStatus.moderate;
    default:
      return UvIndexStatus.low;
  }
}

DateTime dateTimeFromIso8061(String isoTimeFormat) {
  return DateTime.parse(isoTimeFormat);
}

List<DateTime> dateTimeListFromIso8061(List<dynamic> isoTimeFormatList) {
  return isoTimeFormatList.map((isoTime) => DateTime.parse(isoTime)).toList();
}
