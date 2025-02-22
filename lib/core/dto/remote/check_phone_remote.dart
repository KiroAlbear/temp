import '../../generated/l10n.dart';
import '../models/baseModules/api_state.dart';
import '../models/checkPhone/check_phone_request.dart';
import '../models/checkPhone/check_phone_response.dart';
import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class CheckPhoneRemote
    extends BaseRemoteModule<bool, List<CheckPhoneResponse>> {
  final bool isForgetPassword;

  @override
  ApiState<bool> onSuccessHandle(List<CheckPhoneResponse>? response) {
    if (response?.first.isExist ?? false) {
      if (isForgetPassword) {
        return SuccessState(true);
      } else {
        return FailedState(
            message: S.current.mobileExistBefore,
            loggerName: runtimeType.toString());
      }
    } else {
      if (isForgetPassword) {
        return FailedState(
            message: S.current.mobileIsNotExist,
            loggerName: runtimeType.toString());
      } else {
        return SuccessState(true);
      }
    }
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }

  CheckPhoneRemote(String phone, {this.isForgetPassword = false}) {
    apiFuture =
        ApiClient(OdooDioModule().build()).checkPhone(CheckPhoneRequest(phone));
  }
}
