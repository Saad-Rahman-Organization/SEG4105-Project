// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppPreferences _$AppPreferencesFromJson(Map<String, dynamic> json) {
  return _AppPreferences.fromJson(json);
}

/// @nodoc
mixin _$AppPreferences {
  AppTheme get theme => throw _privateConstructorUsedError;
  UnitsPreference get units => throw _privateConstructorUsedError;

  /// Serializes this AppPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppPreferencesCopyWith<AppPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppPreferencesCopyWith<$Res> {
  factory $AppPreferencesCopyWith(
          AppPreferences value, $Res Function(AppPreferences) then) =
      _$AppPreferencesCopyWithImpl<$Res, AppPreferences>;
  @useResult
  $Res call({AppTheme theme, UnitsPreference units});
}

/// @nodoc
class _$AppPreferencesCopyWithImpl<$Res, $Val extends AppPreferences>
    implements $AppPreferencesCopyWith<$Res> {
  _$AppPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? units = null,
  }) {
    return _then(_value.copyWith(
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as AppTheme,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as UnitsPreference,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppPreferencesImplCopyWith<$Res>
    implements $AppPreferencesCopyWith<$Res> {
  factory _$$AppPreferencesImplCopyWith(_$AppPreferencesImpl value,
          $Res Function(_$AppPreferencesImpl) then) =
      __$$AppPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppTheme theme, UnitsPreference units});
}

/// @nodoc
class __$$AppPreferencesImplCopyWithImpl<$Res>
    extends _$AppPreferencesCopyWithImpl<$Res, _$AppPreferencesImpl>
    implements _$$AppPreferencesImplCopyWith<$Res> {
  __$$AppPreferencesImplCopyWithImpl(
      _$AppPreferencesImpl _value, $Res Function(_$AppPreferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? units = null,
  }) {
    return _then(_$AppPreferencesImpl(
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as AppTheme,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as UnitsPreference,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppPreferencesImpl extends _AppPreferences {
  const _$AppPreferencesImpl({required this.theme, required this.units})
      : super._();

  factory _$AppPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppPreferencesImplFromJson(json);

  @override
  final AppTheme theme;
  @override
  final UnitsPreference units;

  @override
  String toString() {
    return 'AppPreferences(theme: $theme, units: $units)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppPreferencesImpl &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.units, units) || other.units == units));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, theme, units);

  /// Create a copy of AppPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppPreferencesImplCopyWith<_$AppPreferencesImpl> get copyWith =>
      __$$AppPreferencesImplCopyWithImpl<_$AppPreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppPreferencesImplToJson(
      this,
    );
  }
}

abstract class _AppPreferences extends AppPreferences {
  const factory _AppPreferences(
      {required final AppTheme theme,
      required final UnitsPreference units}) = _$AppPreferencesImpl;
  const _AppPreferences._() : super._();

  factory _AppPreferences.fromJson(Map<String, dynamic> json) =
      _$AppPreferencesImpl.fromJson;

  @override
  AppTheme get theme;
  @override
  UnitsPreference get units;

  /// Create a copy of AppPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppPreferencesImplCopyWith<_$AppPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
