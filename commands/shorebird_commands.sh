// app_live
 shorebird patch android -t lib/main_app_live.dart --flavor app_live
 shorebird patch ios -t lib/main_app_live.dart

 shorebird release android -t lib/main_app_live.dart --flavor app_live --flutter-version=3.32.0
 shorebird release ios -t lib/main_app_live.dart --flutter-version=3.32.0

// app_stage
shorebird patch android -t lib/main_app_stage.dart --flavor app_stage
shorebird patch ios -t lib/main_app_stage.dart

shorebird release android -t lib/main_app_stage.dart --flavor app_stage --flutter-version=3.32.0 --artifact=apk
shorebird release ios -t lib/main_app_stage.dart --flutter-version=3.32.0
