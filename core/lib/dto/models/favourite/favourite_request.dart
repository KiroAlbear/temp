import 'package:core/core.dart';
part 'favourite_request.g.dart';
@JsonSerializable()
class FavouriteRequest{

  @JsonKey(name: 'client_id')
  String? clientId;

  @JsonKey(name: 'product_id')
  String? productId;
  FavouriteRequest(this.productId, this.clientId);

  factory FavouriteRequest.fromJson(Map<String, dynamic> json) =>
      _$FavouriteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteRequestToJson(this);
}