import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/password/reset_password_request.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/network/api_client.dart';

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
