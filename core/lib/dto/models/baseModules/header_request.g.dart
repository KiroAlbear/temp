// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'header_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeaderRequest<T> _$HeaderRequestFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    $checkedCreate(
      'HeaderRequest',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'UserID',
            'PageNumber',
            'PageSize',
            'TimeZoneOffset',
            'RequstId',
            'Data'
          ],
        );
        final val = HeaderRequest<T>(
          userID: $checkedConvert('UserID', (v) => v as String?),
          pageNumber: $checkedConvert('PageNumber', (v) => v as int? ?? 1),
          pageSize: $checkedConvert('PageSize', (v) => v as int? ?? 10),
          timeZoneOffset:
              $checkedConvert('TimeZoneOffset', (v) => v as int? ?? -1),
          requstId: $checkedConvert('RequstId', (v) => v as String?),
          data: $checkedConvert(
              'Data', (v) => _$nullableGenericFromJson(v, fromJsonT)),
        );
        return val;
      },
      fieldKeyMap: const {
        'userID': 'UserID',
        'pageNumber': 'PageNumber',
        'pageSize': 'PageSize',
        'timeZoneOffset': 'TimeZoneOffset',
        'requstId': 'RequstId',
        'data': 'Data'
      },
    );

Map<String, dynamic> _$HeaderRequestToJson<T>(
  HeaderRequest<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'UserID': instance.userID,
      'PageNumber': instance.pageNumber,
      'PageSize': instance.pageSize,
      'TimeZoneOffset': instance.timeZoneOffset,
      'RequstId': instance.requstId,
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
