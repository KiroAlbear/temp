import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/deel.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordBloc extends BlocBase {
  final DropDownBloc countryBloc = DropDownBloc();
  final ValidatorModule _validatorModule = ValidatorModule();
  final ButtonBloc buttonBloc = ButtonBloc();
  final TextFormFiledBloc mobileBloc = TextFormFiledBloc();

  final TextFormFiledBloc passwordBloc = TextFormFiledBloc();
  final TextFormFiledBloc confirmPasswordBloc = TextFormFiledBloc();

  Stream<bool> get validateStream => Rx.combineLatest(
      [passwordBloc.stringStream, confirmPasswordBloc.stringStream],
      (value) => isPasswordValid);

  final BehaviorSubject<ApiState<List<DropDownMapper>>> _countryBehaviour =
      BehaviorSubject()..sink.add(LoadingState());

  ForgotPasswordBloc() {
    CountryRemote().callApiAsStream().listen(
      (event) {
        _countryBehaviour.sink.add(event);
      },
    );
  }

  void resetBloc() {
    mobileBloc.textFormFiledBehaviour.sink.add(TextEditingController());
    passwordBloc.textFormFiledBehaviour.sink.add(TextEditingController());
    confirmPasswordBloc.textFormFiledBehaviour.sink
        .add(TextEditingController());

    buttonBloc.buttonBehavior.sink.add(ButtonState.idle);
  }

  Stream<bool> get validate => Rx.combineLatest2(mobileBloc.stringStream,
      countryBloc.selectedDropDownStream, (mobile, country) => isMobileValid);

  bool get isMobileValid {
    if (countryBloc.value != null) {
      return _validatorModule.isMobileValid(
          mobileBloc.value, countryBloc.value?.customValidator ?? '');
    } else {
      return false;
    }
  }

  bool get isPasswordValid =>
      _validatorModule.isPasswordValid(passwordBloc.value) &&
      _validatorModule.isMatchValid(
          passwordBloc.value, confirmPasswordBloc.value);

  Stream<ApiState<List<DropDownMapper>>> get countryStream =>
      _countryBehaviour.stream;

  Stream<ApiState<bool>> get checkPhone =>
      CheckPhoneRemote("+${countryBloc.value!.description}${mobileBloc.value}",
              isForgetPassword: true)
          .callApiAsStream();

  Stream<ApiState<void>> get resetPassword => ResetPasswordRemote(
          phone: "+${countryBloc.value!.description}${mobileBloc.value}",
          newPassword: passwordBloc.value)
      .callApiAsStream();

  @override
  void dispose() {
    // buttonBloc.dispose();
    // mobileBloc.dispose();
    // countryBloc.dispose();
  }
}
