import '../../../../core/dto/models/baseModules/api_state.dart';
import '../../../../core/dto/models/baseModules/drop_down_mapper.dart';
import '../../../../core/dto/models/country/country_response.dart';
import '../../../../core/dto/modules/constants_module.dart';
import '../../../../core/dto/modules/odoo_dio_module.dart';
import '../../../../core/dto/network/api_client.dart';
import '../../../../core/dto/remote/base_remote_module.dart';

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
            mobileValidator: ConstantModule.mobileRegex,
            mobilePlusValidator: ConstantModule.mobilePlusRegex,));
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
