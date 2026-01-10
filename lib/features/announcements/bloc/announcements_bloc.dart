import 'package:deel/core/dto/models/announcement/announcement_request_model.dart';
import 'package:deel/core/dto/models/announcement/announcement_response_model.dart';
import 'package:deel/core/dto/remote/announcements_remote.dart';

import '../../../deel.dart';

class AnnouncementsBloc extends BlocBase with ResponseHandlerModule {
  Stream<ApiState<List<OfferMapper>>> get announcementsStream =>
      AnnouncementsRemote().getAnnouncements(AnnouncementRequestModel(
          pageIndex: 1, pageSize: 10, sortBy: "OrderNo", sortDirection: "asc"));

  @override
  void dispose() {}
}
