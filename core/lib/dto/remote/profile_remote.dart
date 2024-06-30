import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/client/client_request.dart';
import 'package:core/dto/models/login/login_mapper.dart';
import 'package:core/dto/models/login/login_response.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/network/api_client.dart';

class ProfileRemote extends BaseRemoteModule<LoginMapper, LoginResponse>{
  ProfileRemote(){
    apiFuture = ApiClient(OdooDioModule().build()).getProfile(ClientRequest(int.parse(SharedPrefModule().userId??'0')));
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