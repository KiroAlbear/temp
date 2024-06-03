import 'package:core/core.dart';
part 'page_request.g.dart';
@JsonSerializable()
class PageRequest{

  @JsonKey(name: 'limit')
  int limit;

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'category_id')
  int? categoryId;

  @JsonKey(name: 'client_id')
  int? clientId;

  PageRequest(this.limit, this.page, this.categoryId, this.clientId);

  factory PageRequest.fromJson(Map<String, dynamic> json) =>
      _$PageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PageRequestToJson(this);
}