import 'package:deel/features/announcements/remote/announcements_remote.dart';
import 'package:deel/features/most_selling/models/most_selling_response_model.dart';
import 'package:deel/features/most_selling/remote/most_selling_remote.dart';
import 'package:rxdart/rxdart.dart';

import '../../../deel.dart';
import '../models/most_selling_request_model.dart';

class MostSellingBloc extends BlocBase with ResponseHandlerModule {
  final BehaviorSubject<ApiState<List<ProductMapper>>> mostSellingBehaviour =
      BehaviorSubject()..sink.add(LoadingState());

  void getAnnouncements() {
    MostSellingRemote(
      MostSellingRequestModel(
        pageIndex: 1,
        pageSize: 10,
        sortBy: "OrderNo",
        sortDirection: "asc",
      ),
    ).callApiAsStream().listen((event) {
      mostSellingBehaviour.sink.add(event);
    });
  }

  @override
  void dispose() {}
}
