
import '../../../../core/dto/models/balance/balance_mapper.dart';
import '../../../../core/dto/models/balance/balance_response.dart';
import '../../../../core/dto/models/baseModules/api_state.dart';
import '../../../../core/dto/models/client/client_request.dart';
import '../../../../core/dto/modules/odoo_dio_module.dart';
import '../../../../core/dto/modules/shared_pref_module.dart';
import '../../../../core/dto/network/api_client.dart';
import '../../../../core/dto/remote/base_remote_module.dart';

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
