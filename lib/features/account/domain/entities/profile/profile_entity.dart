///
/// profile_entity.dart
/// lib/features/account/domain/entities
///
/// Created by Indra Mahesa https://github.com/zinct
///

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_entity.g.dart';
part 'profile_entity.freezed.dart';

@freezed
sealed class ProfileEntity with _$ProfileEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ProfileEntity({
    int? id,
    String? name,
    String? email,
    String? image,
    String? createdAt,
  }) = _ProfileEntity;

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => _$ProfileEntityFromJson(json);
}
