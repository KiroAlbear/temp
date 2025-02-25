
import '../../ui/bases/bloc_base.dart';
import '../models/baseModules/drop_down_mapper.dart';

class AuthenticationSharedBloc extends BlocBase {
  late DropDownMapper? _countryMapper;
  late String? _mobile;
  late String? _nextScreen;
  late String? _userData;
  bool isOtpNavigatedFromRegistration = false;

  DropDownMapper get countryMapper => _countryMapper ?? DropDownMapper.empty();

  String get mobile => _mobile ?? '';

  String get nextScreen => _nextScreen ?? '';

  String get userDat => _userData ?? '';

  set userData(String value) => _userData = value;

  void setDataToAuth(DropDownMapper countryMapper, String mobile,
      String nextScreen) {
    _countryMapper = countryMapper;
    _mobile = mobile;
    _nextScreen = nextScreen;
  }


  @override
  void dispose() {
    // TODO: implement dispose
  }

}