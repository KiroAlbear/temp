import 'package:core/dto/models/balance/balance_response.dart';

class BalanceMapper {
  double? balance;

  BalanceMapper(BalanceResponse response) {
    balance = response.balance;
  }
}
