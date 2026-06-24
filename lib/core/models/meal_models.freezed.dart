// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IngredientPortion _$IngredientPortionFromJson(Map<String, dynamic> json) {
  return _IngredientPortion.fromJson(json);
}

/// @nodoc
mixin _$IngredientPortion {
  String get name => throw _privateConstructorUsedError;
  String? get portionSize => throw _privateConstructorUsedError;

  /// Serializes this IngredientPortion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IngredientPortion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IngredientPortionCopyWith<IngredientPortion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IngredientPortionCopyWith<$Res> {
  factory $IngredientPortionCopyWith(
          IngredientPortion value, $Res Function(IngredientPortion) then) =
      _$IngredientPortionCopyWithImpl<$Res, IngredientPortion>;
  @useResult
  $Res call({String name, String? portionSize});
}

/// @nodoc
class _$IngredientPortionCopyWithImpl<$Res, $Val extends IngredientPortion>
    implements $IngredientPortionCopyWith<$Res> {
  _$IngredientPortionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IngredientPortion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? portionSize = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      portionSize: freezed == portionSize
          ? _value.portionSize
          : portionSize // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IngredientPortionImplCopyWith<$Res>
    implements $IngredientPortionCopyWith<$Res> {
  factory _$$IngredientPortionImplCopyWith(_$IngredientPortionImpl value,
          $Res Function(_$IngredientPortionImpl) then) =
      __$$IngredientPortionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? portionSize});
}

/// @nodoc
class __$$IngredientPortionImplCopyWithImpl<$Res>
    extends _$IngredientPortionCopyWithImpl<$Res, _$IngredientPortionImpl>
    implements _$$IngredientPortionImplCopyWith<$Res> {
  __$$IngredientPortionImplCopyWithImpl(_$IngredientPortionImpl _value,
      $Res Function(_$IngredientPortionImpl) _then)
      : super(_value, _then);

  /// Create a copy of IngredientPortion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? portionSize = freezed,
  }) {
    return _then(_$IngredientPortionImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      portionSize: freezed == portionSize
          ? _value.portionSize
          : portionSize // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IngredientPortionImpl implements _IngredientPortion {
  const _$IngredientPortionImpl({required this.name, this.portionSize});

  factory _$IngredientPortionImpl.fromJson(Map<String, dynamic> json) =>
      _$$IngredientPortionImplFromJson(json);

  @override
  final String name;
  @override
  final String? portionSize;

  @override
  String toString() {
    return 'IngredientPortion(name: $name, portionSize: $portionSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IngredientPortionImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.portionSize, portionSize) ||
                other.portionSize == portionSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, portionSize);

  /// Create a copy of IngredientPortion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IngredientPortionImplCopyWith<_$IngredientPortionImpl> get copyWith =>
      __$$IngredientPortionImplCopyWithImpl<_$IngredientPortionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IngredientPortionImplToJson(
      this,
    );
  }
}

abstract class _IngredientPortion implements IngredientPortion {
  const factory _IngredientPortion(
      {required final String name,
      final String? portionSize}) = _$IngredientPortionImpl;

  factory _IngredientPortion.fromJson(Map<String, dynamic> json) =
      _$IngredientPortionImpl.fromJson;

  @override
  String get name;
  @override
  String? get portionSize;

  /// Create a copy of IngredientPortion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IngredientPortionImplCopyWith<_$IngredientPortionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CaptureInfo _$CaptureInfoFromJson(Map<String, dynamic> json) {
  return _CaptureInfo.fromJson(json);
}

/// @nodoc
mixin _$CaptureInfo {
  String get localPath => throw _privateConstructorUsedError;
  String get previewBase64 => throw _privateConstructorUsedError;
  bool get fromGallery => throw _privateConstructorUsedError;
  double? get captureFocalLength => throw _privateConstructorUsedError;

  /// Serializes this CaptureInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CaptureInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CaptureInfoCopyWith<CaptureInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CaptureInfoCopyWith<$Res> {
  factory $CaptureInfoCopyWith(
          CaptureInfo value, $Res Function(CaptureInfo) then) =
      _$CaptureInfoCopyWithImpl<$Res, CaptureInfo>;
  @useResult
  $Res call(
      {String localPath,
      String previewBase64,
      bool fromGallery,
      double? captureFocalLength});
}

