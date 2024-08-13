import 'package:core/core.dart';

part 'favourite_request.g.dart';

@JsonSerializable()
class FavouriteRequest {
  @JsonKey(name: 'client_id')
  int? clientId;

  @JsonKey(name: 'product_id')
  int? productId;
  FavouriteRequest(this.clientId, this.productId);

  factory FavouriteRequest.fromJson(Map<String, dynamic> json) =>
      _$FavouriteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteRequestToJson(this);
}
