
import 'package:core/core.dart';

import 'banner_response.dart';

part 'banners_response.g.dart';

@JsonSerializable()
class BannersResponse {

  @JsonKey(name: 'count')
  int? count;

  @JsonKey(name: 'banners')
  List<BannerResponse>? bannerList;

  BannersResponse();

  factory BannersResponse.fromJson(Map<String, dynamic> json) =>
      _$BannersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BannersResponseToJson(this);
}