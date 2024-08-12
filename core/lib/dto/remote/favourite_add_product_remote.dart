import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/favourite/favourite_request.dart';
import 'package:core/dto/models/favourite/favourite_response.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/network/api_client.dart';

class FavouriteAddProductRemote
    extends BaseRemoteModule<bool, FavouriteResponse> {
  @override
  ApiState<bool> onSuccessHandle(FavouriteResponse? response) {
    return SuccessState(true);
  }

  Stream<ApiState<bool>> addProduct(FavouriteRequest pageRequest) {
    apiFuture =
        ApiClient(OdooDioModule().build()).addProductToFavourite(pageRequest);
    return callApiAsStream();
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
