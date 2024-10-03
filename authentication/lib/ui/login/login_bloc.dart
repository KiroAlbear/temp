import 'package:core/core.dart';
import 'package:core/dto/commonBloc/button_bloc.dart';
import 'package:core/dto/commonBloc/drop_down_bloc.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/baseModules/drop_down_mapper.dart';
import 'package:core/dto/models/login/login_mapper.dart';
import 'package:core/dto/models/login/login_request.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/dto/remote/country_remote.dart';
import 'package:core/dto/remote/login_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';

class LoginBloc extends BlocBase {
  final ButtonBloc buttonBloc = ButtonBloc();
  final TextFormFiledBloc mobileBloc = TextFormFiledBloc();
  final TextFormFiledBloc passwordBloc = TextFormFiledBloc();
  final DropDownBloc countryBloc = DropDownBloc();
  final ValidatorModule _validatorModule = ValidatorModule();
  final BehaviorSubject<bool> _biometricSupportedBehaviour = BehaviorSubject()
    ..sink.add(false);

  final BehaviorSubject<ApiState<List<DropDownMapper>>> _countryBehaviour =
      BehaviorSubject()..sink.add(LoadingState());

  LoginBloc() {
    _checkBiometricSupported();
    CountryRemote().callApiAsStream().listen(
      (event) {
        _countryBehaviour.sink.add(event);
      },
    );
  }

  Stream<bool> get biometricSupportedStream =>
      _biometricSupportedBehaviour.stream;

  bool get _isLoggedBefore =>
      (SharedPrefModule().userPhone ?? '').isNotEmpty &&
      (SharedPrefModule().password ?? '').isNotEmpty;

  void _checkBiometricSupported() {
    LocalAuthModule().isSupported.then((value) =>
        _biometricSupportedBehaviour.sink.add(value && _isLoggedBefore));
  }

  Stream<bool> get validate => Rx.combineLatest3(
      mobileBloc.stringStream,
      passwordBloc.stringStream,
      countryBloc.selectedDropDownStream,
      (mobile, password, country) => isValid);

  bool get isValid {
    if (countryBloc.value != null) {
      return _validatorModule.isMobileValid(
              mobileBloc.value, countryBloc.value?.customValidator ?? '') &&
          _validatorModule.isFiledNotEmpty(passwordBloc.value);
    } else {
      return false;
    }
  }

  Stream<ApiState<List<DropDownMapper>>> get countryStream =>
      _countryBehaviour.stream;

  Stream<ApiState<LoginMapper>> get login => LoginRemote(
          loginRequest: LoginRequest(
              password: passwordBloc.value,
              phone: "+${countryBloc.value!.description}${mobileBloc.value}"))
      .callApiAsStream();

  Future<bool> authenticateWithBiometric(String message) =>
      LocalAuthModule().isAuthenticated(message);

  @override
  void dispose() {
    buttonBloc.dispose();
    mobileBloc.dispose();
    passwordBloc.dispose();
    countryBloc.dispose();
  }
}
