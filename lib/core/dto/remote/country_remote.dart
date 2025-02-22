import '../models/baseModules/api_state.dart';
import '../models/baseModules/drop_down_mapper.dart';
import '../models/country/country_response.dart';
import '../modules/constants_module.dart';
import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class CountryRemote
    extends BaseRemoteModule<List<DropDownMapper>, List<CountryResponse>> {
  @override
  ApiState<List<DropDownMapper>> onSuccessHandle(
      List<CountryResponse>? response) {
    List<DropDownMapper> list = [];
    response?.forEach(
      (element) {
        list.add(DropDownMapper(
            name: element.name ?? '',
            id: (element.id ?? 0).toString(),
            image: element.imageUrl ?? '',
            description: (element.phoneCode ??0).toString(),
        customValidator: ConstantModule.mobileRegex));
      },
    );
    return SuccessState(list);
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }

  CountryRemote() {
    apiFuture = ApiClient(OdooDioModule().build()).getCountry();
  }
}
