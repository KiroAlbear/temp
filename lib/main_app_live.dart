import 'flavors.dart';

import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.app_live;
  F.apiUrl = 'https://dokkan.odoo.com/';
  F.adminApiUrl = 'https://adminapi.dokkan-app.com/api/';
  await runner.main();
}