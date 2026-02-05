import 'package:rxdart/rxdart.dart';

import '../../../deel.dart';

class AnnouncementsBloc extends BlocBase with ResponseHandlerModule {
  final BehaviorSubject<ApiState<List<OfferMapper>>> announcementsBehaviour =
      BehaviorSubject()..sink.add(LoadingState());

  void getAnnouncements() {
    AnnouncementsRemote(
      AnnouncementRequestModel(
        pageIndex: 1,
        pageSize: 10,
        sortBy: "OrderNo",
        sortDirection: "asc",
      ),
    ).callApiAsStream().listen((event) {
      announcementsBehaviour.sink.add(event);
    });
  }

  @override
  void dispose() {}
}
