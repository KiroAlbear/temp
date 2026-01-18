// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_header_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminHeaderResponse<T> _$AdminHeaderResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => AdminHeaderResponse<T>()
  ..message = json['message'] as String?
  ..isSuccess = json['isSuccess'] as bool?
  ..error = json['errors'] as List<dynamic>?
  ..data = _$nullableGenericFromJson(json['data'], fromJsonT);

Map<String, dynamic> _$AdminHeaderResponseToJson<T>(
  AdminHeaderResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'message': instance.message,
  'isSuccess': instance.isSuccess,
  'errors': instance.error,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
