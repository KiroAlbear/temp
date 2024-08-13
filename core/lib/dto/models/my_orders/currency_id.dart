import 'package:core/Utils/AppUtils.dart';
import 'package:core/core.dart';

part 'currency_id.g.dart';

@JsonSerializable()
class CurrencyId {
  int? id;
  String? code;

  CurrencyId({this.id, this.code});

  factory CurrencyId.fromJson(Map<String, dynamic> json) =>
      _$CurrencyIdFromJson(Apputils.convertFlaseToNullJson(json));
}
