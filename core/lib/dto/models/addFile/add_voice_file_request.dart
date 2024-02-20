import 'package:core/core.dart';

part 'add_voice_file_request.g.dart';

@JsonSerializable()
class AddVoiceFileRequest {
  @JsonKey(name: 'UserID')
  String userId;
  @JsonKey(name: 'FileName')
  String fileName;
  @JsonKey(name: 'VoiceTextID')
  String voiceTextId;
  @JsonKey(name: 'Base64')
  String base64;
  @JsonKey(name: 'FileType')
  int fileType;

  AddVoiceFileRequest(
      {required this.userId,
      this.fileName = 'VoiceFile',
      required this.voiceTextId,
      this.base64 = '',
      this.fileType = 2});

  factory AddVoiceFileRequest.fromJson(Map<String, dynamic> json) =>
      _$AddVoiceFileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddVoiceFileRequestToJson(this);
}
