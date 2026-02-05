import 'package:deel/core/dto/models/district/district_request.dart';

import '../models/baseModules/api_state.dart';
import '../models/baseModules/drop_down_mapper.dart';
import '../models/state/state_response.dart';
import '../modules/odoo_dio_module.dart';
import '../modules/shared_pref_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class DistrictRemote
    extends BaseRemoteModule<List<DropDownMapper>, List<StateResponse>> {
  @override
  ApiState<List<DropDownMapper>> onSuccessHandle(
    List<StateResponse>? response,
  ) {
    List<DropDownMapper> stateList = [];
    response?.forEach((element) {
      stateList.add(
        DropDownMapper(
          name: element.name ?? '',
          id: (element.id ?? 0).toString(),
        ),
      );
    });
    return SuccessState(stateList);
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }

  DistrictRemote(int stateId) {
    apiFuture = ApiClient(OdooDioModule().build()).getDistrict(
      DistrictRequest(stateId),
      SharedPrefModule().apiSelectedLanguageCode,
    );
  }
}
