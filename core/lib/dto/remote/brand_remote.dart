import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/brand/brand_mapper.dart';
import 'package:core/dto/models/brand/brand_request.dart';
import 'package:core/dto/models/brand/brand_response.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/network/api_client.dart';

import '../models/category/category_response.dart';
import '../models/category/subcategory_request.dart';
import '../models/home/category_mapper.dart';

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

  Stream<ApiState<List<BrandMapper>>> loadSubCategoryByCategoryId(
      int categoryId, BrandRequest brandRequest) {
    apiFuture = ApiClient(OdooDioModule().build())
        .getBrandBySubCategory(brandRequest);

    return callApiAsStream();
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
