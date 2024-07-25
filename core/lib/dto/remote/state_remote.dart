import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/baseModules/drop_down_mapper.dart';
import 'package:core/dto/models/state/state_request.dart';
import 'package:core/dto/models/state/state_response.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/network/api_client.dart';

class StateRemote
    extends BaseRemoteModule<List<DropDownMapper>, List<StateResponse>> {
  @override
  ApiState<List<DropDownMapper>> onSuccessHandle(
      List<StateResponse>? response) {
    List<DropDownMapper> stateList = [];
    response?.forEach(
      (element) {
        stateList.add(DropDownMapper(
            name: element.name ?? '', id: (element.id ?? 0).toString()));
      },
    );
    return SuccessState(stateList);
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }

  StateRemote(int countryId) {
    apiFuture =
        ApiClient(OdooDioModule().build()).getState(StateRequest(countryId));
  }
}
