import 'package:core/core.dart';
import 'package:core/dto/models/balance/balance_mapper.dart';
import 'package:core/dto/models/balance/balance_response.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/client/client_request.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/network/api_client.dart';

class BalanceRemote
    extends BaseRemoteModule<BalanceMapper, List<BalanceResponse>> {
  BalanceRemote() {
    apiFuture = ApiClient(OdooDioModule().build()).getBalance(
        ClientRequest(int.parse((SharedPrefModule().userId ?? '0'))));
  }

  @override
  ApiState<BalanceMapper> onSuccessHandle(List<BalanceResponse>? response) {
    return SuccessState(BalanceMapper(response!.first));
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
