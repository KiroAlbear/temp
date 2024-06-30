import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/password/change_password_request.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/network/api_client.dart';

class ChangePasswordRemote extends BaseRemoteModule<void, void> {

  ChangePasswordRemote(
      {required String oldPassword, required String newPassword}) {
    apiFuture = ApiClient(OdooDioModule().build()).changePassword(
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
  Future<bool> refreshToken() async{
    return true;
  }


}