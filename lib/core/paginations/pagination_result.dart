///
/// pagination_result.dart
/// lib/core/paginations
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:freezed_annotation/freezed_annotation.dart';

import 'entities/pagination/pagination_entity.dart';

part 'pagination_result.freezed.dart';
part 'pagination_result.g.dart';

@Freezed(genericArgumentFactories: true)
class PaginationResult<T> with _$PaginationResult<T> {
  const factory PaginationResult({
    List<T>? list,
    PaginationEntity? pagination,
  }) = _PaginationResult<T>;

  factory PaginationResult.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) =>
      _$PaginationResultFromJson<T>(json, fromJsonT);
}
