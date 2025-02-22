import 'package:json_annotation/json_annotation.dart';

part 'address_request.g.dart';

@JsonSerializable()
class AddressRequest {

  @JsonKey(name: 'client_id')
  int clientId;

  @JsonKey(name: 'street')
  String street;

  @JsonKey(name: 'street2')
  String street2;

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'country_id')
  int countryId;

  @JsonKey(name: 'state_id')
  int stateId;

  @JsonKey(name: 'zip')
  String zip;

  @JsonKey(name: 'partner_latitude')
  double latitude;

  @JsonKey(name: 'partner_longitude')
  double longitude;
  AddressRequest({
    required this.clientId,
    required this.street,
    required this.street2,
    required this.city,
    required this.longitude,
    required this.latitude,
    required this.countryId,
    required this.stateId,
    required this.zip
});

  factory AddressRequest.fromJson(Map<String, dynamic> json) =>
      _$AddressRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddressRequestToJson(this);
}