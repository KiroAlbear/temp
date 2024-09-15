import 'package:core/Utils/AppUtils.dart';
import 'package:core/core.dart';

part 'cart_check_availability_response.g.dart';

@JsonSerializable()
class CartCheckAvailabilityResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'product')
  String? product;

  @JsonKey(name: 'available_quantity')
  int? available_quantity;

  CartCheckAvailabilityResponse({
    required this.id,
    required this.product,
    required this.available_quantity,
  });

  factory CartCheckAvailabilityResponse.fromJson(Map<String, dynamic> json) =>
      _$CartCheckAvailabilityResponseFromJson(
          Apputils.convertFlaseToNullJson(json));

  Map<String, dynamic> toJson() => _$CartCheckAvailabilityResponseToJson(this);
}
