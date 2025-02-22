import '../models/baseModules/api_state.dart';
import '../models/client/client_request.dart';
import '../models/profile/profile_mapper.dart';
import '../models/profile/profile_response.dart';
import '../modules/odoo_dio_module.dart';
import '../modules/shared_pref_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class ProfileRemote extends BaseRemoteModule<ProfileMapper, ProfileResponse> {
  ProfileRemote() {
    apiFuture = ApiClient(OdooDioModule().build())
        .getProfile(ClientRequest(int.parse(SharedPrefModule().userId ?? '0')));
  }

  @override
  ApiState<ProfileMapper> onSuccessHandle(ProfileResponse? response) {
    return SuccessState(ProfileMapper(response!));
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
