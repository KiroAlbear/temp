import 'package:json_annotation/json_annotation.dart';

part 'all_brands_request.g.dart';

@JsonSerializable()
class AllBrandsRequest {
  @JsonKey(name: 'page')
  int page;
  @JsonKey(name: 'limit')
  int limit;
  AllBrandsRequest(
    this.page,
    this.limit,
  );

  factory AllBrandsRequest.fromJson(Map<String, dynamic> json) =>
      _$AllBrandsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AllBrandsRequestToJson(this);
}
