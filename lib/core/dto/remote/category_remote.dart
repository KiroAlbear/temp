import '../models/baseModules/api_state.dart';
import '../models/category/category_response.dart';
import '../models/home/category_mapper.dart';
import '../models/page_request.dart';
import '../modules/odoo_dio_module.dart';
import '../modules/shared_pref_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class CategoryRemote
    extends BaseRemoteModule<List<CategoryMapper>, List<CategoryResponse>> {
  CategoryRemote() {
    apiFuture = ApiClient(OdooDioModule().build()).category(
      PageRequest(1000, 1, 1, int.parse(SharedPrefModule().userId ?? '0')),
      SharedPrefModule().apiSelectedLanguageCode,
    );
  }

  @override
  ApiState<List<CategoryMapper>> onSuccessHandle(
      List<CategoryResponse>? response) {
    List<CategoryMapper> list = [];
    response?.forEach((element) {
      list.add(CategoryMapper(element));
    });
    list.removeWhere(
      (element) => element.isParent = false,
    );
    return SuccessState(list);
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
