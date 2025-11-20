// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  double get heightValue => throw _privateConstructorUsedError;
  HeightUnit get heightUnit => throw _privateConstructorUsedError;
  double get weightValue => throw _privateConstructorUsedError;
  WeightUnit get weightUnit => throw _privateConstructorUsedError;
  ActivityLevel get activityLevel => throw _privateConstructorUsedError;
  int? get dailyCalorieGoal => throw _privateConstructorUsedError;
  bool get onboardingCompleted => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call(
      {String id,
      String? name,
      double heightValue,
      HeightUnit heightUnit,
      double weightValue,
      WeightUnit weightUnit,
      ActivityLevel activityLevel,
      int? dailyCalorieGoal,
      bool onboardingCompleted});
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? heightValue = null,
    Object? heightUnit = null,
    Object? weightValue = null,
    Object? weightUnit = null,
    Object? activityLevel = null,
    Object? dailyCalorieGoal = freezed,
    Object? onboardingCompleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      heightValue: null == heightValue
          ? _value.heightValue
          : heightValue // ignore: cast_nullable_to_non_nullable
              as double,
      heightUnit: null == heightUnit
          ? _value.heightUnit
          : heightUnit // ignore: cast_nullable_to_non_nullable
              as HeightUnit,
      weightValue: null == weightValue
          ? _value.weightValue
          : weightValue // ignore: cast_nullable_to_non_nullable
              as double,
      weightUnit: null == weightUnit
          ? _value.weightUnit
          : weightUnit // ignore: cast_nullable_to_non_nullable
              as WeightUnit,
      activityLevel: null == activityLevel
          ? _value.activityLevel
          : activityLevel // ignore: cast_nullable_to_non_nullable
              as ActivityLevel,
      dailyCalorieGoal: freezed == dailyCalorieGoal
          ? _value.dailyCalorieGoal
          : dailyCalorieGoal // ignore: cast_nullable_to_non_nullable
              as int?,
      onboardingCompleted: null == onboardingCompleted
          ? _value.onboardingCompleted
          : onboardingCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
          _$UserProfileImpl value, $Res Function(_$UserProfileImpl) then) =
      __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? name,
      double heightValue,
      HeightUnit heightUnit,
      double weightValue,
      WeightUnit weightUnit,
      ActivityLevel activityLevel,
      int? dailyCalorieGoal,
      bool onboardingCompleted});
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
      _$UserProfileImpl _value, $Res Function(_$UserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? heightValue = null,
    Object? heightUnit = null,
    Object? weightValue = null,
    Object? weightUnit = null,
    Object? activityLevel = null,
    Object? dailyCalorieGoal = freezed,
    Object? onboardingCompleted = null,
  }) {
    return _then(_$UserProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      heightValue: null == heightValue
          ? _value.heightValue
          : heightValue // ignore: cast_nullable_to_non_nullable
              as double,
      heightUnit: null == heightUnit
          ? _value.heightUnit
          : heightUnit // ignore: cast_nullable_to_non_nullable
              as HeightUnit,
      weightValue: null == weightValue
          ? _value.weightValue
          : weightValue // ignore: cast_nullable_to_non_nullable
              as double,
      weightUnit: null == weightUnit
          ? _value.weightUnit
          : weightUnit // ignore: cast_nullable_to_non_nullable
              as WeightUnit,
      activityLevel: null == activityLevel
          ? _value.activityLevel
          : activityLevel // ignore: cast_nullable_to_non_nullable
              as ActivityLevel,
      dailyCalorieGoal: freezed == dailyCalorieGoal
          ? _value.dailyCalorieGoal
          : dailyCalorieGoal // ignore: cast_nullable_to_non_nullable
              as int?,
      onboardingCompleted: null == onboardingCompleted
          ? _value.onboardingCompleted
          : onboardingCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl extends _UserProfile {
  const _$UserProfileImpl(
      {required this.id,
      this.name,
      required this.heightValue,
      required this.heightUnit,
      required this.weightValue,
      required this.weightUnit,
      required this.activityLevel,
      this.dailyCalorieGoal,
      required this.onboardingCompleted})
      : super._();

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;
  @override
  final double heightValue;
  @override
  final HeightUnit heightUnit;
  @override
  final double weightValue;
  @override
  final WeightUnit weightUnit;
  @override
  final ActivityLevel activityLevel;
  @override
  final int? dailyCalorieGoal;
  @override
  final bool onboardingCompleted;

  @override
  String toString() {
    return 'UserProfile(id: $id, name: $name, heightValue: $heightValue, heightUnit: $heightUnit, weightValue: $weightValue, weightUnit: $weightUnit, activityLevel: $activityLevel, dailyCalorieGoal: $dailyCalorieGoal, onboardingCompleted: $onboardingCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.heightValue, heightValue) ||
                other.heightValue == heightValue) &&
            (identical(other.heightUnit, heightUnit) ||
                other.heightUnit == heightUnit) &&
            (identical(other.weightValue, weightValue) ||
                other.weightValue == weightValue) &&
            (identical(other.weightUnit, weightUnit) ||
                other.weightUnit == weightUnit) &&
            (identical(other.activityLevel, activityLevel) ||
                other.activityLevel == activityLevel) &&
            (identical(other.dailyCalorieGoal, dailyCalorieGoal) ||
                other.dailyCalorieGoal == dailyCalorieGoal) &&
            (identical(other.onboardingCompleted, onboardingCompleted) ||
                other.onboardingCompleted == onboardingCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      heightValue,
      heightUnit,
      weightValue,
      weightUnit,
      activityLevel,
      dailyCalorieGoal,
      onboardingCompleted);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(
      this,
    );
  }
}

abstract class _UserProfile extends UserProfile {
  const factory _UserProfile(
      {required final String id,
      final String? name,
      required final double heightValue,
      required final HeightUnit heightUnit,
      required final double weightValue,
      required final WeightUnit weightUnit,
      required final ActivityLevel activityLevel,
      final int? dailyCalorieGoal,
      required final bool onboardingCompleted}) = _$UserProfileImpl;
  const _UserProfile._() : super._();

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;
  @override
  double get heightValue;
  @override
  HeightUnit get heightUnit;
  @override
  double get weightValue;
  @override
  WeightUnit get weightUnit;
  @override
  ActivityLevel get activityLevel;
  @override
  int? get dailyCalorieGoal;
  @override
  bool get onboardingCompleted;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
