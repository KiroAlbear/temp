import 'package:deel/deel.dart';
import 'package:rxdart/rxdart.dart';

class UpdateProfileImageRemote {
  BehaviorSubject<ApiState<LoginMapper>> callApiAsStream = BehaviorSubject();
  UpdateProfileImageRemote();

  void uploadImage(File file) async {
    final url =
        '${FlavorConfig.apiUrl}app/update_image/${SharedPrefModule().userPhone}';
    final fileName = file.path.split('/').last;
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final response = await Dio().put(
      url,
      data: formData,
      options: Options(
        headers: {
          'token': '${SharedPrefModule().bearerToken}',
        },
      ),
    );
    if (response.statusCode == 200) {
      callApiAsStream.sink.add(
        SuccessState(LoginMapper(LoginResponse.fromJson(response.data))),
      );
    } else {
      callApiAsStream.sink.add(
        FailedState(
          message: 'image is not uploaded',
          loggerName: runtimeType.toString(),
        ),
      );
    }
  }

}
