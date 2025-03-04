import '../../../../../core/dto/models/baseModules/api_state.dart';
import '../../../../../core/dto/models/category/category_response.dart';
import '../../../../../core/dto/models/home/category_mapper.dart';
import '../../../../../core/dto/models/page_request.dart';
import '../../../../../core/dto/modules/odoo_dio_module.dart';
import '../../../../../core/dto/modules/shared_pref_module.dart';
import '../../../../../core/dto/network/api_client.dart';
import '../../../../../core/dto/remote/base_remote_module.dart';

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
