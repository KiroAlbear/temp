import '../../../../../core/dto/models/baseModules/api_state.dart';
import '../../../../../core/dto/models/page_request.dart';
import '../../../../../core/dto/models/product/favourite_product_response.dart';
import '../../../../../core/dto/models/product/product_mapper.dart';
import '../../../../../core/dto/modules/odoo_dio_module.dart';
import '../../../../../core/dto/network/api_client.dart';
import '../../../../../core/dto/remote/base_remote_module.dart';

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
