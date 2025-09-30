import 'package:deel/core/dto/modules/constants_module.dart';

import 'flavors.dart';
import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.app_live;
  F.apiUrl = 'https://deel-demo.odoo.com/';
  // F.adminApiUrl = 'https://adminapi.dokkan-app.com/api/';
  F.adminApiUrl = 'https://adminapi.deel-app.com/api/';
  // F.adminApiUrl = 'https://adminapi.stg.deel-app.com/api/';
  ConstantModule.isLive = true;
  await runner.main();
}
