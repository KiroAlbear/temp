
import 'package:deel/core/dto/models/profile/profile_response.dart';

class ProfileMapper{
  int id = 0;
  String name = '';
  String mobile = '';
  String email = '';
  String shopName = '';
  String city = '';
  String street = '';
  String district = '';
  String image = '';
  String token = '';
  int? stateId = 0;
  int? countryId = 0;
  double? latitude = 0.0;
  double? longitude = 0.0;

  ProfileMapper(ProfileResponse response){
    id = response.clientId??0;
    name = response.name??'';
    mobile = response.mobile??'';
    email = response.email??'';
    shopName = response.shopName??'';
    city = response.city??'';
    street =response.street??'';
    district = response.district??'';
    image = response.image??'';
    token = response.token??'';
    stateId = response.stateId??0;
    countryId = response.countryId??0;
    latitude = response.latitude ??0.0;
    longitude = response.longitude ??0.0;
  }
}