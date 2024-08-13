import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/login/login_mapper.dart';
import 'package:core/dto/models/login/login_response.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/network/api_client.dart';

class UpdateProfileImageRemote extends BaseRemoteModule<LoginMapper, LoginResponse>{

  UpdateProfileImageRemote({required File file}){
    apiFuture = ApiClient(OdooDioModule().build()).updateProfileImage(SharedPrefModule().userName??'', file);
  }

  @override
  ApiState<LoginMapper> onSuccessHandle(LoginResponse? response) {
    return SuccessState(LoginMapper(response!));
  }

  @override
  Future<bool> refreshToken() async{
   return true;
  }


}