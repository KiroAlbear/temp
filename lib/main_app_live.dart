import 'package:deel/core/dto/modules/constants_module.dart';

import 'flavors.dart';
import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.app_live;
  await runner.main();
}
