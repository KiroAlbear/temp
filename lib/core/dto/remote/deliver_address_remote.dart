import '../models/baseModules/api_state.dart';
import '../models/update_profile/delivery_address_mapper.dart';
import '../models/update_profile/delivery_address_response.dart';
import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class DeliveryAddressRemote extends BaseRemoteModule<DeliveryAddressMapper,
    List<DeliveryAddressResponse>> {
  DeliveryAddressRemote(String userId) {
    apiFuture = ApiClient(OdooDioModule().build()).getDeliveryAddress(userId);
  }

  @override
  ApiState<DeliveryAddressMapper> onSuccessHandle(
      List<DeliveryAddressResponse>? response) {
    return SuccessState(DeliveryAddressMapper(response!.first));
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
