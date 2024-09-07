// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usage_policy_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsagePolicyResponse _$UsagePolicyResponseFromJson(Map<String, dynamic> json) =>
    UsagePolicyResponse()
      ..id = (json['id'] as num?)?.toInt()
      ..policy = json['policy'] as String?;

Map<String, dynamic> _$UsagePolicyResponseToJson(
        UsagePolicyResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'policy': instance.policy,
    };
