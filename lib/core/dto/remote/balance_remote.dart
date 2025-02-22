
import '../models/balance/balance_mapper.dart';
import '../models/balance/balance_response.dart';
import '../models/baseModules/api_state.dart';
import '../models/client/client_request.dart';
import '../modules/odoo_dio_module.dart';
import '../modules/shared_pref_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

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
