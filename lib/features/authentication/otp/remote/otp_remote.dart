import '../../../../core/dto/models/baseModules/api_state.dart';
import '../../../../core/dto/models/otp/send_otp_request.dart';
import '../../../../core/dto/models/otp/verify_otp_request.dart';
import '../../../../core/dto/modules/admin_dio_module.dart';
import '../../../../core/dto/network/admin_client.dart';

import '../../../../core/dto/remote/admin_base_remote_module.dart';

class OtpRemote extends AdminBaseRemoteModule<void, void> {
  Future<ApiState<void>> sendOtp(String phone, String errorMessage) async {
    try {
      await AdminClient(AdminDioModule().build())
          .sendOtp(SendOtpRequest(phone: phone));
      return SuccessState(true);
    } catch (e) {
      return ErrorState(message: errorMessage, loggerName: 'OtpRemote');
    }
  }

  Future<ApiState<void>> verifyOtp(
      String phone, String code, String errorMessage) async {
    try {
      await AdminClient(AdminDioModule().build())
          .verifyOtp(VerifyOtpRequest(phone: phone, otp: code));
      return SuccessState(true);
    } catch (e) {
      return ErrorState(message: errorMessage, loggerName: 'OtpRemote');
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
