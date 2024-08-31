import 'package:core/core.dart';

part 'cart_check_availability_request.g.dart';

@JsonSerializable()
class CartCheckAvailabilityRequest {
  @JsonKey(name: 'client_id')
  int? client_id;

  @JsonKey(name: 'product_ids')
  List<int>? product_ids;

  CartCheckAvailabilityRequest({
    required this.client_id,
    required this.product_ids,
  });

  factory CartCheckAvailabilityRequest.fromJson(Map<String, dynamic> json) =>
      _$CartCheckAvailabilityRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartCheckAvailabilityRequestToJson(this);
}
