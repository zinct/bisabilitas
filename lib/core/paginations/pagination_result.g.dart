// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaginationResult<T> _$$_PaginationResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$_PaginationResult<T>(
      list: (json['list'] as List<dynamic>?)?.map(fromJsonT).toList(),
      pagination: json['pagination'] == null
          ? null
          : PaginationEntity.fromJson(
              json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PaginationResultToJson<T>(
  _$_PaginationResult<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'list': instance.list?.map(toJsonT).toList(),
      'pagination': instance.pagination,
    };
