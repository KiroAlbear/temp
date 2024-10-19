import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/dto/models/product/product_request.dart';
import 'package:core/dto/models/product/product_response.dart';
import 'package:core/dto/models/product_brand_request.dart';
import 'package:core/dto/models/product_subcategory_brand_request.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
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

  Stream<ApiState<List<ProductMapper>>> loadAllProducts(
      ProductRequest pageRequest) {
    apiFuture = ApiClient(OdooDioModule().build()).getAllProduct(pageRequest);

    return callApiAsStream();
  }

  Stream<ApiState<List<ProductMapper>>> loadProductById(int productId) {
    apiFuture =
        ApiClient(OdooDioModule().build()).getProductById(productId.toString());

    return callApiAsStream();
  }

  Stream<ApiState<List<ProductMapper>>> loadProductByBrand(
      ProductBrandRequest productBrandRequest) {
    apiFuture = ApiClient(OdooDioModule().build()).getProductByBrand(
        productBrandRequest, SharedPrefModule().apiSelectedLanguageCode);

    return callApiAsStream();
  }

  Stream<ApiState<List<ProductMapper>>> loadProductBySubCategoryBrand(
      ProductSubcategoryBrandRequest productSubcategoryBrandRequest) {
    apiFuture = ApiClient(OdooDioModule().build()).getProductBySubCategoryBrand(
        productSubcategoryBrandRequest,
        SharedPrefModule().apiSelectedLanguageCode);

    return callApiAsStream();
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
