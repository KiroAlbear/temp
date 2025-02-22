import '../models/baseModules/api_state.dart';
import '../models/page_request.dart';
import '../models/product/favourite_product_response.dart';
import '../models/product/product_mapper.dart';
import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class FavouriteProductRemote
    extends BaseRemoteModule<List<ProductMapper>, List<FavouriteProductResponse>> {
  @override
  ApiState<List<ProductMapper>> onSuccessHandle(
      List<FavouriteProductResponse>? response) {
    List<ProductMapper> list = [];
    response?.forEach((element) {
      list.add(ProductMapper.fromProduct(element.productResponse));
    });
    return SuccessState(list);
  }

  Stream<ApiState<List<ProductMapper>>> loadProduct(PageRequest pageRequest) {
    apiFuture = ApiClient(OdooDioModule().build()).getFavouriteProduct(pageRequest);
    return callApiAsStream();
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
