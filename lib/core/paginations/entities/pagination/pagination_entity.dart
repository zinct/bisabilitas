///
/// pagination_entity.dart
/// lib/core/paginations/entities
///
/// Created by Indra Mahesa https://github.com/zinct
///

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_entity.freezed.dart';
part 'pagination_entity.g.dart';

@freezed
class PaginationEntity with _$PaginationEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PaginationEntity({
    int? perPage,
    int? currentPage,
  }) = _PaginationEntity;

  factory PaginationEntity.fromJson(Map<String, Object?> json) =>
      _$PaginationEntityFromJson(json);
}
