import 'package:core/dto/modules/permission_module.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionBloc extends BlocBase {
  // An instance of PermissionModule for handling permissions.
  PermissionModule easyPermissionHandler = PermissionModule();

  // A flag to track whether app settings are open.
  bool isOpenSettings = false;

  // Method to listen for changes in app settings being open.
  void listenFormOpenSettings() {
    easyPermissionHandler.isSettingsOpenStream.listen((event) {
      isOpenSettings = event;
    });
  }

  // Method to request a permission.
  Future<void> requestPermission(BuildContext context, Permission permission,
      {String? messageOnDenied, String? messageBeforeRequest}) async {
    await easyPermissionHandler.handlePermission(
      permission: permission,
      isRequired: true,
      context: context,
      messageBeforeRequestPermission: messageBeforeRequest,
      messageOnPermissionDeniedForever: messageOnDenied,
    );
  }

  // Method to handle app resuming for permission checks.
  void handleOnResumedForPermission() {
    easyPermissionHandler.handleOnResumed();
  }

  @override
  void dispose() {
    // Dispose of the PermissionModule when the bloc is disposed to release resources.
    easyPermissionHandler.dispose();
  }
}
