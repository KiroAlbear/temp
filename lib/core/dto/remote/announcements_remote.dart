import 'package:deel/core/dto/models/announcement/announcement_response_model.dart';
import '../../../deel.dart';
import '../models/announcement/announcement_request_model.dart';
import '../models/baseModules/api_state.dart';
import 'admin_base_remote_module.dart';

class AnnouncementsRemote extends AdminBaseRemoteModule<List<OfferMapper>,
    AnnouncementResponseModel> {
  Stream<ApiState<List<OfferMapper>>> getAnnouncements(
      AnnouncementRequestModel requestModel) {
    apiFuture =
        AdminClient(AdminDioModule().build()).getAnnouncements(requestModel);
    return callApiAsStream();
  }

  @override
  ApiState<List<OfferMapper>> onSuccessHandle(
      AnnouncementResponseModel? response) {
    List<OfferMapper> list = [];
    response?.announcements?.forEach(
      (element) {
        list.add(OfferMapper.fromAnnouncements(element));
      },
    );

    return SuccessState(list);
  }

  @override
  Future<bool> refreshToken() async {
    return false;
  }
}
