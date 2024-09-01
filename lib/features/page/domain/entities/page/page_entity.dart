///
/// page_entity.dart
/// lib/features/page/domain/entities
///
/// Created by Indra Mahesa https://github.com/zinct
///

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_entity.g.dart';
part 'page_entity.freezed.dart';

@freezed
sealed class PageEntity with _$PageEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PageEntity({
    int? id,
    String? title,
    String? image,
    String? description,
    String? url,
    int? isFavorite,
    int? isRead,
    int? userId,
    DateTime? createdAt,
    String? updatedAt,
  }) = _PageEntity;

  factory PageEntity.fromJson(Map<String, dynamic> json) =>
      _$PageEntityFromJson(json);
}
