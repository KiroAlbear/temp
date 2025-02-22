import 'dio_module.dart';

class AdminDioModule extends DioModule {

  static final AdminDioModule _adminInstance = AdminDioModule.adminInternal();
  AdminDioModule.adminInternal();
  factory AdminDioModule() {
    return _adminInstance;
  }
}


