// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'header_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeaderResponse<T> _$HeaderResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => $checkedCreate('HeaderResponse', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const ['status', 'message', 'isSuccess', 'errors', 'data'],
  );
  final val = HeaderResponse<T>();
  $checkedConvert('status', (v) => val.status = (v as num?)?.toInt());
  $checkedConvert('message', (v) => val.message = v as String?);
  $checkedConvert('isSuccess', (v) => val.isSuccess = v as String?);
  $checkedConvert(
    'errors',
    (v) => val.error = (v as List<dynamic>?)?.map((e) => e as String).toList(),
  );
  $checkedConvert(
    'data',
    (v) => val.data = _$nullableGenericFromJson(v, fromJsonT),
  );
  return val;
}, fieldKeyMap: const {'error': 'errors'});

Map<String, dynamic> _$HeaderResponseToJson<T>(
  HeaderResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'status': instance.status,
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
