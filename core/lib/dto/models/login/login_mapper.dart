import 'package:core/dto/models/login/login_response.dart';
import 'package:core/dto/modules/shared_pref_module.dart';

class LoginMapper{
  late final int userId;
  late final String token;
  late final String name;

  LoginMapper(LoginResponse response){
    if(response.active?? false){
      name = response.name??'';
      token = response.token??'';
      userId= response.id?? 0;
      SharedPrefModule().bearerToken = token;
      SharedPrefModule().userId = userId.toString();
    }
  }
}