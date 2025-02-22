// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) =>
    SignUpRequest(
      userName: json['login'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirm_password'] as String,
      phone: json['phone'] as String,
      shopName: json['name'] as String,
      latitude: json['partner_latitude'] as String,
      longitude: json['partner_longitude'] as String,
    );

Map<String, dynamic> _$SignUpRequestToJson(SignUpRequest instance) =>
    <String, dynamic>{
      'login': instance.userName,
      'password': instance.password,
      'confirm_password': instance.confirmPassword,
      'phone': instance.phone,
      'name': instance.shopName,
      'partner_latitude': instance.latitude,
      'partner_longitude': instance.longitude,
    };
