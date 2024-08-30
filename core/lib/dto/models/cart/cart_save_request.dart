import 'package:core/core.dart';

part 'cart_save_request.g.dart';

@JsonSerializable()
class CartSaveRequest {
  @JsonKey(name: 'client_id')
  int? client_id;

  @JsonKey(name: 'company_id')
  int? company_id;

  @JsonKey(name: 'apply_auto_promo')
  String? apply_auto_promo;

  @JsonKey(name: 'has_promo')
  bool? has_promo;

  @JsonKey(name: 'claimed_reward_count')
  int? claimed_reward_count;

  CartSaveRequest();

  factory CartSaveRequest.fromJson(Map<String, dynamic> json) =>
      _$CartSaveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartSaveRequestToJson(this);
}
