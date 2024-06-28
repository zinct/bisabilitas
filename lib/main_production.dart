import 'package:flutter/material.dart';

import 'app.dart';
import 'core/flavors/flavor_config.dart';
import 'initial_app.dart';

void main() async {
  await InitialApp.execute();

  FlavorConfig(
    flavor: Flavor.development,
    flavorValues: FlavorValues(),
  );

  runApp(
    const MainApp(),
  );
}
