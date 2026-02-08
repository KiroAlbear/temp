import 'package:deel/core/dto/models/save_coordinates_request_model.dart';

import '../../../../deel.dart';

class SaveCoordinatesRemote extends AdminBaseRemoteModule<bool, void> {

  SaveCoordinatesRemote(SaveCoordinatesRequestModel requestModel) {
    apiFuture = AdminClient(AdminDioModule().build()).saveCoordinates(requestModel);
  }

  @override
  ApiState<bool> onSuccessHandle(void response) {
    return SuccessState(true);
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
