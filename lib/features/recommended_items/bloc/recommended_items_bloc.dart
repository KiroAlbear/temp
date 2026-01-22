import 'package:deel/features/most_selling/remote/most_selling_remote.dart';
import 'package:rxdart/rxdart.dart';

import '../../../deel.dart';
import '../models/recommended_items_request_model.dart';
import '../remote/recommended_items_remote.dart';

class RecommendedItemsBloc extends BlocBase with ResponseHandlerModule {
  final BehaviorSubject<ApiState<List<ProductMapper>>> mostSellingBehaviour =
      BehaviorSubject()..sink.add(LoadingState());

  int pageNumber = 1;
  final pageSize = 16;

  void getRecommendedItems() {
    pageNumber = 1;
    _callRecommendedItemsApi(pageNumber, false);
  }

  void loadMoreRecommendedItems() {
    pageNumber++;
    _callRecommendedItemsApi(pageNumber, true);
  }

  void _callRecommendedItemsApi(int pageNumber, bool loadMore) {
    RecommendedItemsRemote(
      RecommendedItemsRequestModel(
        pageIndex: pageNumber,
        pageSize: pageSize,
        sortBy: "OrderNo",
        sortDirection: "asc",
        companyTypeId: 35,
      ),
    ).callApiAsStream().listen((event) {
      getIt<CartBloc>().addCartInfoToProducts(event.response ?? []);

      if (loadMore) {
        if (event is SuccessState) {
          List<ProductMapper> oldList =
              mostSellingBehaviour.value.response ?? [];
          oldList.addAll(event.response ?? []);
          event.response = oldList;
          mostSellingBehaviour.sink.add(event);
        }
      } else {
        mostSellingBehaviour.sink.add(event);
      }
    });
  }

  @override
  void dispose() {}
}
