import 'package:core/core.dart';

part 'subcategory_request.g.dart';

@JsonSerializable()
class SubcategoryRequest {
  @JsonKey(name: 'client_id')
  int client_id;

  SubcategoryRequest(this.client_id);

  factory SubcategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryRequestToJson(this);
}
