
import '../models/baseModules/api_state.dart';
import '../models/update_profile/update_profile_request.dart';
import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class UpdateProfiledRemote extends BaseRemoteModule<void, void> {
  UpdateProfiledRemote({required UpdateProfileRequestBody body}) {
    apiFuture = ApiClient(OdooDioModule().build()).updateProfile(body);
  }

  @override
  ApiState<void> onSuccessHandle(void response) {
    return SuccessState(null);
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
