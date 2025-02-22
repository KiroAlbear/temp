import '../models/baseModules/api_state.dart';
import '../models/login/login_mapper.dart';
import '../models/login/login_request.dart';
import '../models/login/login_response.dart';
import '../modules/logger_module.dart';
import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class LoginRemote extends BaseRemoteModule<LoginMapper, List<LoginResponse>> {
  late final LoginRequest loginRequest;

  LoginRemote({required this.loginRequest}) {
    LoggerModule.log(
        message: OdooDioModule().baseUrl, name: runtimeType.toString());
    isFormLogin = true;
    apiFuture = ApiClient(OdooDioModule().build()).login(loginRequest);
  }

  @override
  ApiState<LoginMapper> onSuccessHandle(List<LoginResponse>? response) {
    return SuccessState(LoginMapper(response!.first));
  }

  @override
  Future<bool> refreshToken() async {
    return false;
  }
}
