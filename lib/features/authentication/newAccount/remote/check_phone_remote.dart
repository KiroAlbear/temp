import 'package:deel/l10n/loc.dart';

import '../../../../core/dto/models/baseModules/api_state.dart';
import '../../../../core/dto/models/checkPhone/check_phone_request.dart';
import '../../../../core/dto/models/checkPhone/check_phone_response.dart';
import '../../../../core/dto/modules/odoo_dio_module.dart';
import '../../../../core/dto/network/api_client.dart';
import '../../../../core/dto/remote/base_remote_module.dart';
import '../../../../deel.dart';

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
          message: Loc.of(
            Routes.rootNavigatorKey.currentContext!,
          )!.mobileExistBefore,
          loggerName: runtimeType.toString(),
        );
      }
    } else {
      if (isForgetPassword) {
        return FailedState(
          message: Loc.of(
            Routes.rootNavigatorKey.currentContext!,
          )!.mobileIsNotExist,
          loggerName: runtimeType.toString(),
        );
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
    apiFuture = ApiClient(
      OdooDioModule().build(),
    ).checkPhone(CheckPhoneRequest(phone));
  }
}
