import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: 'partner_id')
  List<dynamic>? partnerId;

  @JsonKey(name: 'active')
  bool? active;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'token')
  String? token;

  @JsonKey(name: 'shop_name')
  String? shop_name;

  @JsonKey(name: 'partner_latitude')
  double? latitude;

  @JsonKey(name: 'partner_longitude')
  double? longitude;

  @JsonKey(name: 'country_phone_code')
  int? country_phone_code;

  @JsonKey(name: 'company_type_id')
  CompanyTypeId? companyTypeId;

  LoginResponse();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class CompanyTypeId {
  int? companyId;

  CompanyTypeId({this.companyId});

  CompanyTypeId.fromJson(List<dynamic> json) {
    companyId = json[0];
  }
}
