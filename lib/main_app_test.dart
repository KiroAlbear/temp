import 'flavors.dart';
import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.app_test;
  F.apiUrl = 'https://mocki.io/v1/';
  // F.adminApiUrl = 'https://adminapi.dokkan-app.com/api/';
  F.adminApiUrl = 'https://adminapi.deel-app.com/api/';
  await runner.main();
}
