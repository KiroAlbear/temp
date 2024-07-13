import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/update_profile/delivery_address_mapper.dart';
import 'package:core/dto/models/update_profile/delivery_address_response.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/network/api_client.dart';

class DeliveryAddressRemote
    extends BaseRemoteModule<DeliveryAddressMapper, DeliveryAddressResponse> {
  DeliveryAddressRemote() {
    apiFuture = ApiClient(OdooDioModule().build()).getDeliveryAddress('51');
  }

  @override
  ApiState<DeliveryAddressMapper> onSuccessHandle(
      DeliveryAddressResponse? response) {
    return SuccessState(DeliveryAddressMapper(response!));
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
