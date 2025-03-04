
import '../../../../../core/dto/models/baseModules/api_state.dart';
import '../../../../../core/dto/modules/odoo_dio_module.dart';
import '../../../../../core/dto/modules/shared_pref_module.dart';
import '../../../../../core/dto/network/api_client.dart';

import '../../../../../core/dto/models/category/category_response.dart';
import '../../../../../core/dto/models/category/subcategory_request.dart';
import '../../../../../core/dto/models/home/category_mapper.dart';
import '../../../../../core/dto/remote/base_remote_module.dart';

class SubcategoryRemote
    extends BaseRemoteModule<List<CategoryMapper>, List<CategoryResponse>> {
  @override
  ApiState<List<CategoryMapper>> onSuccessHandle(
      List<CategoryResponse>? response) {
    List<CategoryMapper> list = [];
    response?.forEach((element) {
      list.add(CategoryMapper(element));
    });
    return SuccessState(list);
  }

  Stream<ApiState<List<CategoryMapper>>> loadSubCategoryByCategoryId(
      int categoryId, SubcategoryRequest pageRequest) {
    apiFuture = ApiClient(OdooDioModule().build()).getSubCategoryByCategoryId(
        categoryId.toString(),
        pageRequest,
        SharedPrefModule().apiSelectedLanguageCode);

    return callApiAsStream();
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
