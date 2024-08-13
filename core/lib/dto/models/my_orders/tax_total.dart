import 'package:core/Utils/AppUtils.dart';
import 'package:core/core.dart';

part 'tax_total.g.dart';

@JsonSerializable()
class TaxTotal {
  @JsonKey(name: 'formatted_amount_total')
  String? formattedAmountTotal;

  TaxTotal({this.formattedAmountTotal});

  factory TaxTotal.fromJson(Map<String, dynamic> json) =>
      _$TaxTotalFromJson(Apputils.convertFlaseToNullJson(json));
}
