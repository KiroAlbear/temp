import '../../../deel.dart';

class RecommendedItemsRemote
    extends
        AdminBaseRemoteModule<
          List<ProductMapper>,
          RecommendedItemsResponseModel
        > {
  RecommendedItemsRemote(RecommendedItemsRequestModel requestModel) {
    apiFuture = AdminClient(
      AdminDioModule().build(),
    ).getRecommendedItems(requestModel);
  }

  @override
  ApiState<List<ProductMapper>> onSuccessHandle(
    RecommendedItemsResponseModel? response,
  ) {
    List<ProductMapper> list = [];

    response?.recommendedItems?.productResponse?.forEach((element) {
      list.add(ProductMapper.fromProduct(element));
    });

    return SuccessState(list);
  }

  @override
  Future<bool> refreshToken() async {
    return false;
  }
}
