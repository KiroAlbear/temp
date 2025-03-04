
import 'package:dio_builder/dio_builder.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/dto/models/baseModules/api_state.dart';

import '../../../../../core/dto/models/login/login_mapper.dart';
import '../../../../../core/dto/models/login/login_response.dart';
import '../../../../../core/dto/modules/shared_pref_module.dart';

class UpdateProfileImageRemote {
  BehaviorSubject<ApiState<LoginMapper>> callApiAsStream = BehaviorSubject();
  UpdateProfileImageRemote() {}

  void uploadImage(File file) async {
    final url =
        'https://dokkan.odoo.com/app/update_image/${SharedPrefModule().userPhone}';
    final fileName = file.path.split('/').last;
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final response = await Dio().put(url,
        data: formData,
        options: Options(headers: {
          'token': '${SharedPrefModule().bearerToken}',
          // 'Content-Type': 'multipart/form-data',
        }));
    if (response.statusCode == 200) {
      callApiAsStream.sink.add(
          SuccessState(LoginMapper(LoginResponse.fromJson(response.data))));
      // onSuccessHandle(LoginResponse.fromJson(response.data));
    } else {
      callApiAsStream.sink.add(FailedState(
          message: 'image is not uploaded',
          loggerName: runtimeType.toString()));
    }
  }

  // ApiState<LoginMapper> onSuccessHandle(LoginResponse? response) {
  //   return SuccessState(LoginMapper(response!));
  // }
}
