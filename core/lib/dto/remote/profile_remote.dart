import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/client/client_request.dart';
import 'package:core/dto/models/profile/profile_mapper.dart';
import 'package:core/dto/models/profile/profile_response.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/network/api_client.dart';

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
