import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/page_request.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/dto/models/product/product_request.dart';
import 'package:core/dto/models/product/product_response.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/network/api_client.dart';

class ProductRemote
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
      PageRequest pageRequest, ProductRequest productRequest,
      {bool isForAll = true, int categoryId = 0}) {
    if (isForAll) {
      apiFuture =
          ApiClient(OdooDioModule().build()).getAllProduct(productRequest);
    } else {
      apiFuture =
          ApiClient(OdooDioModule().build()).getProductByCategory(pageRequest);
    }
    return callApiAsStream();
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
