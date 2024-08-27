import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/network/api_client.dart';

import '../models/update_profile/delivery_address_mapper.dart';
import '../models/update_profile/delivery_address_response.dart';

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
