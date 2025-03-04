
import '../../../../../core/dto/models/baseModules/api_state.dart';
import '../../../../../core/dto/models/brand/all_brands_request.dart';
import '../../../../../core/dto/models/brand/brand_mapper.dart';
import '../../../../../core/dto/models/brand/brand_request.dart';
import '../../../../../core/dto/models/brand/brand_response.dart';
import '../../../../../core/dto/modules/odoo_dio_module.dart';
import '../../../../../core/dto/modules/shared_pref_module.dart';
import '../../../../../core/dto/network/api_client.dart';
import '../../../../../core/dto/remote/base_remote_module.dart';

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
