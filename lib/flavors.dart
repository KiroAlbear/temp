enum Flavor {
  app_live,
  app_stage,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.app_live:
        return 'Deely';
      case Flavor.app_stage:
        return 'Deely stage';
    }
  }

}