/// @nodoc
class _$CaptureInfoCopyWithImpl<$Res, $Val extends CaptureInfo>
    implements $CaptureInfoCopyWith<$Res> {
  _$CaptureInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CaptureInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localPath = null,
    Object? previewBase64 = null,
    Object? fromGallery = null,
    Object? captureFocalLength = freezed,
  }) {
    return _then(_value.copyWith(
      localPath: null == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String,
      previewBase64: null == previewBase64
          ? _value.previewBase64
          : previewBase64 // ignore: cast_nullable_to_non_nullable
              as String,
      fromGallery: null == fromGallery
          ? _value.fromGallery
          : fromGallery // ignore: cast_nullable_to_non_nullable
              as bool,
      captureFocalLength: freezed == captureFocalLength
          ? _value.captureFocalLength
          : captureFocalLength // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CaptureInfoImplCopyWith<$Res>
    implements $CaptureInfoCopyWith<$Res> {
  factory _$$CaptureInfoImplCopyWith(
          _$CaptureInfoImpl value, $Res Function(_$CaptureInfoImpl) then) =
      __$$CaptureInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String localPath,
      String previewBase64,
      bool fromGallery,
      double? captureFocalLength});
}

/// @nodoc
class __$$CaptureInfoImplCopyWithImpl<$Res>
    extends _$CaptureInfoCopyWithImpl<$Res, _$CaptureInfoImpl>
    implements _$$CaptureInfoImplCopyWith<$Res> {
  __$$CaptureInfoImplCopyWithImpl(
      _$CaptureInfoImpl _value, $Res Function(_$CaptureInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of CaptureInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localPath = null,
    Object? previewBase64 = null,
    Object? fromGallery = null,
    Object? captureFocalLength = freezed,
  }) {
    return _then(_$CaptureInfoImpl(
      localPath: null == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String,
      previewBase64: null == previewBase64
          ? _value.previewBase64
          : previewBase64 // ignore: cast_nullable_to_non_nullable
              as String,
      fromGallery: null == fromGallery
          ? _value.fromGallery
          : fromGallery // ignore: cast_nullable_to_non_nullable
              as bool,
      captureFocalLength: freezed == captureFocalLength
          ? _value.captureFocalLength
          : captureFocalLength // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CaptureInfoImpl implements _CaptureInfo {
  const _$CaptureInfoImpl(
      {required this.localPath,
      required this.previewBase64,
      required this.fromGallery,
      this.captureFocalLength});

  factory _$CaptureInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CaptureInfoImplFromJson(json);

  @override
  final String localPath;
  @override
  final String previewBase64;
  @override
  final bool fromGallery;
  @override
  final double? captureFocalLength;

  @override
  String toString() {
    return 'CaptureInfo(localPath: $localPath, previewBase64: $previewBase64, fromGallery: $fromGallery, captureFocalLength: $captureFocalLength)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CaptureInfoImpl &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.previewBase64, previewBase64) ||
                other.previewBase64 == previewBase64) &&
            (identical(other.fromGallery, fromGallery) ||
                other.fromGallery == fromGallery) &&
            (identical(other.captureFocalLength, captureFocalLength) ||
                other.captureFocalLength == captureFocalLength));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, localPath, previewBase64, fromGallery, captureFocalLength);

  /// Create a copy of CaptureInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CaptureInfoImplCopyWith<_$CaptureInfoImpl> get copyWith =>
      __$$CaptureInfoImplCopyWithImpl<_$CaptureInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CaptureInfoImplToJson(
      this,
    );
  }
}

abstract class _CaptureInfo implements CaptureInfo {
  const factory _CaptureInfo(
      {required final String localPath,
      required final String previewBase64,
      required final bool fromGallery,
      final double? captureFocalLength}) = _$CaptureInfoImpl;

  factory _CaptureInfo.fromJson(Map<String, dynamic> json) =
      _$CaptureInfoImpl.fromJson;

  @override
  String get localPath;
  @override
  String get previewBase64;
  @override
  bool get fromGallery;
  @override
  double? get captureFocalLength;

  /// Create a copy of CaptureInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CaptureInfoImplCopyWith<_$CaptureInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealPreferences _$MealPreferencesFromJson(Map<String, dynamic> json) {
  return _MealPreferences.fromJson(json);
}

/// @nodoc
mixin _$MealPreferences {
  List<String> get dietaryTags => throw _privateConstructorUsedError;
  bool get includeAllergens => throw _privateConstructorUsedError;
  bool get preferMetric => throw _privateConstructorUsedError;

  /// Serializes this MealPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealPreferencesCopyWith<MealPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealPreferencesCopyWith<$Res> {
  factory $MealPreferencesCopyWith(
          MealPreferences value, $Res Function(MealPreferences) then) =
      _$MealPreferencesCopyWithImpl<$Res, MealPreferences>;
  @useResult
  $Res call(
      {List<String> dietaryTags, bool includeAllergens, bool preferMetric});
}

/// @nodoc
class _$MealPreferencesCopyWithImpl<$Res, $Val extends MealPreferences>
    implements $MealPreferencesCopyWith<$Res> {
  _$MealPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dietaryTags = null,
    Object? includeAllergens = null,
    Object? preferMetric = null,
  }) {
    return _then(_value.copyWith(
      dietaryTags: null == dietaryTags
          ? _value.dietaryTags
          : dietaryTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      includeAllergens: null == includeAllergens
          ? _value.includeAllergens
          : includeAllergens // ignore: cast_nullable_to_non_nullable
              as bool,
      preferMetric: null == preferMetric
          ? _value.preferMetric
          : preferMetric // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealPreferencesImplCopyWith<$Res>
    implements $MealPreferencesCopyWith<$Res> {
  factory _$$MealPreferencesImplCopyWith(_$MealPreferencesImpl value,
          $Res Function(_$MealPreferencesImpl) then) =
      __$$MealPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> dietaryTags, bool includeAllergens, bool preferMetric});
}

/// @nodoc
class __$$MealPreferencesImplCopyWithImpl<$Res>
    extends _$MealPreferencesCopyWithImpl<$Res, _$MealPreferencesImpl>
    implements _$$MealPreferencesImplCopyWith<$Res> {
  __$$MealPreferencesImplCopyWithImpl(
      _$MealPreferencesImpl _value, $Res Function(_$MealPreferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dietaryTags = null,
    Object? includeAllergens = null,
    Object? preferMetric = null,
  }) {
    return _then(_$MealPreferencesImpl(
      dietaryTags: null == dietaryTags
          ? _value._dietaryTags
          : dietaryTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      includeAllergens: null == includeAllergens
          ? _value.includeAllergens
          : includeAllergens // ignore: cast_nullable_to_non_nullable
              as bool,
      preferMetric: null == preferMetric
          ? _value.preferMetric
          : preferMetric // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealPreferencesImpl implements _MealPreferences {
  const _$MealPreferencesImpl(
      {required final List<String> dietaryTags,
      required this.includeAllergens,
      required this.preferMetric})
      : _dietaryTags = dietaryTags;

  factory _$MealPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealPreferencesImplFromJson(json);

  final List<String> _dietaryTags;
  @override
  List<String> get dietaryTags {
    if (_dietaryTags is EqualUnmodifiableListView) return _dietaryTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dietaryTags);
  }

  @override
  final bool includeAllergens;
  @override
  final bool preferMetric;

  @override
  String toString() {
    return 'MealPreferences(dietaryTags: $dietaryTags, includeAllergens: $includeAllergens, preferMetric: $preferMetric)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealPreferencesImpl &&
            const DeepCollectionEquality()
                .equals(other._dietaryTags, _dietaryTags) &&
            (identical(other.includeAllergens, includeAllergens) ||
                other.includeAllergens == includeAllergens) &&
            (identical(other.preferMetric, preferMetric) ||
                other.preferMetric == preferMetric));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_dietaryTags),
      includeAllergens,
      preferMetric);

  /// Create a copy of MealPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealPreferencesImplCopyWith<_$MealPreferencesImpl> get copyWith =>
      __$$MealPreferencesImplCopyWithImpl<_$MealPreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealPreferencesImplToJson(
      this,
    );
  }
}

