import 'package:core/dto/models/balance/balance_response.dart';

class BalanceMapper {
  double? balance;

  BalanceMapper(BalanceResponse response) {
    balance = (response.balance ?? 0.0) == 0 ? 0 : -(response.balance ?? 0.0);
  }
}
