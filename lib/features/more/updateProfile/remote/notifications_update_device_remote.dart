import '../../../../deel.dart';

class NotificationsUpdateDeviceRemote
    extends AdminBaseRemoteModule<bool, void> {
  Future<ApiState<bool>> updateNotificationsDeviceData(
    String userId,
    String fcmToken,
  ) async {
    try {
      await AdminClient(AdminDioModule().build()).updateNotificationsDeviceData(
        NotificationsUpdateDeviceDataRequestModel(
          userId: userId,
          fcm: fcmToken,
          topics: [1],
        ),
      );
      return SuccessState(true);
    } catch (e) {
      return FailedState(message: e.toString(), loggerName: 'OtpRemote');
    }
  }

  @override
  ApiState<bool> onSuccessHandle(void response) {
    return SuccessState(true);
  }

  @override
  Future<bool> refreshToken() async {
    return false;
  }
}
