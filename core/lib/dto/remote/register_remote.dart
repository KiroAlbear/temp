import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/login/login_mapper.dart';
import 'package:core/dto/models/login/login_response.dart';
import 'package:core/dto/models/register/register_request.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/network/api_client.dart';

class RegisterRemote
    extends BaseRemoteModule<LoginMapper, List<LoginResponse>> {
  RegisterRemote(
      {required String shopName,
      required String name,
      required String phone,
      required String password,
      required String latitude,
      required String longitude}) {
    SharedPrefModule().userPhone = phone;
    SharedPrefModule().password = password;
    apiFuture = ApiClient(OdooDioModule().build()).register(RegisterRequest(
        login: phone,
        password: password,
        confirmPassword: password,
        phone: phone,
        name: name,
        shopName: shopName,
        latitude: latitude,
        longitude: longitude));
  }

  @override
  ApiState<LoginMapper> onSuccessHandle(List<LoginResponse>? response) {
    return SuccessState(LoginMapper(response!.first));
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
