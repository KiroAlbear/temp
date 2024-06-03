import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/category/category_response.dart';
import 'package:core/dto/models/home/category_mapper.dart';
import 'package:core/dto/models/page_request.dart';
import 'package:core/dto/modules/dio_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/network/api_client.dart';

class CategoryRemote
    extends BaseRemoteModule<List<CategoryMapper>, List<CategoryResponse>> {
  CategoryRemote() {
    apiFuture = ApiClient(DioModule().build()).category(
        PageRequest(1000, 1, 1, int.parse(SharedPrefModule().userId ?? '0')));
  }

  @override
  ApiState<List<CategoryMapper>> onSuccessHandle(
      List<CategoryResponse>? response) {
    List<CategoryMapper> list = [];
    response?.forEach((element) {
      list.add(CategoryMapper(element));
    });
    return SuccessState(list);
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
