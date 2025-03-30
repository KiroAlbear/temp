import 'package:deel/deel.dart';
import 'package:deel/features/more/accountChangePassword/remote/change_password_remote.dart';
import 'package:rxdart/rxdart.dart';

class AccountChangePasswordBloc extends BlocBase{
  final TextFormFiledBloc currentPasswordBloc = TextFormFiledBloc();
  final TextFormFiledBloc passwordBloc = TextFormFiledBloc();
  final TextFormFiledBloc confirmPasswordBloc = TextFormFiledBloc();
  final ButtonBloc buttonBloc = ButtonBloc();
  final ValidatorModule _validatorModule = ValidatorModule();


  Stream<bool> get validateStream => Rx.combineLatest([
    currentPasswordBloc.stringStream,
    passwordBloc.stringStream,
    confirmPasswordBloc.stringStream
  ], (value) => isValid);

  bool get isValid =>
      _validatorModule.isFiledNotEmpty(currentPasswordBloc.value) &&
          _validatorModule.isPasswordValid(passwordBloc.value) &&
          _validatorModule.isMatchValid(
              passwordBloc.value, confirmPasswordBloc.value);

  Stream<ApiState<void>> get changePassword=> ChangePasswordRemote(
    newPassword: passwordBloc.value,
    oldPassword: currentPasswordBloc.value
  ).callApiAsStream();

  @override
  void dispose() {
    passwordBloc.dispose();
    confirmPasswordBloc.dispose();
    buttonBloc.dispose();
    currentPasswordBloc.dispose();
  }

}