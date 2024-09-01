// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaginationEntity _$PaginationEntityFromJson(Map<String, dynamic> json) {
  return _PaginationEntity.fromJson(json);
}

/// @nodoc
mixin _$PaginationEntity {
  int? get perPage => throw _privateConstructorUsedError;
  int? get currentPage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaginationEntityCopyWith<PaginationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationEntityCopyWith<$Res> {
  factory $PaginationEntityCopyWith(
          PaginationEntity value, $Res Function(PaginationEntity) then) =
      _$PaginationEntityCopyWithImpl<$Res, PaginationEntity>;
  @useResult
  $Res call({int? perPage, int? currentPage});
}

/// @nodoc
class _$PaginationEntityCopyWithImpl<$Res, $Val extends PaginationEntity>
    implements $PaginationEntityCopyWith<$Res> {
  _$PaginationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? perPage = freezed,
    Object? currentPage = freezed,
  }) {
    return _then(_value.copyWith(
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginationEntityImplCopyWith<$Res>
    implements $PaginationEntityCopyWith<$Res> {
  factory _$$PaginationEntityImplCopyWith(_$PaginationEntityImpl value,
          $Res Function(_$PaginationEntityImpl) then) =
      __$$PaginationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? perPage, int? currentPage});
}

/// @nodoc
class __$$PaginationEntityImplCopyWithImpl<$Res>
    extends _$PaginationEntityCopyWithImpl<$Res, _$PaginationEntityImpl>
    implements _$$PaginationEntityImplCopyWith<$Res> {
  __$$PaginationEntityImplCopyWithImpl(_$PaginationEntityImpl _value,
      $Res Function(_$PaginationEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? perPage = freezed,
    Object? currentPage = freezed,
  }) {
    return _then(_$PaginationEntityImpl(
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$PaginationEntityImpl implements _PaginationEntity {
  const _$PaginationEntityImpl({this.perPage, this.currentPage});

  factory _$PaginationEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationEntityImplFromJson(json);

  @override
  final int? perPage;
  @override
  final int? currentPage;

  @override
  String toString() {
    return 'PaginationEntity(perPage: $perPage, currentPage: $currentPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationEntityImpl &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, perPage, currentPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationEntityImplCopyWith<_$PaginationEntityImpl> get copyWith =>
      __$$PaginationEntityImplCopyWithImpl<_$PaginationEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationEntityImplToJson(
      this,
    );
  }
}

abstract class _PaginationEntity implements PaginationEntity {
  const factory _PaginationEntity(
      {final int? perPage, final int? currentPage}) = _$PaginationEntityImpl;

  factory _PaginationEntity.fromJson(Map<String, dynamic> json) =
      _$PaginationEntityImpl.fromJson;

  @override
  int? get perPage;
  @override
  int? get currentPage;
  @override
  @JsonKey(ignore: true)
  _$$PaginationEntityImplCopyWith<_$PaginationEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
