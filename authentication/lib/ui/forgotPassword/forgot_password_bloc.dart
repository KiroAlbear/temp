import 'package:core/core.dart';
import 'package:core/dto/commonBloc/button_bloc.dart';
import 'package:core/dto/commonBloc/drop_down_bloc.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/baseModules/drop_down_mapper.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/dto/remote/check_phone_remote.dart';
import 'package:core/dto/remote/country_remote.dart';
import 'package:core/dto/remote/reset_password_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:flutter/cupertino.dart';

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
