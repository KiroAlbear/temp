import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/page_request.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/dto/models/product/product_response.dart';
import 'package:core/dto/models/product/search_product_request.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/network/api_client.dart';

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
