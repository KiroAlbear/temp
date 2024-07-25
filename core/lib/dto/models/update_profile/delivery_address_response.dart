import 'package:core/core.dart';

part 'delivery_address_response.g.dart';

@JsonSerializable()
class DeliveryAddressResponse {
  DeliveryAddressResponse();

  @JsonKey(name: 'street')
  String? street;

  @JsonKey(name: 'street2')
  String? street2;

  @JsonKey(name: 'city')
  String? city;

  @JsonKey(name: 'state')
  String? state;

  @JsonKey(name: 'zip')
  String? zip;

  @JsonKey(name: 'country')
  String? country;

  @JsonKey(name: 'partner_latitude')
  double? partner_latitude;

  @JsonKey(name: 'partner_longitude')
  double? partner_longitude;

  factory DeliveryAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$DeliveryAddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryAddressResponseToJson(this);
}
