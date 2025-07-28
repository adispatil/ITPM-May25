// To parse this JSON data, do
//
//     final weatherResponseModel = weatherResponseModelFromJson(jsonString);

import 'dart:convert';

WeatherResponseModel weatherResponseModelFromJson(String str) =>
    WeatherResponseModel.fromJson(json.decode(str));

String weatherResponseModelToJson(WeatherResponseModel data) =>
    json.encode(data.toJson());

class WeatherResponseModel {
  final Location? location;
  final Current? current;
  final Forecast? forecast;

  WeatherResponseModel({this.location, this.current, this.forecast});

  factory WeatherResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => WeatherResponseModel(
    location:
        json["location"] == null ? null : Location.fromJson(json["location"]),
    current: json["current"] == null ? null : Current.fromJson(json["current"]),
    forecast:
        json["forecast"] == null ? null : Forecast.fromJson(json["forecast"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "current": current?.toJson(),
    "forecast": forecast?.toJson(),
  };
}

class Current {
  final int? lastUpdatedEpoch;
  final String? lastUpdated;
  final double? tempC;
  final int? isDay;
  final Condition? condition;
  final double? windKph;
  final int? humidity;
  final int? cloud;
  final double? precipMm;
  final double? dewpointC;
  final double? dewpointF;
  final double? visKm;
  final double? visMiles;
  final double? uv;

  Current({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.isDay,
    this.condition,
    this.windKph,
    this.humidity,
    this.cloud,
    this.dewpointC,
    this.dewpointF,
    this.visKm,
    this.visMiles,
    this.uv,
    this.precipMm,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    lastUpdatedEpoch: json["last_updated_epoch"],
    lastUpdated: json["last_updated"],
    tempC: json["temp_c"]?.toDouble(),
    isDay: json["is_day"],
    condition:
        json["condition"] == null
            ? null
            : Condition.fromJson(json["condition"]),
    windKph: json["wind_kph"]?.toDouble(),
    humidity: json["humidity"],
    cloud: json["cloud"],
    dewpointC: json["dewpoint_c"]?.toDouble(),
    dewpointF: json["dewpoint_f"]?.toDouble(),
    visKm: json["vis_km"],
    visMiles: json["vis_miles"],
    uv: json["uv"]?.toDouble(),
    precipMm: json["precip_mm"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "last_updated_epoch": lastUpdatedEpoch,
    "last_updated": lastUpdated,
    "temp_c": tempC,
    "is_day": isDay,
    "condition": condition?.toJson(),
    "wind_kph": windKph,
    "humidity": humidity,
    "cloud": cloud,
    "dewpoint_c": dewpointC,
    "dewpoint_f": dewpointF,
    "vis_km": visKm,
    "vis_miles": visMiles,
    "uv": uv,
    "precip_mm": precipMm,
  };
}

class Condition {
  final String? text;
  final String? icon;
  final int? code;

  Condition({this.text, this.icon, this.code});

  factory Condition.fromJson(Map<String, dynamic> json) =>
      Condition(text: json["text"], icon: json["icon"], code: json["code"]);

  Map<String, dynamic> toJson() => {"text": text, "icon": icon, "code": code};
}

class Forecast {
  final List<Forecastday>? forecastday;

  Forecast({this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    forecastday:
        json["forecastday"] == null
            ? []
            : List<Forecastday>.from(
              json["forecastday"]!.map((x) => Forecastday.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "forecastday":
        forecastday == null
            ? []
            : List<dynamic>.from(forecastday!.map((x) => x.toJson())),
  };
}

class Forecastday {
  final DateTime? date;
  final int? dateEpoch;
  final Day? day;
  final Astro? astro;
  final List<Hour>? hour;

  Forecastday({this.date, this.dateEpoch, this.day, this.astro, this.hour});

  factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    dateEpoch: json["date_epoch"],
    day: json["day"] == null ? null : Day.fromJson(json["day"]),
    astro: json["astro"] == null ? null : Astro.fromJson(json["astro"]),
    hour:
        json["hour"] == null
            ? []
            : List<Hour>.from(json["hour"]!.map((x) => Hour.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date":
        "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "date_epoch": dateEpoch,
    "day": day?.toJson(),
    "astro": astro?.toJson(),
    "hour":
        hour == null ? [] : List<dynamic>.from(hour!.map((x) => x.toJson())),
  };
}

class Astro {
  final String? sunrise;
  final String? sunset;
  final String? moonrise;
  final String? moonset;
  final String? moonPhase;
  final int? moonIllumination;
  final int? isMoonUp;
  final int? isSunUp;

  Astro({
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.moonIllumination,
    this.isMoonUp,
    this.isSunUp,
  });

  factory Astro.fromJson(Map<String, dynamic> json) => Astro(
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    moonrise: json["moonrise"],
    moonset: json["moonset"],
    moonPhase: json["moon_phase"],
    moonIllumination: json["moon_illumination"],
    isMoonUp: json["is_moon_up"],
    isSunUp: json["is_sun_up"],
  );

  Map<String, dynamic> toJson() => {
    "sunrise": sunrise,
    "sunset": sunset,
    "moonrise": moonrise,
    "moonset": moonset,
    "moon_phase": moonPhase,
    "moon_illumination": moonIllumination,
    "is_moon_up": isMoonUp,
    "is_sun_up": isSunUp,
  };
}

class Day {
  final double? maxtempC;
  final double? mintempC;
  final double? avgtempC;
  final double? avgtempF;
  final double? maxwindKph;
  final double? totalprecipMm;
  final double? totalprecipIn;
  final Condition? condition;
  final double? uv;

  Day({
    this.maxtempC,
    this.mintempC,
    this.avgtempC,
    this.avgtempF,
    this.maxwindKph,
    this.totalprecipMm,
    this.totalprecipIn,
    this.condition,
    this.uv,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    maxtempC: json["maxtemp_c"]?.toDouble(),

    mintempC: json["mintemp_c"]?.toDouble(),

    avgtempC: json["avgtemp_c"]?.toDouble(),
    avgtempF: json["avgtemp_f"]?.toDouble(),

    maxwindKph: json["maxwind_kph"]?.toDouble(),
    totalprecipMm: json["totalprecip_mm"]?.toDouble(),
    totalprecipIn: json["totalprecip_in"]?.toDouble(),

    condition:
        json["condition"] == null
            ? null
            : Condition.fromJson(json["condition"]),
    uv: json["uv"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "maxtemp_c": maxtempC,
    "mintemp_c": mintempC,
    "avgtemp_c": avgtempC,
    "avgtemp_f": avgtempF,
    "maxwind_kph": maxwindKph,
    "totalprecip_mm": totalprecipMm,
    "totalprecip_in": totalprecipIn,
    "condition": condition?.toJson(),
    "uv": uv,
  };
}

class Hour {
  final int? timeEpoch;
  final String? time;
  final double? tempC;
  final double? tempF;
  final int? isDay;
  final Condition? condition;
  final double? windMph;
  final double? windKph;
  final String? windDir;
  final double? pressureIn;
  final double? precipMm;
  final double? precipIn;
  final int? humidity;
  final int? cloud;
  final int? chanceOfRain;
  final double? uv;

  Hour({
    this.timeEpoch,
    this.time,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDir,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.uv,
    this.chanceOfRain,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
    timeEpoch: json["time_epoch"],
    time: json["time"],
    tempC: json["temp_c"]?.toDouble(),
    tempF: json["temp_f"]?.toDouble(),
    isDay: json["is_day"],
    condition:
        json["condition"] == null
            ? null
            : Condition.fromJson(json["condition"]),
    windMph: json["wind_mph"]?.toDouble(),
    windKph: json["wind_kph"]?.toDouble(),

    windDir: json["wind_dir"],

    pressureIn: json["pressure_in"]?.toDouble(),
    precipMm: json["precip_mm"]?.toDouble(),
    precipIn: json["precip_in"]?.toDouble(),
    humidity: json["humidity"],
    cloud: json["cloud"],
    uv: json["uv"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "time_epoch": timeEpoch,
    "time": time,
    "temp_c": tempC,
    "temp_f": tempF,
    "is_day": isDay,
    "condition": condition?.toJson(),
    "wind_mph": windMph,
    "wind_kph": windKph,
    "wind_dir": windDir,
    "pressure_in": pressureIn,
    "precip_mm": precipMm,
    "precip_in": precipIn,
    "humidity": humidity,
    "cloud": cloud,
    "chance_of_rain": chanceOfRain,
    "uv": uv,
  };
}

class Location {
  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
  final String? tzId;
  final int? localtimeEpoch;
  final String? localtime;

  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"],
    region: json["region"],
    country: json["country"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    tzId: json["tz_id"],
    localtimeEpoch: json["localtime_epoch"],
    localtime: json["localtime"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "region": region,
    "country": country,
    "lat": lat,
    "lon": lon,
    "tz_id": tzId,
    "localtime_epoch": localtimeEpoch,
    "localtime": localtime,
  };
}
