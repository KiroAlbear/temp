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
  @JsonKey(name: 'Status')
  bool? status;
  @JsonKey(name: 'Message')
  String? message;
  @JsonKey(name: 'Data', includeIfNull: true)
  T? data;

  HeaderResponse();

  factory HeaderResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$HeaderResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$HeaderResponseToJson(this, toJsonT);
}
