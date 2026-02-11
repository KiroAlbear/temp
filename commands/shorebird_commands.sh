
 shorebird patch android -t lib/main_app_live.dart --flavor app_live
 shorebird patch ios -t lib/main_app_live.dart

 shorebird release android -t lib/main_app_live.dart --flavor app_live --flutter-version=3.32.0
 shorebird release ios -t lib/main_app_live.dart --flutter-version=3.32.0
