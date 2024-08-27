import 'package:core/Utils/AppUtils.dart';
import 'package:core/core.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: 'client_id')
  int? clientId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'mobile')
  String? mobile;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'shop_name')
  String? shopName;
  @JsonKey(name: 'country_id')
  int? countryId;
  @JsonKey(name: 'city')
  String? city;
  @JsonKey(name: 'state_id')
  int? stateId;
  @JsonKey(name: 'street')
  String? street;
  @JsonKey(name: 'district')
  String? district;
  @JsonKey(name: 'partner_longitude')
  double? longitude;
  @JsonKey(name: 'partner_latitude')
  double? latitude;
  @JsonKey(name: 'image_1920')
  String? image;

  @JsonKey(name: 'token')
  String? token;

  ProfileResponse();

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(Apputils.convertFlaseToNullJson(json));

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
