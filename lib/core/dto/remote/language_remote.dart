import '../models/baseModules/api_state.dart';
import '../models/language_response_model.dart';
import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class LanguageRemote extends BaseRemoteModule<List<LanguageResponseModel>,
    List<LanguageResponseModel>> {
  Stream<ApiState<List<LanguageResponseModel>>> saveToCart() {
    apiFuture = ApiClient(OdooDioModule().build()).getLanguages();
    return callApiAsStream();
  }

  @override
  ApiState<List<LanguageResponseModel>> onSuccessHandle(
      List<LanguageResponseModel>? response) {
    return SuccessState(response!);
  }

  @override
  Future<bool> refreshToken() async {
    return false;
  }
}
