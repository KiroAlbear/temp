import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/usage_policy/usage_policy_response.dart';
import 'package:core/dto/network/admin_client.dart';
import 'package:core/dto/remote/admin_base_remote_module.dart';

import '../modules/admin_dio_module.dart';

class UsagePolicyRemote
    extends AdminBaseRemoteModule<UsagePolicyResponse, UsagePolicyResponse> {
  UsagePolicyRemote();

  Stream<ApiState<UsagePolicyResponse>> getUsagePolicy() {
    apiFuture = AdminClient(AdminDioModule().build()).getUsagePolicy();
    return callApiAsStream();
  }

  @override
  ApiState<UsagePolicyResponse> onSuccessHandle(UsagePolicyResponse? response) {
    return SuccessState(response!, message: 'Success');
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
