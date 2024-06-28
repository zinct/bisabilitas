///
/// pagination_model.dart
/// lib/core/paginations/models
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:equatable/equatable.dart';

import '../pagination_result.dart';

class PaginationModel<T> extends Equatable {
  final int? code;
  final bool? success;
  final String? message;
  final PaginationResult<T>? data;

  const PaginationModel({
    this.code,
    this.success,
    this.message,
    this.data = const PaginationResult(),
  });

  factory PaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return PaginationModel(
      code: json["code"],
      success: json["success"],
      message: json["message"],
      data: PaginationResult<T>.fromJson(json["data"], fromJsonT),
    );
  }

  @override
  List<Object?> get props => [code, success, message, data];
}
