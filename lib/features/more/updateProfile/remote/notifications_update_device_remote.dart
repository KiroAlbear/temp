import 'package:deel/core/dto/models/notifications/notification_update_device_data_request_model.dart';
import 'package:deel/core/dto/models/notifications/notification_update_device_data_response_model.dart';
import '../../../../deel.dart';

class NotificationsUpdateDeviceRemote
    extends AdminBaseRemoteModule<void, void> {
  Future<ApiState<void>> updateNotificationsDeviceData(
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
  ApiState<void> onSuccessHandle(void response) {
    return SuccessState(true);
  }

  @override
  Future<bool> refreshToken() async {
    return false;
  }
}