abstract class _MealPreferences implements MealPreferences {
  const factory _MealPreferences(
      {required final List<String> dietaryTags,
      required final bool includeAllergens,
      required final bool preferMetric}) = _$MealPreferencesImpl;

  factory _MealPreferences.fromJson(Map<String, dynamic> json) =
      _$MealPreferencesImpl.fromJson;

  @override
  List<String> get dietaryTags;
  @override
  bool get includeAllergens;
  @override
  bool get preferMetric;

  /// Create a copy of MealPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealPreferencesImplCopyWith<_$MealPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Macros _$MacrosFromJson(Map<String, dynamic> json) {
  return _Macros.fromJson(json);
}

/// @nodoc
mixin _$Macros {
  double get carbs => throw _privateConstructorUsedError;
  double get protein => throw _privateConstructorUsedError;
  double get fat => throw _privateConstructorUsedError;

  /// Serializes this Macros to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Macros
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MacrosCopyWith<Macros> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MacrosCopyWith<$Res> {
  factory $MacrosCopyWith(Macros value, $Res Function(Macros) then) =
      _$MacrosCopyWithImpl<$Res, Macros>;
  @useResult
  $Res call({double carbs, double protein, double fat});
}

/// @nodoc
class _$MacrosCopyWithImpl<$Res, $Val extends Macros>
    implements $MacrosCopyWith<$Res> {
  _$MacrosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Macros
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? carbs = null,
    Object? protein = null,
    Object? fat = null,
  }) {
    return _then(_value.copyWith(
      carbs: null == carbs
          ? _value.carbs
          : carbs // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MacrosImplCopyWith<$Res> implements $MacrosCopyWith<$Res> {
  factory _$$MacrosImplCopyWith(
          _$MacrosImpl value, $Res Function(_$MacrosImpl) then) =
      __$$MacrosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double carbs, double protein, double fat});
}

