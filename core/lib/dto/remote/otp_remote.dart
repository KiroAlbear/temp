import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/admin_header_request.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/otp/send_otp_request.dart';
import 'package:core/dto/models/otp/verify_otp_request.dart';
import 'package:core/dto/models/password/reset_password_request.dart';
import 'package:core/dto/modules/admin_dio_module.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/network/admin_client.dart';
import 'package:core/dto/network/api_client.dart';
import 'package:core/dto/remote/admin_base_remote_module.dart';
import 'package:core/generated/l10n.dart';

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

  void verifyOtp(String phone, String code) {
    apiFuture = AdminClient(AdminDioModule().build())
        .verifyOtp(VerifyOtpRequest(phone: phone, otp: code));
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
