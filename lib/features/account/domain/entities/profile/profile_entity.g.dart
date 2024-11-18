// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileEntityImpl _$$ProfileEntityImplFromJson(Map<String, dynamic> json) =>
    _$ProfileEntityImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$ProfileEntityImplToJson(_$ProfileEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'image': instance.image,
      'created_at': instance.createdAt,
    };
