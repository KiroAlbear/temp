
import 'package:deel/core/dto/modules/dio_module.dart';

class OdooDioModule extends DioModule{
  static final OdooDioModule _odooInstance = OdooDioModule.odooInternal();
  OdooDioModule.odooInternal();
  factory OdooDioModule() {
    return _odooInstance;
  }
}