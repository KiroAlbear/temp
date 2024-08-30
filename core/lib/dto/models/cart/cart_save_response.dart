import 'package:core/core.dart';

part 'cart_save_response.g.dart';

@JsonSerializable()
class CartSaveResponse {
  @JsonKey(name: 'order_id')
  int? order_id;

  @JsonKey(name: 'has_promo')
  bool? has_promo;

  @JsonKey(name: 'claimed_reward_count')
  int? claimed_reward_count;

  CartSaveResponse();

  factory CartSaveResponse.fromJson(Map<String, dynamic> json) =>
      _$CartSaveResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartSaveResponseToJson(this);
}
