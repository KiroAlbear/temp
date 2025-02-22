
import 'package:deel/core/dto/modules/odoo_dio_module.dart';

import '../../modules/shared_pref_module.dart';
import 'login_response.dart';

class LoginMapper {
  late final int userId;
  late final String token;
  late final String name;
  late final String phone;
  late final double lat;
  late final double long;
  late final String shopName;

  String image = '';

  LoginMapper(LoginResponse response) {
    if (response.active ?? false) {
      name = response.name ?? '';
      token = response.token ?? '';
      userId = response.id ?? 0;
      phone = response.phone ?? '';
      lat = response.latitude ?? 0;
      long = response.longitude ?? 0;
      shopName = response.shop_name ?? '';
      if (token.isNotEmpty) {
        SharedPrefModule().bearerToken = token;
        OdooDioModule().setAppHeaders();
      }
      SharedPrefModule().shopName = shopName;
      SharedPrefModule().userLat = lat;
      SharedPrefModule().userLong = long;
      SharedPrefModule().userId = userId.toString();
    }
  }
}
