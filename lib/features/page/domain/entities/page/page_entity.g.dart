// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PageEntityImpl _$$PageEntityImplFromJson(Map<String, dynamic> json) =>
    _$PageEntityImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      isFavorite: (json['is_favorite'] as num?)?.toInt(),
      isRead: (json['is_read'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$PageEntityImplToJson(_$PageEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'description': instance.description,
      'url': instance.url,
      'is_favorite': instance.isFavorite,
      'is_read': instance.isRead,
      'user_id': instance.userId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt,
    };
