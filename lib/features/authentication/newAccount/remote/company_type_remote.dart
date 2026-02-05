import '../../../../deel.dart';

class CompanyTypeRemote
    extends BaseRemoteModule<List<DropDownMapper>, List<CompanyTypeResponseModel>> {
  CompanyTypeRemote() {
    apiFuture = ApiClient(OdooDioModule().build()).getCompanyType(SharedPrefModule().apiSelectedLanguageCode);
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
