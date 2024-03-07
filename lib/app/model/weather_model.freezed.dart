// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) {
  return _WeatherModel.fromJson(json);
}

/// @nodoc
mixin _$WeatherModel {
  int get statusCode => throw _privateConstructorUsedError;
  CoordObject? get coord => throw _privateConstructorUsedError;
  String get base => throw _privateConstructorUsedError;
  MainObject? get main => throw _privateConstructorUsedError;
  WindObject? get wind => throw _privateConstructorUsedError;
  int get visibility => throw _privateConstructorUsedError;
  int get dt => throw _privateConstructorUsedError;
  int get timezone => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get cod => throw _privateConstructorUsedError;
  CloudsObject? get clouds => throw _privateConstructorUsedError;
  SysObject? get sys => throw _privateConstructorUsedError;
  List<WeatherTwoObject>? get weather => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherModelCopyWith<WeatherModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherModelCopyWith<$Res> {
  factory $WeatherModelCopyWith(
          WeatherModel value, $Res Function(WeatherModel) then) =
      _$WeatherModelCopyWithImpl<$Res, WeatherModel>;
  @useResult
  $Res call(
      {int statusCode,
      CoordObject? coord,
      String base,
      MainObject? main,
      WindObject? wind,
      int visibility,
      int dt,
      int timezone,
      int id,
      String name,
      int cod,
      CloudsObject? clouds,
      SysObject? sys,
      List<WeatherTwoObject>? weather});

  $CoordObjectCopyWith<$Res>? get coord;
  $MainObjectCopyWith<$Res>? get main;
  $WindObjectCopyWith<$Res>? get wind;
  $CloudsObjectCopyWith<$Res>? get clouds;
  $SysObjectCopyWith<$Res>? get sys;
}

/// @nodoc
class _$WeatherModelCopyWithImpl<$Res, $Val extends WeatherModel>
    implements $WeatherModelCopyWith<$Res> {
  _$WeatherModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? coord = freezed,
    Object? base = null,
    Object? main = freezed,
    Object? wind = freezed,
    Object? visibility = null,
    Object? dt = null,
    Object? timezone = null,
    Object? id = null,
    Object? name = null,
    Object? cod = null,
    Object? clouds = freezed,
    Object? sys = freezed,
    Object? weather = freezed,
  }) {
    return _then(_value.copyWith(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      coord: freezed == coord
          ? _value.coord
          : coord // ignore: cast_nullable_to_non_nullable
              as CoordObject?,
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      main: freezed == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as MainObject?,
      wind: freezed == wind
          ? _value.wind
          : wind // ignore: cast_nullable_to_non_nullable
              as WindObject?,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as int,
      dt: null == dt
          ? _value.dt
          : dt // ignore: cast_nullable_to_non_nullable
              as int,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      cod: null == cod
          ? _value.cod
          : cod // ignore: cast_nullable_to_non_nullable
              as int,
      clouds: freezed == clouds
          ? _value.clouds
          : clouds // ignore: cast_nullable_to_non_nullable
              as CloudsObject?,
      sys: freezed == sys
          ? _value.sys
          : sys // ignore: cast_nullable_to_non_nullable
              as SysObject?,
      weather: freezed == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as List<WeatherTwoObject>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CoordObjectCopyWith<$Res>? get coord {
    if (_value.coord == null) {
      return null;
    }

    return $CoordObjectCopyWith<$Res>(_value.coord!, (value) {
      return _then(_value.copyWith(coord: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MainObjectCopyWith<$Res>? get main {
    if (_value.main == null) {
      return null;
    }

    return $MainObjectCopyWith<$Res>(_value.main!, (value) {
      return _then(_value.copyWith(main: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WindObjectCopyWith<$Res>? get wind {
    if (_value.wind == null) {
      return null;
    }

    return $WindObjectCopyWith<$Res>(_value.wind!, (value) {
      return _then(_value.copyWith(wind: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CloudsObjectCopyWith<$Res>? get clouds {
    if (_value.clouds == null) {
      return null;
    }

    return $CloudsObjectCopyWith<$Res>(_value.clouds!, (value) {
      return _then(_value.copyWith(clouds: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SysObjectCopyWith<$Res>? get sys {
    if (_value.sys == null) {
      return null;
    }

    return $SysObjectCopyWith<$Res>(_value.sys!, (value) {
      return _then(_value.copyWith(sys: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WeatherModelCopyWith<$Res>
    implements $WeatherModelCopyWith<$Res> {
  factory _$$_WeatherModelCopyWith(
          _$_WeatherModel value, $Res Function(_$_WeatherModel) then) =
      __$$_WeatherModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int statusCode,
      CoordObject? coord,
      String base,
      MainObject? main,
      WindObject? wind,
      int visibility,
      int dt,
      int timezone,
      int id,
      String name,
      int cod,
      CloudsObject? clouds,
      SysObject? sys,
      List<WeatherTwoObject>? weather});

  @override
  $CoordObjectCopyWith<$Res>? get coord;
  @override
  $MainObjectCopyWith<$Res>? get main;
  @override
  $WindObjectCopyWith<$Res>? get wind;
  @override
  $CloudsObjectCopyWith<$Res>? get clouds;
  @override
  $SysObjectCopyWith<$Res>? get sys;
}

/// @nodoc
class __$$_WeatherModelCopyWithImpl<$Res>
    extends _$WeatherModelCopyWithImpl<$Res, _$_WeatherModel>
    implements _$$_WeatherModelCopyWith<$Res> {
  __$$_WeatherModelCopyWithImpl(
      _$_WeatherModel _value, $Res Function(_$_WeatherModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? coord = freezed,
    Object? base = null,
    Object? main = freezed,
    Object? wind = freezed,
    Object? visibility = null,
    Object? dt = null,
    Object? timezone = null,
    Object? id = null,
    Object? name = null,
    Object? cod = null,
    Object? clouds = freezed,
    Object? sys = freezed,
    Object? weather = freezed,
  }) {
    return _then(_$_WeatherModel(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      coord: freezed == coord
          ? _value.coord
          : coord // ignore: cast_nullable_to_non_nullable
              as CoordObject?,
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      main: freezed == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as MainObject?,
      wind: freezed == wind
          ? _value.wind
          : wind // ignore: cast_nullable_to_non_nullable
              as WindObject?,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as int,
      dt: null == dt
          ? _value.dt
          : dt // ignore: cast_nullable_to_non_nullable
              as int,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      cod: null == cod
          ? _value.cod
          : cod // ignore: cast_nullable_to_non_nullable
              as int,
      clouds: freezed == clouds
          ? _value.clouds
          : clouds // ignore: cast_nullable_to_non_nullable
              as CloudsObject?,
      sys: freezed == sys
          ? _value.sys
          : sys // ignore: cast_nullable_to_non_nullable
              as SysObject?,
      weather: freezed == weather
          ? _value._weather
          : weather // ignore: cast_nullable_to_non_nullable
              as List<WeatherTwoObject>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WeatherModel implements _WeatherModel {
  _$_WeatherModel(
      {this.statusCode = 0,
      this.coord,
      this.base = '',
      this.main,
      this.wind,
      this.visibility = 0,
      this.dt = 0,
      this.timezone = 0,
      this.id = 0,
      this.name = '',
      this.cod = 0,
      this.clouds,
      this.sys,
      final List<WeatherTwoObject>? weather})
      : _weather = weather;

  factory _$_WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$$_WeatherModelFromJson(json);

  @override
  @JsonKey()
  final int statusCode;
  @override
  final CoordObject? coord;
  @override
  @JsonKey()
  final String base;
  @override
  final MainObject? main;
  @override
  final WindObject? wind;
  @override
  @JsonKey()
  final int visibility;
  @override
  @JsonKey()
  final int dt;
  @override
  @JsonKey()
  final int timezone;
  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final int cod;
  @override
  final CloudsObject? clouds;
  @override
  final SysObject? sys;
  final List<WeatherTwoObject>? _weather;
  @override
  List<WeatherTwoObject>? get weather {
    final value = _weather;
    if (value == null) return null;
    if (_weather is EqualUnmodifiableListView) return _weather;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WeatherModel(statusCode: $statusCode, coord: $coord, base: $base, main: $main, wind: $wind, visibility: $visibility, dt: $dt, timezone: $timezone, id: $id, name: $name, cod: $cod, clouds: $clouds, sys: $sys, weather: $weather)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WeatherModel &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.coord, coord) || other.coord == coord) &&
            (identical(other.base, base) || other.base == base) &&
            (identical(other.main, main) || other.main == main) &&
            (identical(other.wind, wind) || other.wind == wind) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.dt, dt) || other.dt == dt) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.cod, cod) || other.cod == cod) &&
            (identical(other.clouds, clouds) || other.clouds == clouds) &&
            (identical(other.sys, sys) || other.sys == sys) &&
            const DeepCollectionEquality().equals(other._weather, _weather));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      statusCode,
      coord,
      base,
      main,
      wind,
      visibility,
      dt,
      timezone,
      id,
      name,
      cod,
      clouds,
      sys,
      const DeepCollectionEquality().hash(_weather));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WeatherModelCopyWith<_$_WeatherModel> get copyWith =>
      __$$_WeatherModelCopyWithImpl<_$_WeatherModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WeatherModelToJson(
      this,
    );
  }
}

abstract class _WeatherModel implements WeatherModel {
  factory _WeatherModel(
      {final int statusCode,
      final CoordObject? coord,
      final String base,
      final MainObject? main,
      final WindObject? wind,
      final int visibility,
      final int dt,
      final int timezone,
      final int id,
      final String name,
      final int cod,
      final CloudsObject? clouds,
      final SysObject? sys,
      final List<WeatherTwoObject>? weather}) = _$_WeatherModel;

  factory _WeatherModel.fromJson(Map<String, dynamic> json) =
      _$_WeatherModel.fromJson;

  @override
  int get statusCode;
  @override
  CoordObject? get coord;
  @override
  String get base;
  @override
  MainObject? get main;
  @override
  WindObject? get wind;
  @override
  int get visibility;
  @override
  int get dt;
  @override
  int get timezone;
  @override
  int get id;
  @override
  String get name;
  @override
  int get cod;
  @override
  CloudsObject? get clouds;
  @override
  SysObject? get sys;
  @override
  List<WeatherTwoObject>? get weather;
  @override
  @JsonKey(ignore: true)
  _$$_WeatherModelCopyWith<_$_WeatherModel> get copyWith =>
      throw _privateConstructorUsedError;
}

CoordObject _$CoordObjectFromJson(Map<String, dynamic> json) {
  return _CoordObject.fromJson(json);
}

/// @nodoc
mixin _$CoordObject {
  double get lon => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CoordObjectCopyWith<CoordObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoordObjectCopyWith<$Res> {
  factory $CoordObjectCopyWith(
          CoordObject value, $Res Function(CoordObject) then) =
      _$CoordObjectCopyWithImpl<$Res, CoordObject>;
  @useResult
  $Res call({double lon, double lat});
}

/// @nodoc
class _$CoordObjectCopyWithImpl<$Res, $Val extends CoordObject>
    implements $CoordObjectCopyWith<$Res> {
  _$CoordObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lon = null,
    Object? lat = null,
  }) {
    return _then(_value.copyWith(
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CoordObjectCopyWith<$Res>
    implements $CoordObjectCopyWith<$Res> {
  factory _$$_CoordObjectCopyWith(
          _$_CoordObject value, $Res Function(_$_CoordObject) then) =
      __$$_CoordObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double lon, double lat});
}

/// @nodoc
class __$$_CoordObjectCopyWithImpl<$Res>
    extends _$CoordObjectCopyWithImpl<$Res, _$_CoordObject>
    implements _$$_CoordObjectCopyWith<$Res> {
  __$$_CoordObjectCopyWithImpl(
      _$_CoordObject _value, $Res Function(_$_CoordObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lon = null,
    Object? lat = null,
  }) {
    return _then(_$_CoordObject(
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CoordObject implements _CoordObject {
  _$_CoordObject({this.lon = 0.0, this.lat = 0.0});

  factory _$_CoordObject.fromJson(Map<String, dynamic> json) =>
      _$$_CoordObjectFromJson(json);

  @override
  @JsonKey()
  final double lon;
  @override
  @JsonKey()
  final double lat;

  @override
  String toString() {
    return 'CoordObject(lon: $lon, lat: $lat)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CoordObject &&
            (identical(other.lon, lon) || other.lon == lon) &&
            (identical(other.lat, lat) || other.lat == lat));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lon, lat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CoordObjectCopyWith<_$_CoordObject> get copyWith =>
      __$$_CoordObjectCopyWithImpl<_$_CoordObject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CoordObjectToJson(
      this,
    );
  }
}

abstract class _CoordObject implements CoordObject {
  factory _CoordObject({final double lon, final double lat}) = _$_CoordObject;

  factory _CoordObject.fromJson(Map<String, dynamic> json) =
      _$_CoordObject.fromJson;

  @override
  double get lon;
  @override
  double get lat;
  @override
  @JsonKey(ignore: true)
  _$$_CoordObjectCopyWith<_$_CoordObject> get copyWith =>
      throw _privateConstructorUsedError;
}

WeatherTwoObject _$WeatherTwoObjectFromJson(Map<String, dynamic> json) {
  return _WeatherTwoObject.fromJson(json);
}

/// @nodoc
mixin _$WeatherTwoObject {
  int get id => throw _privateConstructorUsedError;
  String get main => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherTwoObjectCopyWith<WeatherTwoObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherTwoObjectCopyWith<$Res> {
  factory $WeatherTwoObjectCopyWith(
          WeatherTwoObject value, $Res Function(WeatherTwoObject) then) =
      _$WeatherTwoObjectCopyWithImpl<$Res, WeatherTwoObject>;
  @useResult
  $Res call({int id, String main, String description, String icon});
}

/// @nodoc
class _$WeatherTwoObjectCopyWithImpl<$Res, $Val extends WeatherTwoObject>
    implements $WeatherTwoObjectCopyWith<$Res> {
  _$WeatherTwoObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? main = null,
    Object? description = null,
    Object? icon = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      main: null == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WeatherTwoObjectCopyWith<$Res>
    implements $WeatherTwoObjectCopyWith<$Res> {
  factory _$$_WeatherTwoObjectCopyWith(
          _$_WeatherTwoObject value, $Res Function(_$_WeatherTwoObject) then) =
      __$$_WeatherTwoObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String main, String description, String icon});
}

/// @nodoc
class __$$_WeatherTwoObjectCopyWithImpl<$Res>
    extends _$WeatherTwoObjectCopyWithImpl<$Res, _$_WeatherTwoObject>
    implements _$$_WeatherTwoObjectCopyWith<$Res> {
  __$$_WeatherTwoObjectCopyWithImpl(
      _$_WeatherTwoObject _value, $Res Function(_$_WeatherTwoObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? main = null,
    Object? description = null,
    Object? icon = null,
  }) {
    return _then(_$_WeatherTwoObject(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      main: null == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WeatherTwoObject implements _WeatherTwoObject {
  _$_WeatherTwoObject(
      {this.id = 0, this.main = '', this.description = '', this.icon = ''});

  factory _$_WeatherTwoObject.fromJson(Map<String, dynamic> json) =>
      _$$_WeatherTwoObjectFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String main;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String icon;

  @override
  String toString() {
    return 'WeatherTwoObject(id: $id, main: $main, description: $description, icon: $icon)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WeatherTwoObject &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.main, main) || other.main == main) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, main, description, icon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WeatherTwoObjectCopyWith<_$_WeatherTwoObject> get copyWith =>
      __$$_WeatherTwoObjectCopyWithImpl<_$_WeatherTwoObject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WeatherTwoObjectToJson(
      this,
    );
  }
}

abstract class _WeatherTwoObject implements WeatherTwoObject {
  factory _WeatherTwoObject(
      {final int id,
      final String main,
      final String description,
      final String icon}) = _$_WeatherTwoObject;

  factory _WeatherTwoObject.fromJson(Map<String, dynamic> json) =
      _$_WeatherTwoObject.fromJson;

  @override
  int get id;
  @override
  String get main;
  @override
  String get description;
  @override
  String get icon;
  @override
  @JsonKey(ignore: true)
  _$$_WeatherTwoObjectCopyWith<_$_WeatherTwoObject> get copyWith =>
      throw _privateConstructorUsedError;
}

MainObject _$MainObjectFromJson(Map<String, dynamic> json) {
  return _MainObject.fromJson(json);
}

/// @nodoc
mixin _$MainObject {
  double get temp => throw _privateConstructorUsedError;
  double get feels_like => throw _privateConstructorUsedError;
  double get temp_min => throw _privateConstructorUsedError;
  double get temp_max => throw _privateConstructorUsedError;
  int get pressure => throw _privateConstructorUsedError;
  int get humidity => throw _privateConstructorUsedError;
  int get sea_level => throw _privateConstructorUsedError;
  int get grnd_level => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MainObjectCopyWith<MainObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainObjectCopyWith<$Res> {
  factory $MainObjectCopyWith(
          MainObject value, $Res Function(MainObject) then) =
      _$MainObjectCopyWithImpl<$Res, MainObject>;
  @useResult
  $Res call(
      {double temp,
      double feels_like,
      double temp_min,
      double temp_max,
      int pressure,
      int humidity,
      int sea_level,
      int grnd_level});
}

/// @nodoc
class _$MainObjectCopyWithImpl<$Res, $Val extends MainObject>
    implements $MainObjectCopyWith<$Res> {
  _$MainObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temp = null,
    Object? feels_like = null,
    Object? temp_min = null,
    Object? temp_max = null,
    Object? pressure = null,
    Object? humidity = null,
    Object? sea_level = null,
    Object? grnd_level = null,
  }) {
    return _then(_value.copyWith(
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as double,
      feels_like: null == feels_like
          ? _value.feels_like
          : feels_like // ignore: cast_nullable_to_non_nullable
              as double,
      temp_min: null == temp_min
          ? _value.temp_min
          : temp_min // ignore: cast_nullable_to_non_nullable
              as double,
      temp_max: null == temp_max
          ? _value.temp_max
          : temp_max // ignore: cast_nullable_to_non_nullable
              as double,
      pressure: null == pressure
          ? _value.pressure
          : pressure // ignore: cast_nullable_to_non_nullable
              as int,
      humidity: null == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as int,
      sea_level: null == sea_level
          ? _value.sea_level
          : sea_level // ignore: cast_nullable_to_non_nullable
              as int,
      grnd_level: null == grnd_level
          ? _value.grnd_level
          : grnd_level // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MainObjectCopyWith<$Res>
    implements $MainObjectCopyWith<$Res> {
  factory _$$_MainObjectCopyWith(
          _$_MainObject value, $Res Function(_$_MainObject) then) =
      __$$_MainObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double temp,
      double feels_like,
      double temp_min,
      double temp_max,
      int pressure,
      int humidity,
      int sea_level,
      int grnd_level});
}

/// @nodoc
class __$$_MainObjectCopyWithImpl<$Res>
    extends _$MainObjectCopyWithImpl<$Res, _$_MainObject>
    implements _$$_MainObjectCopyWith<$Res> {
  __$$_MainObjectCopyWithImpl(
      _$_MainObject _value, $Res Function(_$_MainObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temp = null,
    Object? feels_like = null,
    Object? temp_min = null,
    Object? temp_max = null,
    Object? pressure = null,
    Object? humidity = null,
    Object? sea_level = null,
    Object? grnd_level = null,
  }) {
    return _then(_$_MainObject(
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as double,
      feels_like: null == feels_like
          ? _value.feels_like
          : feels_like // ignore: cast_nullable_to_non_nullable
              as double,
      temp_min: null == temp_min
          ? _value.temp_min
          : temp_min // ignore: cast_nullable_to_non_nullable
              as double,
      temp_max: null == temp_max
          ? _value.temp_max
          : temp_max // ignore: cast_nullable_to_non_nullable
              as double,
      pressure: null == pressure
          ? _value.pressure
          : pressure // ignore: cast_nullable_to_non_nullable
              as int,
      humidity: null == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as int,
      sea_level: null == sea_level
          ? _value.sea_level
          : sea_level // ignore: cast_nullable_to_non_nullable
              as int,
      grnd_level: null == grnd_level
          ? _value.grnd_level
          : grnd_level // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MainObject implements _MainObject {
  _$_MainObject(
      {this.temp = 0.0,
      this.feels_like = 0.0,
      this.temp_min = 0.0,
      this.temp_max = 0.0,
      this.pressure = 0,
      this.humidity = 0,
      this.sea_level = 0,
      this.grnd_level = 0});

  factory _$_MainObject.fromJson(Map<String, dynamic> json) =>
      _$$_MainObjectFromJson(json);

  @override
  @JsonKey()
  final double temp;
  @override
  @JsonKey()
  final double feels_like;
  @override
  @JsonKey()
  final double temp_min;
  @override
  @JsonKey()
  final double temp_max;
  @override
  @JsonKey()
  final int pressure;
  @override
  @JsonKey()
  final int humidity;
  @override
  @JsonKey()
  final int sea_level;
  @override
  @JsonKey()
  final int grnd_level;

  @override
  String toString() {
    return 'MainObject(temp: $temp, feels_like: $feels_like, temp_min: $temp_min, temp_max: $temp_max, pressure: $pressure, humidity: $humidity, sea_level: $sea_level, grnd_level: $grnd_level)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MainObject &&
            (identical(other.temp, temp) || other.temp == temp) &&
            (identical(other.feels_like, feels_like) ||
                other.feels_like == feels_like) &&
            (identical(other.temp_min, temp_min) ||
                other.temp_min == temp_min) &&
            (identical(other.temp_max, temp_max) ||
                other.temp_max == temp_max) &&
            (identical(other.pressure, pressure) ||
                other.pressure == pressure) &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.sea_level, sea_level) ||
                other.sea_level == sea_level) &&
            (identical(other.grnd_level, grnd_level) ||
                other.grnd_level == grnd_level));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, temp, feels_like, temp_min,
      temp_max, pressure, humidity, sea_level, grnd_level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MainObjectCopyWith<_$_MainObject> get copyWith =>
      __$$_MainObjectCopyWithImpl<_$_MainObject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MainObjectToJson(
      this,
    );
  }
}

abstract class _MainObject implements MainObject {
  factory _MainObject(
      {final double temp,
      final double feels_like,
      final double temp_min,
      final double temp_max,
      final int pressure,
      final int humidity,
      final int sea_level,
      final int grnd_level}) = _$_MainObject;

  factory _MainObject.fromJson(Map<String, dynamic> json) =
      _$_MainObject.fromJson;

  @override
  double get temp;
  @override
  double get feels_like;
  @override
  double get temp_min;
  @override
  double get temp_max;
  @override
  int get pressure;
  @override
  int get humidity;
  @override
  int get sea_level;
  @override
  int get grnd_level;
  @override
  @JsonKey(ignore: true)
  _$$_MainObjectCopyWith<_$_MainObject> get copyWith =>
      throw _privateConstructorUsedError;
}

WindObject _$WindObjectFromJson(Map<String, dynamic> json) {
  return _WindObject.fromJson(json);
}

/// @nodoc
mixin _$WindObject {
  double get speed => throw _privateConstructorUsedError;
  int get deg => throw _privateConstructorUsedError;
  double get gust => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WindObjectCopyWith<WindObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WindObjectCopyWith<$Res> {
  factory $WindObjectCopyWith(
          WindObject value, $Res Function(WindObject) then) =
      _$WindObjectCopyWithImpl<$Res, WindObject>;
  @useResult
  $Res call({double speed, int deg, double gust});
}

/// @nodoc
class _$WindObjectCopyWithImpl<$Res, $Val extends WindObject>
    implements $WindObjectCopyWith<$Res> {
  _$WindObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
    Object? deg = null,
    Object? gust = null,
  }) {
    return _then(_value.copyWith(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      deg: null == deg
          ? _value.deg
          : deg // ignore: cast_nullable_to_non_nullable
              as int,
      gust: null == gust
          ? _value.gust
          : gust // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WindObjectCopyWith<$Res>
    implements $WindObjectCopyWith<$Res> {
  factory _$$_WindObjectCopyWith(
          _$_WindObject value, $Res Function(_$_WindObject) then) =
      __$$_WindObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double speed, int deg, double gust});
}

/// @nodoc
class __$$_WindObjectCopyWithImpl<$Res>
    extends _$WindObjectCopyWithImpl<$Res, _$_WindObject>
    implements _$$_WindObjectCopyWith<$Res> {
  __$$_WindObjectCopyWithImpl(
      _$_WindObject _value, $Res Function(_$_WindObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
    Object? deg = null,
    Object? gust = null,
  }) {
    return _then(_$_WindObject(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      deg: null == deg
          ? _value.deg
          : deg // ignore: cast_nullable_to_non_nullable
              as int,
      gust: null == gust
          ? _value.gust
          : gust // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WindObject implements _WindObject {
  _$_WindObject({this.speed = 0.0, this.deg = 0, this.gust = 0.0});

  factory _$_WindObject.fromJson(Map<String, dynamic> json) =>
      _$$_WindObjectFromJson(json);

  @override
  @JsonKey()
  final double speed;
  @override
  @JsonKey()
  final int deg;
  @override
  @JsonKey()
  final double gust;

  @override
  String toString() {
    return 'WindObject(speed: $speed, deg: $deg, gust: $gust)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WindObject &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.deg, deg) || other.deg == deg) &&
            (identical(other.gust, gust) || other.gust == gust));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, speed, deg, gust);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WindObjectCopyWith<_$_WindObject> get copyWith =>
      __$$_WindObjectCopyWithImpl<_$_WindObject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WindObjectToJson(
      this,
    );
  }
}

abstract class _WindObject implements WindObject {
  factory _WindObject({final double speed, final int deg, final double gust}) =
      _$_WindObject;

  factory _WindObject.fromJson(Map<String, dynamic> json) =
      _$_WindObject.fromJson;

  @override
  double get speed;
  @override
  int get deg;
  @override
  double get gust;
  @override
  @JsonKey(ignore: true)
  _$$_WindObjectCopyWith<_$_WindObject> get copyWith =>
      throw _privateConstructorUsedError;
}

CloudsObject _$CloudsObjectFromJson(Map<String, dynamic> json) {
  return _CloudsObject.fromJson(json);
}

/// @nodoc
mixin _$CloudsObject {
  int get all => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CloudsObjectCopyWith<CloudsObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CloudsObjectCopyWith<$Res> {
  factory $CloudsObjectCopyWith(
          CloudsObject value, $Res Function(CloudsObject) then) =
      _$CloudsObjectCopyWithImpl<$Res, CloudsObject>;
  @useResult
  $Res call({int all});
}

/// @nodoc
class _$CloudsObjectCopyWithImpl<$Res, $Val extends CloudsObject>
    implements $CloudsObjectCopyWith<$Res> {
  _$CloudsObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? all = null,
  }) {
    return _then(_value.copyWith(
      all: null == all
          ? _value.all
          : all // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CloudsObjectCopyWith<$Res>
    implements $CloudsObjectCopyWith<$Res> {
  factory _$$_CloudsObjectCopyWith(
          _$_CloudsObject value, $Res Function(_$_CloudsObject) then) =
      __$$_CloudsObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int all});
}

/// @nodoc
class __$$_CloudsObjectCopyWithImpl<$Res>
    extends _$CloudsObjectCopyWithImpl<$Res, _$_CloudsObject>
    implements _$$_CloudsObjectCopyWith<$Res> {
  __$$_CloudsObjectCopyWithImpl(
      _$_CloudsObject _value, $Res Function(_$_CloudsObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? all = null,
  }) {
    return _then(_$_CloudsObject(
      all: null == all
          ? _value.all
          : all // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CloudsObject implements _CloudsObject {
  _$_CloudsObject({this.all = 0});

  factory _$_CloudsObject.fromJson(Map<String, dynamic> json) =>
      _$$_CloudsObjectFromJson(json);

  @override
  @JsonKey()
  final int all;

  @override
  String toString() {
    return 'CloudsObject(all: $all)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CloudsObject &&
            (identical(other.all, all) || other.all == all));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, all);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CloudsObjectCopyWith<_$_CloudsObject> get copyWith =>
      __$$_CloudsObjectCopyWithImpl<_$_CloudsObject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CloudsObjectToJson(
      this,
    );
  }
}

abstract class _CloudsObject implements CloudsObject {
  factory _CloudsObject({final int all}) = _$_CloudsObject;

  factory _CloudsObject.fromJson(Map<String, dynamic> json) =
      _$_CloudsObject.fromJson;

  @override
  int get all;
  @override
  @JsonKey(ignore: true)
  _$$_CloudsObjectCopyWith<_$_CloudsObject> get copyWith =>
      throw _privateConstructorUsedError;
}

SysObject _$SysObjectFromJson(Map<String, dynamic> json) {
  return _SysObject.fromJson(json);
}

/// @nodoc
mixin _$SysObject {
  int get type => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  int get sunrise => throw _privateConstructorUsedError;
  int get sunset => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SysObjectCopyWith<SysObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SysObjectCopyWith<$Res> {
  factory $SysObjectCopyWith(SysObject value, $Res Function(SysObject) then) =
      _$SysObjectCopyWithImpl<$Res, SysObject>;
  @useResult
  $Res call({int type, int id, String country, int sunrise, int sunset});
}

/// @nodoc
class _$SysObjectCopyWithImpl<$Res, $Val extends SysObject>
    implements $SysObjectCopyWith<$Res> {
  _$SysObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
    Object? country = null,
    Object? sunrise = null,
    Object? sunset = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      sunrise: null == sunrise
          ? _value.sunrise
          : sunrise // ignore: cast_nullable_to_non_nullable
              as int,
      sunset: null == sunset
          ? _value.sunset
          : sunset // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SysObjectCopyWith<$Res> implements $SysObjectCopyWith<$Res> {
  factory _$$_SysObjectCopyWith(
          _$_SysObject value, $Res Function(_$_SysObject) then) =
      __$$_SysObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int type, int id, String country, int sunrise, int sunset});
}

/// @nodoc
class __$$_SysObjectCopyWithImpl<$Res>
    extends _$SysObjectCopyWithImpl<$Res, _$_SysObject>
    implements _$$_SysObjectCopyWith<$Res> {
  __$$_SysObjectCopyWithImpl(
      _$_SysObject _value, $Res Function(_$_SysObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
    Object? country = null,
    Object? sunrise = null,
    Object? sunset = null,
  }) {
    return _then(_$_SysObject(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      sunrise: null == sunrise
          ? _value.sunrise
          : sunrise // ignore: cast_nullable_to_non_nullable
              as int,
      sunset: null == sunset
          ? _value.sunset
          : sunset // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SysObject implements _SysObject {
  _$_SysObject(
      {this.type = 0,
      this.id = 0,
      this.country = '',
      this.sunrise = 0,
      this.sunset = 0});

  factory _$_SysObject.fromJson(Map<String, dynamic> json) =>
      _$$_SysObjectFromJson(json);

  @override
  @JsonKey()
  final int type;
  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String country;
  @override
  @JsonKey()
  final int sunrise;
  @override
  @JsonKey()
  final int sunset;

  @override
  String toString() {
    return 'SysObject(type: $type, id: $id, country: $country, sunrise: $sunrise, sunset: $sunset)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SysObject &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.sunrise, sunrise) || other.sunrise == sunrise) &&
            (identical(other.sunset, sunset) || other.sunset == sunset));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, id, country, sunrise, sunset);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SysObjectCopyWith<_$_SysObject> get copyWith =>
      __$$_SysObjectCopyWithImpl<_$_SysObject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SysObjectToJson(
      this,
    );
  }
}

abstract class _SysObject implements SysObject {
  factory _SysObject(
      {final int type,
      final int id,
      final String country,
      final int sunrise,
      final int sunset}) = _$_SysObject;

  factory _SysObject.fromJson(Map<String, dynamic> json) =
      _$_SysObject.fromJson;

  @override
  int get type;
  @override
  int get id;
  @override
  String get country;
  @override
  int get sunrise;
  @override
  int get sunset;
  @override
  @JsonKey(ignore: true)
  _$$_SysObjectCopyWith<_$_SysObject> get copyWith =>
      throw _privateConstructorUsedError;
}
