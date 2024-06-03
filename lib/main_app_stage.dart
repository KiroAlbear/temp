import 'flavors.dart';

import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.app_stage;
  F.apiUrl = 'https://dokkan.odoo.com/';
  await runner.main();
}