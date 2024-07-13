import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/login/login_mapper.dart';
import 'package:core/dto/models/login/login_response.dart';
import 'package:core/dto/models/register/register_request.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/network/api_client.dart';

class RegisterRemote extends BaseRemoteModule<LoginMapper, LoginResponse> {
  RegisterRemote(
      {required String shopName,
      required String name,
      required String phone,
      required String password,
      required String latitude,
      required String longitude}) {
    SharedPrefModule().userName = phone;
    SharedPrefModule().password = password;
    apiFuture = ApiClient(OdooDioModule().build()).register(RegisterRequest(
        login: phone,
        password: password,
        confirmPassword: password,
        phone: phone,
        name: '$name-$shopName',
        latitude: latitude,
        longitude: longitude));
  }

  @override
  ApiState<LoginMapper> onSuccessHandle(LoginResponse? response) {
    return SuccessState(LoginMapper(response!));
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
