import '../models/baseModules/api_state.dart';
import '../models/favourite/favourite_request.dart';
import '../models/favourite/favourite_response.dart';
import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class FavouriteAddProductRemote
    extends BaseRemoteModule<bool, List<FavouriteResponse>> {
  @override
  ApiState<bool> onSuccessHandle(List<FavouriteResponse>? response) {
    return SuccessState(true);
  }

  Stream<ApiState<bool>> addProduct(FavouriteRequest pageRequest) {
    apiFuture =
        ApiClient(OdooDioModule().build()).addProductToFavourite(pageRequest);
    return callApiAsStream();
  }

  Stream<ApiState<bool>> deleteProduct(FavouriteRequest pageRequest) {
    apiFuture = ApiClient(OdooDioModule().build())
        .deleteProductFromFavourite(pageRequest);
    return callApiAsStream();
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
