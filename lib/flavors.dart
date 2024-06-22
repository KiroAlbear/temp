enum Flavor {
  app_live,
  app_stage,
  app_test,
}

class F {
  static Flavor? appFlavor;
  static String apiUrl = '';
  static String adminApiUrl = '';
  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.app_live:
        return 'availo kiosk';
      case Flavor.app_stage:
        return 'Availo K stage';
      case Flavor.app_test:
        return 'Availo K test';
      default:
        return 'availo kiosk';
    }
  }

}