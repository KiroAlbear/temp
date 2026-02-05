import 'package:rxdart/rxdart.dart';

import '../../../deel.dart';

class MostSellingBloc extends BlocBase with ResponseHandlerModule {
  final BehaviorSubject<ApiState<List<ProductMapper>>> mostSellingBehaviour =
      BehaviorSubject()..sink.add(LoadingState());

  int pageNumber = 1;
  final pageSize = 16;

  void getMostSelling() {
    pageNumber = 1;
    _callMostSellingApi(pageNumber, false);
  }

  void loadMoreMostSelling() {
    pageNumber++;
    _callMostSellingApi(pageNumber, true);
  }

  void _callMostSellingApi(int pageNumber, bool loadMore) {
    MostSellingRemote(
      MostSellingRequestModel(
        pageIndex: pageNumber,
        pageSize: pageSize,
        sortBy: "OrderNo",
        sortDirection: "asc",
        token: SharedPrefModule().bearerToken,
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
