import 'package:json_annotation/json_annotation.dart';

part 'admin_header_response.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class AdminHeaderResponse<T> {

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'isSuccess')
  bool? isSuccess;

  @JsonKey(name: 'errors')
  List<dynamic>? error;

  @JsonKey(name: 'data', includeIfNull: true)
  T? data;

  AdminHeaderResponse();

  factory AdminHeaderResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$AdminHeaderResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$AdminHeaderResponseToJson(this, toJsonT);
}
