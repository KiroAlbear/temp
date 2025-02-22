import '../models/baseModules/api_state.dart';
import '../models/password/reset_password_request.dart';
import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class ResetPasswordRemote extends BaseRemoteModule<void, void> {
  ResetPasswordRemote({required String phone, required String newPassword}) {
    isFormLogin = true;
    apiFuture =
        ApiClient(OdooDioModule().build()).resetPassword(ResetPasswordRequest(
      phone: phone,
      password: newPassword,
    ));
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
