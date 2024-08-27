import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/checkPhone/check_phone_request.dart';
import 'package:core/dto/models/checkPhone/check_phone_response.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/network/api_client.dart';
import 'package:core/generated/l10n.dart';

class CheckPhoneRemote
    extends BaseRemoteModule<bool, List<CheckPhoneResponse>> {
  @override
  ApiState<bool> onSuccessHandle(List<CheckPhoneResponse>? response) {
    if (response?.first.isExist ?? false) {
      return FailedState(
          message: S.current.mobileExistBefore,
          loggerName: runtimeType.toString());
    } else {
      return SuccessState(true);
    }
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }

  CheckPhoneRemote(String phone) {
    apiFuture =
        ApiClient(OdooDioModule().build()).checkPhone(CheckPhoneRequest(phone));
  }
}
