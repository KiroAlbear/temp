import 'dart:io';

import 'package:deel/features/announcements/remote/announcements_remote.dart';
import 'package:deel/core/dto/remote/update_app_remote.dart';
import 'package:deel/deel.dart';
import 'package:deel/features/more/updateProfile/remote/notifications_update_device_remote.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/dto/models/update_app_response_model.dart';

class MoreBloc extends BlocBase with ResponseHandlerModule {
  final PermissionBloc cameraPermissionBloc = PermissionBloc();
  final PermissionBloc galleryPermissionBloc = PermissionBloc();
  final UpdateProfileImageRemote uploadProfileRemote =
      UpdateProfileImageRemote();
  final UpdateAppRemote updateAppRemote = UpdateAppRemote();

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
            } else if (event is FailedState) {
              showErrorDialog(Loc.of(context)!.failed, context);
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

  Future<ApiState<void>> updateNotificationsDeviceData(
      String userId, String fcmToken) {
    return NotificationsUpdateDeviceRemote()
        .updateNotificationsDeviceData(userId, fcmToken);
  }

  Future<XFile?> pickFromGallery() async {
    return await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 100);
  }

  Stream<ApiState<List<UpdateAppResponseModel>>> get checkAppUpdateStream =>
      updateAppRemote.updateApp();

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


  @override
  void dispose() {
    profileBehaviour.sink.add(IdleState());
    cameraPermissionBloc.dispose();
  }
}
