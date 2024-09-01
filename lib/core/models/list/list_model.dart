///
/// list_model.dart
/// lib/core/models/list
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_model.freezed.dart';
part 'list_model.g.dart';

@Freezed(genericArgumentFactories: true)
sealed class ListModel<T> with _$ListModel<T> {
  const factory ListModel({
    int? code,
    bool? success,
    String? message,
    List<T>? data,
  }) = _ListModel;

  factory ListModel.fromJson(
          Map<String, dynamic> json, T Function(dynamic) fromJsonT) =>
      _$ListModelFromJson(json, fromJsonT);
}
