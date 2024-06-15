// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_header_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminHeaderResponse<T> _$AdminHeaderResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    $checkedCreate(
      'AdminHeaderResponse',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['message', 'isSuccess', 'data'],
        );
        final val = AdminHeaderResponse<T>();
        $checkedConvert('message', (v) => val.message = v as String?);
        $checkedConvert('isSuccess', (v) => val.isSuccess = v as String?);
        $checkedConvert(
            'data', (v) => val.data = _$nullableGenericFromJson(v, fromJsonT));
        return val;
      },
    );

Map<String, dynamic> _$AdminHeaderResponseToJson<T>(
  AdminHeaderResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'message': instance.message,
      'isSuccess': instance.isSuccess,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
