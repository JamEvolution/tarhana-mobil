// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tarhana.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Tarhana _$TarhanaFromJson(Map<String, dynamic> json) {
  return _Tarhana.fromJson(json);
}

/// @nodoc
mixin _$Tarhana {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get ingredients => throw _privateConstructorUsedError;
  List<String> get steps => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get likes => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;

  /// Serializes this Tarhana to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tarhana
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TarhanaCopyWith<Tarhana> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TarhanaCopyWith<$Res> {
  factory $TarhanaCopyWith(Tarhana value, $Res Function(Tarhana) then) =
      _$TarhanaCopyWithImpl<$Res, Tarhana>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<String> ingredients,
      List<String> steps,
      String imageUrl,
      String authorId,
      DateTime createdAt,
      int likes,
      bool isFavorite});
}

/// @nodoc
class _$TarhanaCopyWithImpl<$Res, $Val extends Tarhana>
    implements $TarhanaCopyWith<$Res> {
  _$TarhanaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tarhana
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? ingredients = null,
    Object? steps = null,
    Object? imageUrl = null,
    Object? authorId = null,
    Object? createdAt = null,
    Object? likes = null,
    Object? isFavorite = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TarhanaImplCopyWith<$Res> implements $TarhanaCopyWith<$Res> {
  factory _$$TarhanaImplCopyWith(
          _$TarhanaImpl value, $Res Function(_$TarhanaImpl) then) =
      __$$TarhanaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<String> ingredients,
      List<String> steps,
      String imageUrl,
      String authorId,
      DateTime createdAt,
      int likes,
      bool isFavorite});
}

/// @nodoc
class __$$TarhanaImplCopyWithImpl<$Res>
    extends _$TarhanaCopyWithImpl<$Res, _$TarhanaImpl>
    implements _$$TarhanaImplCopyWith<$Res> {
  __$$TarhanaImplCopyWithImpl(
      _$TarhanaImpl _value, $Res Function(_$TarhanaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tarhana
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? ingredients = null,
    Object? steps = null,
    Object? imageUrl = null,
    Object? authorId = null,
    Object? createdAt = null,
    Object? likes = null,
    Object? isFavorite = null,
  }) {
    return _then(_$TarhanaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      steps: null == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TarhanaImpl implements _Tarhana {
  const _$TarhanaImpl(
      {required this.id,
      required this.name,
      required this.description,
      required final List<String> ingredients,
      required final List<String> steps,
      required this.imageUrl,
      required this.authorId,
      required this.createdAt,
      this.likes = 0,
      this.isFavorite = false})
      : _ingredients = ingredients,
        _steps = steps;

  factory _$TarhanaImpl.fromJson(Map<String, dynamic> json) =>
      _$$TarhanaImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  final List<String> _ingredients;
  @override
  List<String> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  final List<String> _steps;
  @override
  List<String> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  final String imageUrl;
  @override
  final String authorId;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final int likes;
  @override
  @JsonKey()
  final bool isFavorite;

  @override
  String toString() {
    return 'Tarhana(id: $id, name: $name, description: $description, ingredients: $ingredients, steps: $steps, imageUrl: $imageUrl, authorId: $authorId, createdAt: $createdAt, likes: $likes, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TarhanaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      const DeepCollectionEquality().hash(_ingredients),
      const DeepCollectionEquality().hash(_steps),
      imageUrl,
      authorId,
      createdAt,
      likes,
      isFavorite);

  /// Create a copy of Tarhana
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TarhanaImplCopyWith<_$TarhanaImpl> get copyWith =>
      __$$TarhanaImplCopyWithImpl<_$TarhanaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TarhanaImplToJson(
      this,
    );
  }
}

abstract class _Tarhana implements Tarhana {
  const factory _Tarhana(
      {required final String id,
      required final String name,
      required final String description,
      required final List<String> ingredients,
      required final List<String> steps,
      required final String imageUrl,
      required final String authorId,
      required final DateTime createdAt,
      final int likes,
      final bool isFavorite}) = _$TarhanaImpl;

  factory _Tarhana.fromJson(Map<String, dynamic> json) = _$TarhanaImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  List<String> get ingredients;
  @override
  List<String> get steps;
  @override
  String get imageUrl;
  @override
  String get authorId;
  @override
  DateTime get createdAt;
  @override
  int get likes;
  @override
  bool get isFavorite;

  /// Create a copy of Tarhana
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TarhanaImplCopyWith<_$TarhanaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
