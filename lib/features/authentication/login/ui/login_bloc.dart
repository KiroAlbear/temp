
import 'package:deel/deel.dart';
import 'package:deel/features/more/updateProfile/remote/notifications_update_device_remote.dart';
import 'package:rxdart/rxdart.dart';

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
      return (_validatorModule.isMobileValid(
              mobileBloc.value, countryBloc.value?.mobileValidator ?? '') || _validatorModule.isMobileValid(
          mobileBloc.value, countryBloc.value?.mobilePlusValidator ?? '')) &&
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

  // Stream<ApiState<LoginMapper>> get loginWithBiometrics => LoginRemote(
  //         loginRequest: LoginRequest(
  //             password: passwordBloc.value, phone: "${mobileBloc.value}"))
  //     .callApiAsStream();

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
