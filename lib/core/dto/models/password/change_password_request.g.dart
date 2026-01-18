// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordRequest _$ChangePasswordRequestFromJson(
  Map<String, dynamic> json,
) => ChangePasswordRequest(
  clientId: (json['client_id'] as num).toInt(),
  newPassword: json['new_passwd'] as String,
  oldPassword: json['old_passwd'] as String,
);

Map<String, dynamic> _$ChangePasswordRequestToJson(
  ChangePasswordRequest instance,
) => <String, dynamic>{
  'client_id': instance.clientId,
  'old_passwd': instance.oldPassword,
  'new_passwd': instance.newPassword,
};
