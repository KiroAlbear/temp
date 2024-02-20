import 'flavors.dart';

import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.app_stage;
  F.apiUrl = 'www.google.com/api';
  await runner.main();
}