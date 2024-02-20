// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_voice_file_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddVoiceFileRequest _$AddVoiceFileRequestFromJson(Map<String, dynamic> json) =>
    AddVoiceFileRequest(
      userId: json['UserID'] as String,
      fileName: json['FileName'] as String? ?? 'VoiceFile',
      voiceTextId: json['VoiceTextID'] as String,
      base64: json['Base64'] as String? ?? '',
      fileType: json['FileType'] as int? ?? 2,
    );

Map<String, dynamic> _$AddVoiceFileRequestToJson(
        AddVoiceFileRequest instance) =>
    <String, dynamic>{
      'UserID': instance.userId,
      'FileName': instance.fileName,
      'VoiceTextID': instance.voiceTextId,
      'Base64': instance.base64,
      'FileType': instance.fileType,
    };
