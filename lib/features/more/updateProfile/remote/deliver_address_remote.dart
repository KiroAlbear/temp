import '../../../../core/dto/models/baseModules/api_state.dart';
import '../../../../core/dto/models/update_profile/delivery_address_mapper.dart';
import '../../../../core/dto/models/update_profile/delivery_address_response.dart';
import '../../../../core/dto/modules/odoo_dio_module.dart';
import '../../../../core/dto/network/api_client.dart';
import '../../../../core/dto/remote/base_remote_module.dart';

class DeliveryAddressRemote extends BaseRemoteModule<DeliveryAddressMapper,
    List<DeliveryAddressResponse>> {

  DeliveryAddressRemote(String userId) {
    try{
      apiFuture = ApiClient(OdooDioModule().build()).getDeliveryAddress(userId);
    }catch (e) {
      print(e);
    }
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
