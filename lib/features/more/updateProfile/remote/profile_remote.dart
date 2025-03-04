import '../../../../../core/dto/models/baseModules/api_state.dart';
import '../../../../../core/dto/models/client/client_request.dart';
import '../../../../../core/dto/models/profile/profile_mapper.dart';
import '../../../../../core/dto/models/profile/profile_response.dart';
import '../../../../../core/dto/modules/odoo_dio_module.dart';
import '../../../../../core/dto/modules/shared_pref_module.dart';
import '../../../../../core/dto/network/api_client.dart';
import '../../../../../core/dto/remote/base_remote_module.dart';

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
