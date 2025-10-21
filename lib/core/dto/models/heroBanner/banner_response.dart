import 'package:json_annotation/json_annotation.dart';

part 'banner_response.g.dart';

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'imagePath')
  String? imagePath;

  @JsonKey(name: 'link')
  String? link;

  @JsonKey(name: 'relatedItemId')
  List<int>? relatedItemId;
  BannerResponse();

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}
