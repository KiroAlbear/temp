
import '../models/baseModules/api_state.dart';
import '../models/password/change_password_request.dart';
import '../modules/odoo_dio_module.dart';
import '../modules/shared_pref_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class ChangePasswordRemote extends BaseRemoteModule<void, void> {
  ChangePasswordRemote(
      {required String oldPassword, required String newPassword}) {
    var apiFuture = ApiClient(OdooDioModule().build()).changePassword(
        ChangePasswordRequest(
            clientId: int.parse((SharedPrefModule().userId ?? '0')),
            newPassword: newPassword,
            oldPassword: oldPassword));
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
