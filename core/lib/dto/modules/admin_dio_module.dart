import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/header_response.dart';
import 'package:core/dto/modules/app_provider_module.dart';
import 'package:core/dto/modules/dio_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:dio_builder/dio_builder.dart';

import 'constants_module.dart'; // Import constants for base URLs
import 'logger_module.dart'; // Import logger module for logging

class AdminDioModule extends DioModule {

  static final AdminDioModule _adminInstance = AdminDioModule.adminInternal();
  AdminDioModule.adminInternal();
  factory AdminDioModule() {
    return _adminInstance;
  }
}


