
import '../models/baseModules/api_state.dart';
import '../models/page_request.dart';
import '../models/product/product_mapper.dart';
import '../models/product/product_response.dart';
import '../models/product/search_product_request.dart';
import '../modules/odoo_dio_module.dart';
import '../modules/shared_pref_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class SearchProductRemote
    extends BaseRemoteModule<List<ProductMapper>, List<ProductResponse>> {
  @override
  ApiState<List<ProductMapper>> onSuccessHandle(
      List<ProductResponse>? response) {
    List<ProductMapper> list = [];
    response?.forEach((element) {
      list.add(ProductMapper.fromProduct(element));
    });
    return SuccessState(list);
  }

  Stream<ApiState<List<ProductMapper>>> loadProduct(
      PageRequest pageRequest, String value) {
    apiFuture = ApiClient(OdooDioModule().build()).searchProduct(
        SearchProductRequest(value, pageRequest.page, pageRequest.limit),
        SharedPrefModule().apiSelectedLanguageCode);
    return callApiAsStream();
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
