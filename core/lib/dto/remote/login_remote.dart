import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/login/login_mapper.dart';
import 'package:core/dto/models/login/login_request.dart';
import 'package:core/dto/models/login/login_response.dart';
import 'package:core/dto/modules/dio_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/network/api_client.dart';

class LoginRemote extends BaseRemoteModule<LoginMapper, LoginResponse> {
  late final LoginRequest loginRequest;

  LoginRemote({required this.loginRequest}) {
    isFormLogin = true;
    apiFuture = ApiClient(DioModule().build()).login(loginRequest);
  }

  @override
  ApiState<LoginMapper> onSuccessHandle(LoginResponse? response) {
    return SuccessState(LoginMapper(response!));
  }

  @override
  Future<bool> refreshToken() async {
    return false;
  }
}
