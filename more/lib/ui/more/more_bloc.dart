import 'package:core/core.dart';
import 'package:core/dto/commonBloc/permission_bloc.dart';
import 'package:core/dto/models/balance/balance_mapper.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/profile/profile_mapper.dart';
import 'package:core/dto/modules/response_handler_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/remote/balance_remote.dart';
import 'package:core/dto/remote/deactive_profile_remote.dart';
import 'package:core/dto/remote/profile_remote.dart';
import 'package:core/dto/remote/update_profile_image_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class MoreBloc extends BlocBase with ResponseHandlerModule {
  final PermissionBloc cameraPermissionBloc = PermissionBloc();
  final PermissionBloc galleryPermissionBloc = PermissionBloc();
  final UpdateProfileImageRemote uploadProfileRemote =
      UpdateProfileImageRemote();
  final BehaviorSubject<ApiState<ProfileMapper>> profileBehaviour =
      BehaviorSubject()..sink.add(LoadingState());
  final BehaviorSubject<String> selectedFileBehaviour = BehaviorSubject()
    ..sink.add('');
  final ImagePicker _picker = ImagePicker();

  Stream<String> get selectedFileStream => selectedFileBehaviour.stream;

  void listenForFileSelection(BuildContext context) {
    selectedFileBehaviour.listen((value) {
      if (value != "") {
        uploadProfileRemote.uploadImage(File(value));
        uploadProfileRemote.callApiAsStream.listen(
          (event) {
            if (event is SuccessState) {
              selectedFileBehaviour.sink.add("");
              // getProfileData();
            } else if (event is FailedState) {
              showErrorDialog("failed", context);
              selectedFileBehaviour.sink.add('');
              print("********* Failed to upload image");
            }
          },
        );
      }
    });
  }

  void uploadImage(String filePath) {
    selectedFileBehaviour.sink.add(filePath);
  }

  Future<XFile?> takePhoto() async {
    return await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxHeight: 500,
      maxWidth: 500,
      preferredCameraDevice: CameraDevice.rear,
    );
  }

  Future<XFile?> pickFromGallery() async {
    return await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 100);
  }

  Stream<ApiState<BalanceMapper>> get balanceStream =>
      BalanceRemote().callApiAsStream();

  Stream<ApiState<void>> get deactivateAccountStream =>
      DeActiveProfileRemote().callApiAsStream();

  Stream<ApiState<ProfileMapper>> get userStream => profileBehaviour.stream;

  MoreBloc();

  void getProfileData() {
    if ((SharedPrefModule().userId ?? '').isNotEmpty) {
      ProfileRemote().callApiAsStream().listen(
        (event) {
          profileBehaviour.sink.add(event);
        },
      );
    } else {
      profileBehaviour.sink.add(IdleState());
    }
  }

  void updateProfile(String name, String shopName) {
    ProfileMapper profileMapper = profileBehaviour.valueOrNull!.response!;
    profileMapper.name = '$name-$shopName';
    profileBehaviour.sink.add(SuccessState(profileMapper));
  }

  @override
  void dispose() {
    cameraPermissionBloc.dispose();
  }
}
