import 'package:json_annotation/json_annotation.dart';

part 'header_response.g.dart';

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
class HeaderResponse<T> {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'isSuccess')
  String? isSuccess;

  @JsonKey(name: 'errors')
  List<String>? error;

  @JsonKey(name: 'data', includeIfNull: true)
  T? data;

  HeaderResponse();

  factory HeaderResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$HeaderResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$HeaderResponseToJson(this, toJsonT);
}
