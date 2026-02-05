import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import '../../ui/bases/bloc_base.dart';
import '../modules/constants_module.dart';
import '../modules/validator_module.dart';

class PasswordValidationBloc extends BlocBase {
  final BehaviorSubject<bool> capitalCharBehaviour = BehaviorSubject()
    ..sink.add(false);
  final BehaviorSubject<bool> smallCharBehaviour = BehaviorSubject()
    ..sink.add(false);
  final BehaviorSubject<bool> numberBehaviour = BehaviorSubject()
    ..sink.add(false);
  final BehaviorSubject<bool> passwordLengthBehaviour = BehaviorSubject()
    ..sink.add(false);
  final BehaviorSubject<bool> specialCharBehaviour = BehaviorSubject()
    ..sink.add(false);
  final BehaviorSubject<bool> noSpaceBehaviour = BehaviorSubject()
    ..sink.add(false);
  final TextEditingController textEditingController;

  Stream<bool> get isAllValid => Rx.combineLatest6(
      capitalCharBehaviour,
      smallCharBehaviour,
      numberBehaviour,
      passwordLengthBehaviour,
      specialCharBehaviour,
      noSpaceBehaviour,
      (hasCapChar, hasSmallChar, hasNumber, matchPasswordLength, hasSpecialChar,
              noSpaceAllowed) =>
          // hasCapChar &&
          hasSmallChar &&
          hasNumber &&
          matchPasswordLength &&
          // hasSpecialChar &&
          noSpaceAllowed);

  PasswordValidationBloc(this.textEditingController) {
    ValidatorModule validatorModule = ValidatorModule();
    textEditingController.addListener(() {
      String value = textEditingController.text.toString();
      // _validateCapLetter(validatorModule, value);
      _validateSmallLetter(validatorModule, value);
      _validateNumberLetter(validatorModule, value);
      _validateLength(validatorModule, value);
      // _validateSpecialChar(validatorModule, value);
      _validateNoSpace(validatorModule, value);
    });
  }

  void _validateSmallLetter(ValidatorModule validatorModule, String value) {
    if (validatorModule.isCustomValid(
        value, ConstantModule.atLeastLowerCaseRegex)) {
      smallCharBehaviour.sink.add(true);
    } else {
      smallCharBehaviour.sink.add(false);
    }
  }

  void _validateNumberLetter(ValidatorModule validatorModule, String value) {
    if (validatorModule.isCustomValid(
        value, ConstantModule.atLeastNumberCaseRegex)) {
      numberBehaviour.sink.add(true);
    } else {
      numberBehaviour.sink.add(false);
    }
  }

  void _validateLength(ValidatorModule validatorModule, String value) {
    if (value.length == ConstantModule.passwordMinLength ||
        value.length > ConstantModule.passwordMinLength) {
      passwordLengthBehaviour.sink.add(true);
    } else {
      passwordLengthBehaviour.sink.add(false);
    }
  }

  void _validateNoSpace(ValidatorModule validatorModule, String value) {
    if (validatorModule.isCustomValid(value, ConstantModule.noSpaceRegex)) {
      noSpaceBehaviour.sink.add(true);
    } else {
      noSpaceBehaviour.sink.add(false);
    }
  }

  @override
  void dispose() {
    capitalCharBehaviour.close();
    smallCharBehaviour.close();
    numberBehaviour.close();
    passwordLengthBehaviour.close();
    specialCharBehaviour.close();
    noSpaceBehaviour.close();
  }
}
