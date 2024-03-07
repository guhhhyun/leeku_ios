import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

@freezed
class WeatherModel with _$WeatherModel {
  factory WeatherModel({

    @Default(0) int statusCode,
    CoordObject? coord,
    @Default('') String base,
    MainObject? main,
    WindObject? wind,
    @Default(0) int visibility,
    @Default(0) int dt,
    @Default(0) int timezone,
    @Default(0) int id,
    @Default('') String name,
    @Default(0) int cod,
    CloudsObject? clouds,
    SysObject? sys,
    List<WeatherTwoObject>? weather,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}


@freezed
class CoordObject with _$CoordObject {
  factory CoordObject({
    @Default(0.0) double lon,
    @Default(0.0) double lat,
  }) = _CoordObject;
  factory CoordObject.fromJson(Map<String, dynamic> json) =>
      _$CoordObjectFromJson(json);
}

@freezed
class WeatherTwoObject with _$WeatherTwoObject {
  factory WeatherTwoObject({
    @Default(0) int id,
    @Default('') String main,
    @Default('') String description,
    @Default('') String icon,
  }) = _WeatherTwoObject;
  factory WeatherTwoObject.fromJson(Map<String, dynamic> json) =>
      _$WeatherTwoObjectFromJson(json);
}

@freezed
class MainObject with _$MainObject {
  factory MainObject({
    @Default(0.0) double temp,
    @Default(0.0) double feels_like,
    @Default(0.0) double temp_min,
    @Default(0.0) double temp_max,
    @Default(0) int pressure,
    @Default(0) int humidity,
    @Default(0) int sea_level,
    @Default(0) int grnd_level,
  }) = _MainObject;
  factory MainObject.fromJson(Map<String, dynamic> json) =>
      _$MainObjectFromJson(json);
}

@freezed
class WindObject with _$WindObject {
  factory WindObject({
    @Default(0.0) double speed,
    @Default(0) int deg,
    @Default(0.0) double gust,
  }) = _WindObject;
  factory WindObject.fromJson(Map<String, dynamic> json) =>
      _$WindObjectFromJson(json);
}

@freezed
class CloudsObject with _$CloudsObject {
  factory CloudsObject({
    @Default(0) int all,
  }) = _CloudsObject;
  factory CloudsObject.fromJson(Map<String, dynamic> json) =>
      _$CloudsObjectFromJson(json);
}

@freezed
class SysObject with _$SysObject {
  factory SysObject({
    @Default(0) int type,
    @Default(0) int id,
    @Default('') String country,
    @Default(0) int sunrise,
    @Default(0) int sunset,
  }) = _SysObject;
  factory SysObject.fromJson(Map<String, dynamic> json) =>
      _$SysObjectFromJson(json);
}
