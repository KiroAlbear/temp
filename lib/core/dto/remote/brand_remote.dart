
import '../models/baseModules/api_state.dart';
import '../models/brand/all_brands_request.dart';
import '../models/brand/brand_mapper.dart';
import '../models/brand/brand_request.dart';
import '../models/brand/brand_response.dart';
import '../modules/odoo_dio_module.dart';
import '../modules/shared_pref_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class BrandRemote
    extends BaseRemoteModule<List<BrandMapper>, List<BrandResponse>> {
  @override
  ApiState<List<BrandMapper>> onSuccessHandle(List<BrandResponse>? response) {
    List<BrandMapper> list = [];
    response?.forEach((element) {
      list.add(BrandMapper(element));
    });
    return SuccessState(list);
  }

  Stream<ApiState<List<BrandMapper>>> loadAllBrands(
      AllBrandsRequest brandRequest) {
    apiFuture = ApiClient(OdooDioModule().build())
        .getAllBrands(brandRequest, SharedPrefModule().apiSelectedLanguageCode);

    return callApiAsStream();
  }

  Stream<ApiState<List<BrandMapper>>> loadBrandBySubCategoryId(
      BrandRequest brandRequest) {
    apiFuture = ApiClient(OdooDioModule().build()).getBrandBySubCategory(
        brandRequest, SharedPrefModule().apiSelectedLanguageCode);

    return callApiAsStream();
  }

  @override
  Future<bool> refreshToken() async {
    return false;
  }
}
