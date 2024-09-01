// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaginationResult<T> _$PaginationResultFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _PaginationResult<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$PaginationResult<T> {
  List<T>? get list => throw _privateConstructorUsedError;
  PaginationEntity? get pagination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaginationResultCopyWith<T, PaginationResult<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationResultCopyWith<T, $Res> {
  factory $PaginationResultCopyWith(
          PaginationResult<T> value, $Res Function(PaginationResult<T>) then) =
      _$PaginationResultCopyWithImpl<T, $Res, PaginationResult<T>>;
  @useResult
  $Res call({List<T>? list, PaginationEntity? pagination});

  $PaginationEntityCopyWith<$Res>? get pagination;
}

/// @nodoc
class _$PaginationResultCopyWithImpl<T, $Res, $Val extends PaginationResult<T>>
    implements $PaginationResultCopyWith<T, $Res> {
  _$PaginationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_value.copyWith(
      list: freezed == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<T>?,
      pagination: freezed == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as PaginationEntity?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PaginationEntityCopyWith<$Res>? get pagination {
    if (_value.pagination == null) {
      return null;
    }

    return $PaginationEntityCopyWith<$Res>(_value.pagination!, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PaginationResultImplCopyWith<T, $Res>
    implements $PaginationResultCopyWith<T, $Res> {
  factory _$$PaginationResultImplCopyWith(_$PaginationResultImpl<T> value,
          $Res Function(_$PaginationResultImpl<T>) then) =
      __$$PaginationResultImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({List<T>? list, PaginationEntity? pagination});

  @override
  $PaginationEntityCopyWith<$Res>? get pagination;
}

/// @nodoc
class __$$PaginationResultImplCopyWithImpl<T, $Res>
    extends _$PaginationResultCopyWithImpl<T, $Res, _$PaginationResultImpl<T>>
    implements _$$PaginationResultImplCopyWith<T, $Res> {
  __$$PaginationResultImplCopyWithImpl(_$PaginationResultImpl<T> _value,
      $Res Function(_$PaginationResultImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_$PaginationResultImpl<T>(
      list: freezed == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<T>?,
      pagination: freezed == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as PaginationEntity?,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$PaginationResultImpl<T> implements _PaginationResult<T> {
  const _$PaginationResultImpl({final List<T>? list, this.pagination})
      : _list = list;

  factory _$PaginationResultImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$PaginationResultImplFromJson(json, fromJsonT);

  final List<T>? _list;
  @override
  List<T>? get list {
    final value = _list;
    if (value == null) return null;
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final PaginationEntity? pagination;

  @override
  String toString() {
    return 'PaginationResult<$T>(list: $list, pagination: $pagination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationResultImpl<T> &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_list), pagination);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationResultImplCopyWith<T, _$PaginationResultImpl<T>> get copyWith =>
      __$$PaginationResultImplCopyWithImpl<T, _$PaginationResultImpl<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$PaginationResultImplToJson<T>(this, toJsonT);
  }
}

abstract class _PaginationResult<T> implements PaginationResult<T> {
  const factory _PaginationResult(
      {final List<T>? list,
      final PaginationEntity? pagination}) = _$PaginationResultImpl<T>;

  factory _PaginationResult.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$PaginationResultImpl<T>.fromJson;

  @override
  List<T>? get list;
  @override
  PaginationEntity? get pagination;
  @override
  @JsonKey(ignore: true)
  _$$PaginationResultImplCopyWith<T, _$PaginationResultImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
