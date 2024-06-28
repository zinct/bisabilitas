import 'package:equatable/equatable.dart';

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaginationParams extends Equatable {
  final int? page;

  const PaginationParams(this.page);

  @override
  List<Object?> get props => [page];
}
