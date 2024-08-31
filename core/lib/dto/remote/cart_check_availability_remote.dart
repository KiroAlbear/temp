import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/cart/cart_check_availability_request.dart';
import 'package:core/dto/models/cart/cart_check_availability_response.dart';

import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';

class CartCheckAvailabilityRemote extends BaseRemoteModule<
    List<CartCheckAvailabilityResponse>, List<CartCheckAvailabilityResponse>> {
  CartCheckAvailabilityRemote();

  Stream<ApiState<List<CartCheckAvailabilityResponse>>> checkAvailability(
      CartCheckAvailabilityRequest request) {
    apiFuture = ApiClient(OdooDioModule().build()).checkAvailability(request);
    return callApiAsStream();
  }

  @override
  ApiState<List<CartCheckAvailabilityResponse>> onSuccessHandle(
      List<CartCheckAvailabilityResponse>? response) {
    return SuccessState(response!, message: 'Success');
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
