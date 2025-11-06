import 'package:deel/core/dto/models/register/company_type_reeponse_model.dart';

import '../../../../deel.dart';

class CompanyTypeRemote
    extends BaseRemoteModule<List<DropDownMapper>, List<CompanyTypeResponseModel>> {
  CompanyTypeRemote() {
    apiFuture = ApiClient(OdooDioModule().build()).getCompanyType();
  }

  @override
  ApiState<List<DropDownMapper>> onSuccessHandle(List<CompanyTypeResponseModel>? response) {
    List<DropDownMapper> stateList = [];
    response?.forEach((element) {
      stateList.add(DropDownMapper(name: element.name??"", id: element.id.toString()));
    },);


    return SuccessState(stateList);
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
