import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/phone/phone_request.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/network/api_client.dart';

class DeActiveProfileRemote extends BaseRemoteModule<void, void> {
  DeActiveProfileRemote() {
    apiFuture = ApiClient(OdooDioModule().build())
        .deActiveProfile(PhoneRequest(SharedPrefModule().userName ?? ''));
  }

  @override
  ApiState<void> onSuccessHandle(void response) {
    return SuccessState(null);
  }

  @override
  Future<bool> refreshToken() async {
    return false;
  }
}
