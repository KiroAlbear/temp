import 'package:core/core.dart';
part 'balance_response.g.dart';

@JsonSerializable()
class BalanceResponse {

  @JsonKey(name: 'balance')
  double? balance;
  BalanceResponse();

  factory BalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$BalanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceResponseToJson(this);
}