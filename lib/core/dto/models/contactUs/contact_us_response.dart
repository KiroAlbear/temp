import 'package:json_annotation/json_annotation.dart';
part 'contact_us_response.g.dart';

@JsonSerializable()
class ContactUsResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'type')
  int? type;

  @JsonKey(name: 'contact')
  String? contact;
  ContactUsResponse();

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactUsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactUsResponseToJson(this);
}
