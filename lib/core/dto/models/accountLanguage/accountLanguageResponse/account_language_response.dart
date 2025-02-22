import 'package:json_annotation/json_annotation.dart';

part 'account_language_response.g.dart';

@JsonSerializable()
class AccountLanguageResponse {
  @JsonKey(name: 'Name')
  late final String? name;

  @JsonKey(name: 'Code')
  late final String? code;

  @JsonKey(name: 'ID')
  late final int? id;

  AccountLanguageResponse();

  factory AccountLanguageResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountLanguageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountLanguageResponseToJson(this);
}
