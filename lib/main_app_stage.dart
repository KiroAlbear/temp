import 'flavors.dart';
import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.app_stage;
  F.apiUrl = 'https://dokkan.odoo.com/';
  // F.adminApiUrl = 'https://adminapi.dokkan-app.com/api/';
  // F.adminApiUrl = 'https://adminapi.deel-app.com/api/';
  F.adminApiUrl = 'https://adminapi.stg.deel-app.com/api/';
  await runner.main();
}
