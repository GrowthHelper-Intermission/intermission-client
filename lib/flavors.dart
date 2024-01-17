enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'sample1';
      case Flavor.prod:
        return 'sample2';
      default:
        return 'title';
    }
  }

}