/// @nodoc
class __$$MacrosImplCopyWithImpl<$Res>
    extends _$MacrosCopyWithImpl<$Res, _$MacrosImpl>
    implements _$$MacrosImplCopyWith<$Res> {
  __$$MacrosImplCopyWithImpl(
      _$MacrosImpl _value, $Res Function(_$MacrosImpl) _then)
      : super(_value, _then);

  /// Create a copy of Macros
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? carbs = null,
    Object? protein = null,
    Object? fat = null,
  }) {
    return _then(_$MacrosImpl(
      carbs: null == carbs
          ? _value.carbs
          : carbs // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MacrosImpl extends _Macros {
  const _$MacrosImpl(
      {required this.carbs, required this.protein, required this.fat})
      : super._();

  factory _$MacrosImpl.fromJson(Map<String, dynamic> json) =>
      _$$MacrosImplFromJson(json);

  @override
  final double carbs;
  @override
  final double protein;
  @override
  final double fat;

  @override
  String toString() {
    return 'Macros(carbs: $carbs, protein: $protein, fat: $fat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MacrosImpl &&
            (identical(other.carbs, carbs) || other.carbs == carbs) &&
            (identical(other.protein, protein) || other.protein == protein) &&
            (identical(other.fat, fat) || other.fat == fat));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, carbs, protein, fat);

  /// Create a copy of Macros
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MacrosImplCopyWith<_$MacrosImpl> get copyWith =>
      __$$MacrosImplCopyWithImpl<_$MacrosImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MacrosImplToJson(
      this,
    );
  }
}

abstract class _Macros extends Macros {
  const factory _Macros(
      {required final double carbs,
      required final double protein,
      required final double fat}) = _$MacrosImpl;
  const _Macros._() : super._();

  factory _Macros.fromJson(Map<String, dynamic> json) = _$MacrosImpl.fromJson;

  @override
  double get carbs;
  @override
  double get protein;
  @override
  double get fat;

