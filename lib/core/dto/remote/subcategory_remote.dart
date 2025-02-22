
import '../models/baseModules/api_state.dart';
import '../modules/odoo_dio_module.dart';
import '../modules/shared_pref_module.dart';
import '../network/api_client.dart';

import '../models/category/category_response.dart';
import '../models/category/subcategory_request.dart';
import '../models/home/category_mapper.dart';
import 'base_remote_module.dart';

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
