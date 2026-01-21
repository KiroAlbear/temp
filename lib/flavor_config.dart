import 'flavors.dart';

class FlavorConfig {
  static String get adminApiUrl {
    if (F.appFlavor == Flavor.app_live)
      return 'https://adminapi.deel-app.com/api/';
    else
      return 'https://adminapi.stg.deel-app.com/api/';
  }

  static String get apiUrl {
    if (F.appFlavor == Flavor.app_live)
      return 'https://sl-erp.odoo.com/';
    else
      return 'https://deel-demo.odoo.com/';
  }
}
