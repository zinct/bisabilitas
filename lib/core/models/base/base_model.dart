///
/// base_model.dart
/// lib/core/models/empty
///
/// Created by Indra Mahesa https://github.com/zinct
///

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_model.g.dart';
part 'base_model.freezed.dart';

@freezed
sealed class BaseModel with _$BaseModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BaseModel({
    int? code,
    bool? success,
    String? message,
    dynamic data,
  }) = _BaseModel;

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);
}
