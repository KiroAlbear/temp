import 'package:core/dto/modules/logger_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/modules/utility_module.dart';
import 'package:json_annotation/json_annotation.dart';

part 'header_request.g.dart';

@JsonSerializable(
  explicitToJson: true,
  checked: true,
  createFactory: true,
  createToJson: true,
  disallowUnrecognizedKeys: true,
  genericArgumentFactories: true,
  ignoreUnannotated: true,
  includeIfNull: true,
)
class HeaderRequest<T> {
  @JsonKey(name: 'UserID')
  String? userID;
  @JsonKey(name: 'PageNumber')
  int pageNumber = 0;
  @JsonKey(name: 'PageSize')
  int pageSize = 0;
  @JsonKey(name: 'TimeZoneOffset')
  int timeZoneOffset = 0;
  @JsonKey(name: 'RequstId')
  String? requstId;

  @JsonKey(name: 'Data')
  T? data;

  HeaderRequest(
      {this.userID,
      this.pageNumber = 1,
      this.pageSize = 10,
      this.timeZoneOffset = -1,
      this.requstId,
      this.data}) {
    LoggerModule.log(
        message: 'timeZoneOffset: $_timeZoneOffset',
        name: runtimeType.toString());
    timeZoneOffset = _timeZoneOffset;
    userID = SharedPrefModule().userId ?? '';
    requstId = UtilityModule().generateRequestId();
  }

  static int get _timeZoneOffset =>
      DateTime.now().timeZoneOffset.inMinutes -
      DateTime.now().toUtc().timeZoneOffset.inMinutes;

  factory HeaderRequest.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$HeaderRequestFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$HeaderRequestToJson(this, toJsonT);
}
