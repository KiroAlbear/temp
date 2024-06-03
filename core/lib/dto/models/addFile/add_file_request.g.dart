// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_file_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFileRequest _$AddFileRequestFromJson(Map<String, dynamic> json) =>
    AddFileRequest(
      fileName: json['FileName'] as String,
      fileType: (json['FileType'] as num).toInt(),
      accountId: json['AccountID'] as String?,
      voiceTextId: json['VoiceTextID'] as String? ?? '',
      userId: json['UserID'] as String,
      base64: json['Base64'] as String,
    );

Map<String, dynamic> _$AddFileRequestToJson(AddFileRequest instance) =>
    <String, dynamic>{
      'FileName': instance.fileName,
      'FileType': instance.fileType,
      'VoiceTextID': instance.voiceTextId,
      'UserID': instance.userId,
      'Base64': instance.base64,
      'AccountID': instance.accountId,
    };
