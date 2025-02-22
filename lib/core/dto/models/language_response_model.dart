import 'package:json_annotation/json_annotation.dart';

part 'language_response_model.g.dart';

@JsonSerializable()
class LanguageResponseModel {
  @JsonKey(name: 'lang')
  String lang;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'code')
  String code;

  LanguageResponseModel(this.lang, this.id, this.name, this.code);

  factory LanguageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageResponseModelToJson(this);
}
