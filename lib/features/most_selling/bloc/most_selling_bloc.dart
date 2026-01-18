import 'package:deel/features/announcements/remote/announcements_remote.dart';
import 'package:deel/features/most_selling/models/most_selling_response_model.dart';
import 'package:deel/features/most_selling/remote/most_selling_remote.dart';
import 'package:rxdart/rxdart.dart';

import '../../../deel.dart';
import '../models/most_selling_request_model.dart';

class MostSellingBloc extends BlocBase with ResponseHandlerModule {
  final BehaviorSubject<ApiState<List<ProductMapper>>> mostSellingBehaviour =
      BehaviorSubject()..sink.add(LoadingState());

  int pageNumber = 1;
  final pageSize = 10;

  void getMostSelling() {
    pageNumber = 1;
    _callMostSellingApi(pageNumber);
  }

  void loadMoreMostSelling(){
    pageNumber++;
    _callMostSellingApi(pageNumber);
  }


  void _callMostSellingApi(int pageNumber){
    MostSellingRemote(
      MostSellingRequestModel(
        pageIndex: pageNumber,
        pageSize: pageSize,
        sortBy: "OrderNo",
        sortDirection: "asc",
      ),
    ).callApiAsStream().listen((event) {
      getIt<CartBloc>().addCartInfoToProducts(event.response??[]);
      mostSellingBehaviour.sink.add(event);
    });
  }

  @override
  void dispose() {}
}
