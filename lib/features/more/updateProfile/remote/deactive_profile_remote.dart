import '../../../../../core/dto/models/baseModules/api_state.dart';
import '../../../../../core/dto/models/phone/phone_request.dart';
import '../../../../../core/dto/modules/odoo_dio_module.dart';
import '../../../../../core/dto/modules/shared_pref_module.dart';
import '../../../../../core/dto/network/api_client.dart';
import '../../../../../core/dto/remote/base_remote_module.dart';

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
