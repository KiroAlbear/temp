import 'package:json_annotation/json_annotation.dart';

part 'admin_header_request.g.dart';
@JsonSerializable()
class AdminHeaderRequest{

  @JsonKey(name: 'pageIndex')
  int pageIndex;

  @JsonKey(name: 'pageSize')
  int pageSize;
  AdminHeaderRequest({this.pageSize = 0, this.pageIndex = 0});

  factory AdminHeaderRequest.fromJson(
      Map<String, dynamic> json) =>
      _$AdminHeaderRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminHeaderRequestToJson(this);
}