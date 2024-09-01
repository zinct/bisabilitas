import 'package:bisabilitas/core/constants/network.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/flavors/flavor_config.dart';
import 'initial_app.dart';

void main() async {
  await InitialApp.execute();

  FlavorConfig(
    flavor: Flavor.development,
    flavorValues: FlavorValues(
      baseURL: NETWORK.prodBaseURL,
    ),
  );

  runApp(
    const MainApp(),
  );
}
