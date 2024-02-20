import 'accountLanguageResponse/account_language_response.dart';

class AccountLanguageMapper {
  late String name;
  late int id;

  AccountLanguageMapper(AccountLanguageResponse response) {
    name = response.name ?? '';
    id = response.id ?? 0;
  }
}
