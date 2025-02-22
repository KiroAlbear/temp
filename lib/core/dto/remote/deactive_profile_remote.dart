import '../models/baseModules/api_state.dart';
import '../models/phone/phone_request.dart';
import '../modules/odoo_dio_module.dart';
import '../modules/shared_pref_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class DeActiveProfileRemote extends BaseRemoteModule<void, void> {
  DeActiveProfileRemote() {
    apiFuture = ApiClient(OdooDioModule().build())
        .deActiveProfile(PhoneRequest(SharedPrefModule().userPhone ?? ''));
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
