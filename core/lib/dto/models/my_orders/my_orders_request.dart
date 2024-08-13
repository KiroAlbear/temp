import 'package:core/core.dart';

part 'my_orders_request.g.dart';

@JsonSerializable()
class MyOrdersRequest {
  @JsonKey(name: 'client_id')
  String client_id;

  @JsonKey(name: 'page')
  String page;

  @JsonKey(name: 'limit')
  String limit;

  MyOrdersRequest(this.client_id, this.page, this.limit);

  factory MyOrdersRequest.fromJson(Map<String, dynamic> json) =>
      _$MyOrdersRequestFromJson(json);
}
