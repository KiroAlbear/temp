import 'package:json_annotation/json_annotation.dart';

part 'add_file_request.g.dart';

@JsonSerializable()
class AddFileRequest {
  @JsonKey(name: 'FileName')
  String fileName;
  @JsonKey(name: 'FileType')
  int fileType;
  @JsonKey(name: 'VoiceTextID')
  String voiceTextId;
  @JsonKey(name: 'UserID')
  String userId;
  @JsonKey(name: 'Base64')
  String base64;
  @JsonKey(name: 'AccountID')
  String? accountId;

  AddFileRequest(
      {required this.fileName,
      required this.fileType,
      this.accountId,
      this.voiceTextId = '',
      required this.userId,
      required this.base64});

  factory AddFileRequest.fromJson(Map<String, dynamic> json) =>
      _$AddFileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddFileRequestToJson(this);
}
