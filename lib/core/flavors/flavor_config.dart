enum Flavor { development, staging, production }

class FlavorValues {
  FlavorValues();
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final FlavorValues flavorValues;
  static FlavorConfig? _instance;

  factory FlavorConfig(
      {required Flavor flavor, required FlavorValues flavorValues}) {
    var temp = FlavorConfig._internal(
        flavor, enumName(flavor.toString()), flavorValues);
    _instance ??= temp;
    return temp;
  }

  FlavorConfig._internal(this.flavor, this.name, this.flavorValues);

  static FlavorConfig? get instance => _instance;

  static String enumName(String name) {
    List<String> paths = name.split(".");
    return paths[paths.length - 1];
  }

  static bool isProduction() => _instance?.flavor == Flavor.production;
  static bool isDevelopment() => _instance?.flavor == Flavor.development;
  static bool isStaging() => _instance?.flavor == Flavor.staging;
}