  /// Create a copy of Macros
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MacrosImplCopyWith<_$MacrosImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IdentifiedFood _$IdentifiedFoodFromJson(Map<String, dynamic> json) {
  return _IdentifiedFood.fromJson(json);
}

/// @nodoc
mixin _$IdentifiedFood {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get calories => throw _privateConstructorUsedError;
  Macros get macros => throw _privateConstructorUsedError;
  String? get portionSize => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  double? get confidence => throw _privateConstructorUsedError;
  List<String>? get highlights => throw _privateConstructorUsedError;

  /// Serializes this IdentifiedFood to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IdentifiedFood
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IdentifiedFoodCopyWith<IdentifiedFood> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IdentifiedFoodCopyWith<$Res> {
  factory $IdentifiedFoodCopyWith(
          IdentifiedFood value, $Res Function(IdentifiedFood) then) =
      _$IdentifiedFoodCopyWithImpl<$Res, IdentifiedFood>;
  @useResult
  $Res call(
      {String id,
      String name,
      int calories,
      Macros macros,
      String? portionSize,
      String? thumbnailUrl,
      double? confidence,
      List<String>? highlights});

  $MacrosCopyWith<$Res> get macros;
}

/// @nodoc
class _$IdentifiedFoodCopyWithImpl<$Res, $Val extends IdentifiedFood>
    implements $IdentifiedFoodCopyWith<$Res> {
  _$IdentifiedFoodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IdentifiedFood
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? calories = null,
    Object? macros = null,
    Object? portionSize = freezed,
    Object? thumbnailUrl = freezed,
    Object? confidence = freezed,
    Object? highlights = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      macros: null == macros
          ? _value.macros
          : macros // ignore: cast_nullable_to_non_nullable
              as Macros,
      portionSize: freezed == portionSize
          ? _value.portionSize
          : portionSize // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double?,
      highlights: freezed == highlights
          ? _value.highlights
          : highlights // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  /// Create a copy of IdentifiedFood
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MacrosCopyWith<$Res> get macros {
    return $MacrosCopyWith<$Res>(_value.macros, (value) {
      return _then(_value.copyWith(macros: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IdentifiedFoodImplCopyWith<$Res>
    implements $IdentifiedFoodCopyWith<$Res> {
  factory _$$IdentifiedFoodImplCopyWith(_$IdentifiedFoodImpl value,
          $Res Function(_$IdentifiedFoodImpl) then) =
      __$$IdentifiedFoodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int calories,
      Macros macros,
      String? portionSize,
      String? thumbnailUrl,
      double? confidence,
      List<String>? highlights});

  @override
  $MacrosCopyWith<$Res> get macros;
}

/// @nodoc
class __$$IdentifiedFoodImplCopyWithImpl<$Res>
    extends _$IdentifiedFoodCopyWithImpl<$Res, _$IdentifiedFoodImpl>
    implements _$$IdentifiedFoodImplCopyWith<$Res> {
  __$$IdentifiedFoodImplCopyWithImpl(
      _$IdentifiedFoodImpl _value, $Res Function(_$IdentifiedFoodImpl) _then)
      : super(_value, _then);

  /// Create a copy of IdentifiedFood
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? calories = null,
    Object? macros = null,
    Object? portionSize = freezed,
    Object? thumbnailUrl = freezed,
    Object? confidence = freezed,
    Object? highlights = freezed,
  }) {
    return _then(_$IdentifiedFoodImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      macros: null == macros
          ? _value.macros
          : macros // ignore: cast_nullable_to_non_nullable
              as Macros,
      portionSize: freezed == portionSize
          ? _value.portionSize
          : portionSize // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double?,
      highlights: freezed == highlights
          ? _value._highlights
          : highlights // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IdentifiedFoodImpl implements _IdentifiedFood {
  const _$IdentifiedFoodImpl(
      {required this.id,
      required this.name,
      required this.calories,
      required this.macros,
      this.portionSize,
      this.thumbnailUrl,
      this.confidence,
      final List<String>? highlights})
      : _highlights = highlights;

  factory _$IdentifiedFoodImpl.fromJson(Map<String, dynamic> json) =>
      _$$IdentifiedFoodImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int calories;
  @override
  final Macros macros;
  @override
  final String? portionSize;
  @override
  final String? thumbnailUrl;
  @override
  final double? confidence;
  final List<String>? _highlights;
  @override
  List<String>? get highlights {
    final value = _highlights;
    if (value == null) return null;
    if (_highlights is EqualUnmodifiableListView) return _highlights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'IdentifiedFood(id: $id, name: $name, calories: $calories, macros: $macros, portionSize: $portionSize, thumbnailUrl: $thumbnailUrl, confidence: $confidence, highlights: $highlights)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IdentifiedFoodImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.macros, macros) || other.macros == macros) &&
            (identical(other.portionSize, portionSize) ||
                other.portionSize == portionSize) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality()
                .equals(other._highlights, _highlights));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      calories,
      macros,
      portionSize,
      thumbnailUrl,
      confidence,
      const DeepCollectionEquality().hash(_highlights));

  /// Create a copy of IdentifiedFood
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IdentifiedFoodImplCopyWith<_$IdentifiedFoodImpl> get copyWith =>
      __$$IdentifiedFoodImplCopyWithImpl<_$IdentifiedFoodImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IdentifiedFoodImplToJson(
      this,
    );
  }
}

abstract class _IdentifiedFood implements IdentifiedFood {
  const factory _IdentifiedFood(
      {required final String id,
      required final String name,
      required final int calories,
      required final Macros macros,
      final String? portionSize,
      final String? thumbnailUrl,
      final double? confidence,
      final List<String>? highlights}) = _$IdentifiedFoodImpl;

  factory _IdentifiedFood.fromJson(Map<String, dynamic> json) =
      _$IdentifiedFoodImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get calories;
  @override
  Macros get macros;
  @override
  String? get portionSize;
  @override
  String? get thumbnailUrl;
  @override
  double? get confidence;
  @override
  List<String>? get highlights;

  /// Create a copy of IdentifiedFood
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IdentifiedFoodImplCopyWith<_$IdentifiedFoodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealAnalysis _$MealAnalysisFromJson(Map<String, dynamic> json) {
  return _MealAnalysis.fromJson(json);
}

/// @nodoc
mixin _$MealAnalysis {
  String get id => throw _privateConstructorUsedError;
  String get localId => throw _privateConstructorUsedError;
  String get mealTitle => throw _privateConstructorUsedError;
  int get totalCalories => throw _privateConstructorUsedError;
  Confidence get confidence => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  List<IdentifiedFood> get identifiedFoods =>
      throw _privateConstructorUsedError;
  Macros get macros => throw _privateConstructorUsedError;
  String get qualitativeFeedback => throw _privateConstructorUsedError;
  List<String> get warnings => throw _privateConstructorUsedError;
  String? get mealTag => throw _privateConstructorUsedError;
  List<IngredientPortion> get ingredients => throw _privateConstructorUsedError;
  double get totalFiber => throw _privateConstructorUsedError;

  /// Serializes this MealAnalysis to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealAnalysisCopyWith<MealAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealAnalysisCopyWith<$Res> {
  factory $MealAnalysisCopyWith(
          MealAnalysis value, $Res Function(MealAnalysis) then) =
      _$MealAnalysisCopyWithImpl<$Res, MealAnalysis>;
  @useResult
  $Res call(
      {String id,
      String localId,
      String mealTitle,
      int totalCalories,
      Confidence confidence,
      DateTime timestamp,
      List<IdentifiedFood> identifiedFoods,
      Macros macros,
      String qualitativeFeedback,
      List<String> warnings,
      String? mealTag,
      List<IngredientPortion> ingredients,
      double totalFiber});

  $MacrosCopyWith<$Res> get macros;
}

/// @nodoc
class _$MealAnalysisCopyWithImpl<$Res, $Val extends MealAnalysis>
    implements $MealAnalysisCopyWith<$Res> {
  _$MealAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? localId = null,
    Object? mealTitle = null,
    Object? totalCalories = null,
    Object? confidence = null,
    Object? timestamp = null,
    Object? identifiedFoods = null,
    Object? macros = null,
    Object? qualitativeFeedback = null,
    Object? warnings = null,
    Object? mealTag = freezed,
    Object? ingredients = null,
    Object? totalFiber = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      localId: null == localId
          ? _value.localId
          : localId // ignore: cast_nullable_to_non_nullable
              as String,
      mealTitle: null == mealTitle
          ? _value.mealTitle
          : mealTitle // ignore: cast_nullable_to_non_nullable
              as String,
      totalCalories: null == totalCalories
          ? _value.totalCalories
          : totalCalories // ignore: cast_nullable_to_non_nullable
              as int,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as Confidence,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      identifiedFoods: null == identifiedFoods
          ? _value.identifiedFoods
          : identifiedFoods // ignore: cast_nullable_to_non_nullable
              as List<IdentifiedFood>,
      macros: null == macros
          ? _value.macros
          : macros // ignore: cast_nullable_to_non_nullable
              as Macros,
      qualitativeFeedback: null == qualitativeFeedback
          ? _value.qualitativeFeedback
          : qualitativeFeedback // ignore: cast_nullable_to_non_nullable
              as String,
      warnings: null == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mealTag: freezed == mealTag
          ? _value.mealTag
          : mealTag // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<IngredientPortion>,
      totalFiber: null == totalFiber
          ? _value.totalFiber
          : totalFiber // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  /// Create a copy of MealAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MacrosCopyWith<$Res> get macros {
    return $MacrosCopyWith<$Res>(_value.macros, (value) {
      return _then(_value.copyWith(macros: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MealAnalysisImplCopyWith<$Res>
    implements $MealAnalysisCopyWith<$Res> {
  factory _$$MealAnalysisImplCopyWith(
          _$MealAnalysisImpl value, $Res Function(_$MealAnalysisImpl) then) =
      __$$MealAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String localId,
      String mealTitle,
      int totalCalories,
      Confidence confidence,
      DateTime timestamp,
      List<IdentifiedFood> identifiedFoods,
      Macros macros,
      String qualitativeFeedback,
      List<String> warnings,
      String? mealTag,
      List<IngredientPortion> ingredients,
      double totalFiber});

  @override
  $MacrosCopyWith<$Res> get macros;
}

/// @nodoc
class __$$MealAnalysisImplCopyWithImpl<$Res>
    extends _$MealAnalysisCopyWithImpl<$Res, _$MealAnalysisImpl>
    implements _$$MealAnalysisImplCopyWith<$Res> {
  __$$MealAnalysisImplCopyWithImpl(
      _$MealAnalysisImpl _value, $Res Function(_$MealAnalysisImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? localId = null,
    Object? mealTitle = null,
    Object? totalCalories = null,
    Object? confidence = null,
    Object? timestamp = null,
    Object? identifiedFoods = null,
    Object? macros = null,
    Object? qualitativeFeedback = null,
    Object? warnings = null,
    Object? mealTag = freezed,
    Object? ingredients = null,
    Object? totalFiber = null,
  }) {
    return _then(_$MealAnalysisImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      localId: null == localId
          ? _value.localId
          : localId // ignore: cast_nullable_to_non_nullable
              as String,
      mealTitle: null == mealTitle
          ? _value.mealTitle
          : mealTitle // ignore: cast_nullable_to_non_nullable
              as String,
      totalCalories: null == totalCalories
          ? _value.totalCalories
          : totalCalories // ignore: cast_nullable_to_non_nullable
              as int,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as Confidence,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      identifiedFoods: null == identifiedFoods
          ? _value._identifiedFoods
          : identifiedFoods // ignore: cast_nullable_to_non_nullable
              as List<IdentifiedFood>,
      macros: null == macros
          ? _value.macros
          : macros // ignore: cast_nullable_to_non_nullable
              as Macros,
      qualitativeFeedback: null == qualitativeFeedback
          ? _value.qualitativeFeedback
          : qualitativeFeedback // ignore: cast_nullable_to_non_nullable
              as String,
      warnings: null == warnings
          ? _value._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mealTag: freezed == mealTag
          ? _value.mealTag
          : mealTag // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<IngredientPortion>,
      totalFiber: null == totalFiber
          ? _value.totalFiber
          : totalFiber // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealAnalysisImpl implements _MealAnalysis {
  const _$MealAnalysisImpl(
      {required this.id,
      required this.localId,
      required this.mealTitle,
      required this.totalCalories,
      required this.confidence,
      required this.timestamp,
      required final List<IdentifiedFood> identifiedFoods,
      required this.macros,
      required this.qualitativeFeedback,
      required final List<String> warnings,
      this.mealTag,
      final List<IngredientPortion> ingredients = const [],
      this.totalFiber = 0})
      : _identifiedFoods = identifiedFoods,
        _warnings = warnings,
        _ingredients = ingredients;

  factory _$MealAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealAnalysisImplFromJson(json);

  @override
  final String id;
  @override
  final String localId;
  @override
  final String mealTitle;
  @override
  final int totalCalories;
  @override
  final Confidence confidence;
  @override
  final DateTime timestamp;
  final List<IdentifiedFood> _identifiedFoods;
  @override
  List<IdentifiedFood> get identifiedFoods {
    if (_identifiedFoods is EqualUnmodifiableListView) return _identifiedFoods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_identifiedFoods);
  }

  @override
  final Macros macros;
  @override
  final String qualitativeFeedback;
  final List<String> _warnings;
  @override
  List<String> get warnings {
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warnings);
  }

  @override
  final String? mealTag;
  final List<IngredientPortion> _ingredients;
  @override
  @JsonKey()
  List<IngredientPortion> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  @override
  @JsonKey()
  final double totalFiber;

  @override
  String toString() {
    return 'MealAnalysis(id: $id, localId: $localId, mealTitle: $mealTitle, totalCalories: $totalCalories, confidence: $confidence, timestamp: $timestamp, identifiedFoods: $identifiedFoods, macros: $macros, qualitativeFeedback: $qualitativeFeedback, warnings: $warnings, mealTag: $mealTag, ingredients: $ingredients, totalFiber: $totalFiber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealAnalysisImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.localId, localId) || other.localId == localId) &&
            (identical(other.mealTitle, mealTitle) ||
                other.mealTitle == mealTitle) &&
            (identical(other.totalCalories, totalCalories) ||
                other.totalCalories == totalCalories) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality()
                .equals(other._identifiedFoods, _identifiedFoods) &&
            (identical(other.macros, macros) || other.macros == macros) &&
            (identical(other.qualitativeFeedback, qualitativeFeedback) ||
                other.qualitativeFeedback == qualitativeFeedback) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings) &&
            (identical(other.mealTag, mealTag) || other.mealTag == mealTag) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            (identical(other.totalFiber, totalFiber) ||
                other.totalFiber == totalFiber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      localId,
      mealTitle,
      totalCalories,
      confidence,
      timestamp,
      const DeepCollectionEquality().hash(_identifiedFoods),
      macros,
      qualitativeFeedback,
      const DeepCollectionEquality().hash(_warnings),
      mealTag,
      const DeepCollectionEquality().hash(_ingredients),
      totalFiber);

  /// Create a copy of MealAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealAnalysisImplCopyWith<_$MealAnalysisImpl> get copyWith =>
      __$$MealAnalysisImplCopyWithImpl<_$MealAnalysisImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealAnalysisImplToJson(
      this,
    );
  }
}

abstract class _MealAnalysis implements MealAnalysis {
  const factory _MealAnalysis(
      {required final String id,
      required final String localId,
      required final String mealTitle,
      required final int totalCalories,
      required final Confidence confidence,
      required final DateTime timestamp,
      required final List<IdentifiedFood> identifiedFoods,
      required final Macros macros,
      required final String qualitativeFeedback,
      required final List<String> warnings,
      final String? mealTag,
      final List<IngredientPortion> ingredients,
      final double totalFiber}) = _$MealAnalysisImpl;

  factory _MealAnalysis.fromJson(Map<String, dynamic> json) =
      _$MealAnalysisImpl.fromJson;

  @override
  String get id;
  @override
  String get localId;
  @override
  String get mealTitle;
  @override
  int get totalCalories;
  @override
  Confidence get confidence;
  @override
  DateTime get timestamp;
  @override
  List<IdentifiedFood> get identifiedFoods;
  @override
  Macros get macros;
  @override
  String get qualitativeFeedback;
  @override
  List<String> get warnings;
  @override
  String? get mealTag;
  @override
  List<IngredientPortion> get ingredients;
  @override
  double get totalFiber;

  /// Create a copy of MealAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealAnalysisImplCopyWith<_$MealAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealPayload _$MealPayloadFromJson(Map<String, dynamic> json) {
  return _MealPayload.fromJson(json);
}

/// @nodoc
mixin _$MealPayload {
  String get localId => throw _privateConstructorUsedError;
  UserProfile get user => throw _privateConstructorUsedError;
  CaptureInfo get capture => throw _privateConstructorUsedError;
  MealPreferences get preferences => throw _privateConstructorUsedError;

  /// Serializes this MealPayload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealPayloadCopyWith<MealPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealPayloadCopyWith<$Res> {
  factory $MealPayloadCopyWith(
          MealPayload value, $Res Function(MealPayload) then) =
      _$MealPayloadCopyWithImpl<$Res, MealPayload>;
  @useResult
  $Res call(
      {String localId,
      UserProfile user,
      CaptureInfo capture,
      MealPreferences preferences});

  $UserProfileCopyWith<$Res> get user;
  $CaptureInfoCopyWith<$Res> get capture;
  $MealPreferencesCopyWith<$Res> get preferences;
}

/// @nodoc
class _$MealPayloadCopyWithImpl<$Res, $Val extends MealPayload>
    implements $MealPayloadCopyWith<$Res> {
  _$MealPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? user = null,
    Object? capture = null,
    Object? preferences = null,
  }) {
    return _then(_value.copyWith(
      localId: null == localId
          ? _value.localId
          : localId // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserProfile,
      capture: null == capture
          ? _value.capture
          : capture // ignore: cast_nullable_to_non_nullable
              as CaptureInfo,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as MealPreferences,
    ) as $Val);
  }

  /// Create a copy of MealPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res> get user {
    return $UserProfileCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of MealPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CaptureInfoCopyWith<$Res> get capture {
    return $CaptureInfoCopyWith<$Res>(_value.capture, (value) {
      return _then(_value.copyWith(capture: value) as $Val);
    });
  }

  /// Create a copy of MealPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MealPreferencesCopyWith<$Res> get preferences {
    return $MealPreferencesCopyWith<$Res>(_value.preferences, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MealPayloadImplCopyWith<$Res>
    implements $MealPayloadCopyWith<$Res> {
  factory _$$MealPayloadImplCopyWith(
          _$MealPayloadImpl value, $Res Function(_$MealPayloadImpl) then) =
      __$$MealPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String localId,
      UserProfile user,
      CaptureInfo capture,
      MealPreferences preferences});

  @override
  $UserProfileCopyWith<$Res> get user;
  @override
  $CaptureInfoCopyWith<$Res> get capture;
  @override
  $MealPreferencesCopyWith<$Res> get preferences;
}

/// @nodoc
class __$$MealPayloadImplCopyWithImpl<$Res>
    extends _$MealPayloadCopyWithImpl<$Res, _$MealPayloadImpl>
    implements _$$MealPayloadImplCopyWith<$Res> {
  __$$MealPayloadImplCopyWithImpl(
      _$MealPayloadImpl _value, $Res Function(_$MealPayloadImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? user = null,
    Object? capture = null,
    Object? preferences = null,
  }) {
    return _then(_$MealPayloadImpl(
      localId: null == localId
          ? _value.localId
          : localId // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserProfile,
      capture: null == capture
          ? _value.capture
          : capture // ignore: cast_nullable_to_non_nullable
              as CaptureInfo,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as MealPreferences,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealPayloadImpl implements _MealPayload {
  const _$MealPayloadImpl(
      {required this.localId,
      required this.user,
      required this.capture,
      required this.preferences});

  factory _$MealPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealPayloadImplFromJson(json);

  @override
  final String localId;
  @override
  final UserProfile user;
  @override
  final CaptureInfo capture;
  @override
  final MealPreferences preferences;

  @override
  String toString() {
    return 'MealPayload(localId: $localId, user: $user, capture: $capture, preferences: $preferences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealPayloadImpl &&
            (identical(other.localId, localId) || other.localId == localId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.capture, capture) || other.capture == capture) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, localId, user, capture, preferences);

  /// Create a copy of MealPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealPayloadImplCopyWith<_$MealPayloadImpl> get copyWith =>
      __$$MealPayloadImplCopyWithImpl<_$MealPayloadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealPayloadImplToJson(
      this,
    );
  }
}

abstract class _MealPayload implements MealPayload {
  const factory _MealPayload(
      {required final String localId,
      required final UserProfile user,
      required final CaptureInfo capture,
      required final MealPreferences preferences}) = _$MealPayloadImpl;

  factory _MealPayload.fromJson(Map<String, dynamic> json) =
      _$MealPayloadImpl.fromJson;

  @override
  String get localId;
  @override
  UserProfile get user;
  @override
  CaptureInfo get capture;
  @override
  MealPreferences get preferences;

  /// Create a copy of MealPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealPayloadImplCopyWith<_$MealPayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
