// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginationResultImpl<T> _$$PaginationResultImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$PaginationResultImpl<T>(
      list: (json['list'] as List<dynamic>?)?.map(fromJsonT).toList(),
      pagination: json['pagination'] == null
          ? null
          : PaginationEntity.fromJson(
              json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PaginationResultImplToJson<T>(
  _$PaginationResultImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'list': instance.list?.map(toJsonT).toList(),
      'pagination': instance.pagination,
    };
