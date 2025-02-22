import 'package:json_annotation/json_annotation.dart';
part 'faq_response.g.dart';
@JsonSerializable()
class FaqResponse{

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'question')
  String? question;

  @JsonKey(name: 'answer')
  String? answer;
  FaqResponse();

  factory FaqResponse.fromJson(Map<String, dynamic> json) =>
      _$FaqResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FaqResponseToJson(this);
}