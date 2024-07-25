import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/update_profile/update_profile_request.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/network/api_client.dart';

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
