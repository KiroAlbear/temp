import 'package:deel/core/dto/models/update_app_response_model.dart';
import 'package:deel/core/dto/modules/admin_dio_module.dart';
import 'package:deel/core/dto/network/admin_client.dart';
import '../models/baseModules/api_state.dart';
import 'admin_base_remote_module.dart';

class UpdateAppRemote extends AdminBaseRemoteModule<
    List<UpdateAppResponseModel>, List<UpdateAppResponseModel>> {
  Stream<ApiState<List<UpdateAppResponseModel>>> updateApp() {
    apiFuture = AdminClient(AdminDioModule().build()).updateApp();
    return callApiAsStream();
  }

  @override
  ApiState<List<UpdateAppResponseModel>> onSuccessHandle(
      List<UpdateAppResponseModel>? response) {
    return SuccessState(response!);
  }

  @override
  Future<bool> refreshToken() async {
    return false;
  }
}
