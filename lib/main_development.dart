import 'package:bisabilitas/app.dart';
import 'package:bisabilitas/core/constants/network.dart';
import 'package:bisabilitas/core/flavors/flavor_config.dart';
import 'package:bisabilitas/initial_app.dart';
import 'package:flutter/material.dart';

void main() async {
  await InitialApp.execute();

  FlavorConfig(
    flavor: Flavor.development,
    flavorValues: FlavorValues(
      baseURL: NETWORK.devBaseURL,
    ),
  );

  runApp(
    const MainApp(),
  );
}
