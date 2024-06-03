import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/page_request.dart';
import 'package:core/dto/models/product/favourite_product_response.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/dto/models/product/product_response.dart';
import 'package:core/dto/modules/dio_module.dart';
import 'package:core/dto/network/api_client.dart';

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
    apiFuture = ApiClient(DioModule().build()).getFavouriteProduct(pageRequest);
    return callApiAsStream();
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
