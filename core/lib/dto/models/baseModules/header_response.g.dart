// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'header_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeaderResponse<T> _$HeaderResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    $checkedCreate(
      'HeaderResponse',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['Status', 'Message', 'Data'],
        );
        final val = HeaderResponse<T>();
        $checkedConvert('Status', (v) => val.status = v as bool?);
        $checkedConvert('Message', (v) => val.message = v as String?);
        $checkedConvert(
            'Data', (v) => val.data = _$nullableGenericFromJson(v, fromJsonT));
        return val;
      },
      fieldKeyMap: const {
        'status': 'Status',
        'message': 'Message',
        'data': 'Data'
      },
    );

Map<String, dynamic> _$HeaderResponseToJson<T>(
  HeaderResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'Status': instance.status,
      'Message': instance.message,
      'Data': _$nullableGenericToJson(instance.data, toJsonT),
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
