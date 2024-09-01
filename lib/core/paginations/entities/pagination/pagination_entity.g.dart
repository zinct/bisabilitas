// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginationEntityImpl _$$PaginationEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$PaginationEntityImpl(
      perPage: (json['per_page'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PaginationEntityImplToJson(
        _$PaginationEntityImpl instance) =>
    <String, dynamic>{
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
    };
