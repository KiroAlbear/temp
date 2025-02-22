import 'package:json_annotation/json_annotation.dart';

part 'page_request.g.dart';

@JsonSerializable()
class PageRequest {
  @JsonKey(name: 'limit')
  int limit;

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'category_id')
  int? categoryId;

  @JsonKey(name: 'client_id')
  int? clientId;

  @JsonKey(name: 'main_category')
  String? main_category;

  PageRequest(this.limit, this.page, this.categoryId, this.clientId,
      {this.main_category = 'True'});

  factory PageRequest.fromJson(Map<String, dynamic> json) =>
      _$PageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PageRequestToJson(this);
}
