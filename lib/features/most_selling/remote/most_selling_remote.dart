import '../../../deel.dart';

class MostSellingRemote
    extends
        AdminBaseRemoteModule<List<ProductMapper>, MostSellingResponseModel> {
  MostSellingRemote(MostSellingRequestModel requestModel) {
    apiFuture = AdminClient(
      AdminDioModule().build(),
    ).getMostSelling(requestModel);
  }

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
