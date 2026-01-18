import 'package:deel/features/most_selling/models/most_selling_request_model.dart';

import '../../../deel.dart';
import '../models/most_selling_response_model.dart';

class MostSellingRemote
    extends
        AdminBaseRemoteModule<List<ProductMapper>, MostSellingResponseModel> {
  MostSellingRemote(MostSellingRequestModel requestModel) {
    apiFuture = AdminClient(
      AdminDioModule().build(),
    ).getMostSelling(requestModel);
  }
  // Stream<ApiState<List<ProductMapper>>> getMostSelling(
  //     MostSellingRequestModel requestModel) {
  //
  //   return callApiAsStream();
  // }

  @override
  ApiState<List<ProductMapper>> onSuccessHandle(
    MostSellingResponseModel? response,
  ) {
    List<ProductMapper> list = [];

    response?.mostSeller?.forEach((element) {
      list.add(ProductMapper.fromProduct(element.productResponse?.first));
    });

    return SuccessState(list);
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
