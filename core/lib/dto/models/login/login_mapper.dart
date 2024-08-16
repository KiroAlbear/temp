import 'package:core/dto/models/login/login_response.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';

class LoginMapper {
  late final int userId;
  late final String token;
  late final String name;
  late final String phone;
  late final double lat;
  late final double long;

  String image = '';

  LoginMapper(LoginResponse response) {
    if (response.active ?? false) {
      name = response.name ?? '';
      token = response.token ?? '';
      userId = response.id ?? 0;
      phone = response.phone ?? '';
      lat = response.latitude ?? 0;
      long = response.longitude ?? 0;
      if (token.isNotEmpty) {
        SharedPrefModule().bearerToken = token;
        OdooDioModule().setAppHeaders();
      }
      SharedPrefModule().userLat = lat;
      SharedPrefModule().userLong = long;
      SharedPrefModule().userId = userId.toString();
    }
  }
}
