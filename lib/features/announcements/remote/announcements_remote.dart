import '../../../deel.dart';

class AnnouncementsRemote
    extends
        AdminBaseRemoteModule<List<OfferMapper>, AnnouncementResponseModel> {
  AnnouncementsRemote(AnnouncementRequestModel requestModel) {
    apiFuture = AdminClient(
      AdminDioModule().build(),
    ).getAnnouncements(requestModel);
  }

  @override
  ApiState<List<OfferMapper>> onSuccessHandle(
    AnnouncementResponseModel? response,
  ) {
    List<OfferMapper> list = [];
    response?.announcements?.forEach((element) {
      list.add(OfferMapper.fromAnnouncements(element));
    });

    return SuccessState(list);
  }

  @override
  Future<bool> refreshToken() async {
    return false;
  }
}
