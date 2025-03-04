
import '../../../../core/dto/models/address/address_request.dart';
import '../../../../core/dto/models/baseModules/api_state.dart';
import '../../../../core/dto/models/login/login_mapper.dart';
import '../../../../core/dto/models/login/login_response.dart';
import '../../../../core/dto/modules/odoo_dio_module.dart';
import '../../../../core/dto/network/api_client.dart';
import '../../../../core/dto/remote/base_remote_module.dart';

class UpdateAddressRemote extends BaseRemoteModule<LoginMapper, LoginResponse> {
  UpdateAddressRemote(
      {required int clientId,
      required String street,
      required String street2,
      required String city,
      required double latitude,
      required double longitude,
      int countryId = 245,
      int stateId = 1,
      String zip = "zip"}) {
    apiFuture = ApiClient(OdooDioModule().build()).updateAddress(AddressRequest(
        clientId: clientId,
        street: street,
        street2: street2,
        city: city,
        longitude: longitude,
        latitude: latitude,
        countryId: countryId,
        stateId: stateId,
        zip: zip));
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
