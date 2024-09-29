import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/language_response_model.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/network/api_client.dart';

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
