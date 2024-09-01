import 'dart:io';

import 'package:bisabilitas/core/api/api.dart';
import 'package:bisabilitas/core/api/dio_api.dart';
import 'package:bisabilitas/core/utils/debouncer_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initialize() {
  // Api
  getIt.registerLazySingleton<Api>(() => DioApi());

  // Data sources

  // Repositories

  // Usecases

  // Cubit

  // Others
  getIt.registerFactory(() => TextEditingController());
  getIt.registerFactory(() => ScrollController());
  getIt.registerFactory(() => GlobalKey<FormState>());
  getIt.registerFactory(() => DebouncerUtils());
  getIt.registerFactory(() => PageController());
  getIt.registerFactory(() => File(''));

  // External
}
