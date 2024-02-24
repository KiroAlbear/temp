import 'package:core/core.dart';
import 'package:core/dto/commonBloc/button_bloc.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/ui/bases/bloc_base.dart';

class ChangePasswordBloc extends BlocBase {
  final TextFormFiledBloc passwordBloc = TextFormFiledBloc();
  final TextFormFiledBloc confirmPasswordBloc = TextFormFiledBloc();
  final ButtonBloc buttonBloc = ButtonBloc();

  final ValidatorModule _validatorModule = ValidatorModule();

  Stream<bool> get validate => Rx.combineLatest2(passwordBloc.stringStream,
      confirmPasswordBloc.stringStream, (password, confirmPassword) => isValid);

  bool get isValid =>
      _validatorModule.isPasswordValid(passwordBloc.value) &&
      _validatorModule.isMatchValid(
          passwordBloc.value, confirmPasswordBloc.value);

  @override
  void dispose() {
    passwordBloc.dispose();
    confirmPasswordBloc.dispose();
    buttonBloc.dispose();
  }
}
