import 'delivery_address_response.dart';

class DeliveryAddressMapper {
  late final String street;
  late final String street2;
  late final String city;
  late final String state;
  late final String country;
  late final double latitude;
  late final double longitude;

  DeliveryAddressMapper(DeliveryAddressResponse response) {
    street = response.street ?? '';
    street2 = response.street2 ?? '';
    city = response.city ?? '';
    state = response.state ?? '';
    country = response.country ?? '';
    latitude = response.partner_latitude ?? 0.0;
    longitude = response.partner_longitude ?? 0.0;
  }
}
