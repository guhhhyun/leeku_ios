// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WeatherModel _$$_WeatherModelFromJson(Map<String, dynamic> json) =>
    _$_WeatherModel(
      statusCode: json['statusCode'] as int? ?? 0,
      coord: json['coord'] == null
          ? null
          : CoordObject.fromJson(json['coord'] as Map<String, dynamic>),
      base: json['base'] as String? ?? '',
      main: json['main'] == null
          ? null
          : MainObject.fromJson(json['main'] as Map<String, dynamic>),
      wind: json['wind'] == null
          ? null
          : WindObject.fromJson(json['wind'] as Map<String, dynamic>),
      visibility: json['visibility'] as int? ?? 0,
      dt: json['dt'] as int? ?? 0,
      timezone: json['timezone'] as int? ?? 0,
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      cod: json['cod'] as int? ?? 0,
      clouds: json['clouds'] == null
          ? null
          : CloudsObject.fromJson(json['clouds'] as Map<String, dynamic>),
      sys: json['sys'] == null
          ? null
          : SysObject.fromJson(json['sys'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => WeatherTwoObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_WeatherModelToJson(_$_WeatherModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'coord': instance.coord,
      'base': instance.base,
      'main': instance.main,
      'wind': instance.wind,
      'visibility': instance.visibility,
      'dt': instance.dt,
      'timezone': instance.timezone,
      'id': instance.id,
      'name': instance.name,
      'cod': instance.cod,
      'clouds': instance.clouds,
      'sys': instance.sys,
      'weather': instance.weather,
    };

_$_CoordObject _$$_CoordObjectFromJson(Map<String, dynamic> json) =>
    _$_CoordObject(
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$_CoordObjectToJson(_$_CoordObject instance) =>
    <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };

_$_WeatherTwoObject _$$_WeatherTwoObjectFromJson(Map<String, dynamic> json) =>
    _$_WeatherTwoObject(
      id: json['id'] as int? ?? 0,
      main: json['main'] as String? ?? '',
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
    );

Map<String, dynamic> _$$_WeatherTwoObjectToJson(_$_WeatherTwoObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

_$_MainObject _$$_MainObjectFromJson(Map<String, dynamic> json) =>
    _$_MainObject(
      temp: (json['temp'] as num?)?.toDouble() ?? 0.0,
      feels_like: (json['feels_like'] as num?)?.toDouble() ?? 0.0,
      temp_min: (json['temp_min'] as num?)?.toDouble() ?? 0.0,
      temp_max: (json['temp_max'] as num?)?.toDouble() ?? 0.0,
      pressure: json['pressure'] as int? ?? 0,
      humidity: json['humidity'] as int? ?? 0,
      sea_level: json['sea_level'] as int? ?? 0,
      grnd_level: json['grnd_level'] as int? ?? 0,
    );

Map<String, dynamic> _$$_MainObjectToJson(_$_MainObject instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feels_like,
      'temp_min': instance.temp_min,
      'temp_max': instance.temp_max,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'sea_level': instance.sea_level,
      'grnd_level': instance.grnd_level,
    };

_$_WindObject _$$_WindObjectFromJson(Map<String, dynamic> json) =>
    _$_WindObject(
      speed: (json['speed'] as num?)?.toDouble() ?? 0.0,
      deg: json['deg'] as int? ?? 0,
      gust: (json['gust'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$_WindObjectToJson(_$_WindObject instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust,
    };

_$_CloudsObject _$$_CloudsObjectFromJson(Map<String, dynamic> json) =>
    _$_CloudsObject(
      all: json['all'] as int? ?? 0,
    );

Map<String, dynamic> _$$_CloudsObjectToJson(_$_CloudsObject instance) =>
    <String, dynamic>{
      'all': instance.all,
    };

_$_SysObject _$$_SysObjectFromJson(Map<String, dynamic> json) => _$_SysObject(
      type: json['type'] as int? ?? 0,
      id: json['id'] as int? ?? 0,
      country: json['country'] as String? ?? '',
      sunrise: json['sunrise'] as int? ?? 0,
      sunset: json['sunset'] as int? ?? 0,
    );

Map<String, dynamic> _$$_SysObjectToJson(_$_SysObject instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'country': instance.country,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
