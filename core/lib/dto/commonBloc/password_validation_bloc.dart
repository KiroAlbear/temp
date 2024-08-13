import 'package:core/core.dart';
import 'package:core/dto/modules/constants_module.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:flutter/cupertino.dart';

class PasswordValidationBloc extends BlocBase {
  final BehaviorSubject<bool> _capitalCharBehaviour = BehaviorSubject()
    ..sink.add(false);
  final BehaviorSubject<bool> _smallCharBehaviour = BehaviorSubject()
    ..sink.add(false);
  final BehaviorSubject<bool> _numberBehaviour = BehaviorSubject()
    ..sink.add(false);
  final BehaviorSubject<bool> _passwordLengthBehaviour = BehaviorSubject()
    ..sink.add(false);
  final BehaviorSubject<bool> _specialCharBehaviour = BehaviorSubject()
    ..sink.add(false);
  final BehaviorSubject<bool> _noSpaceBehaviour = BehaviorSubject()
    ..sink.add(false);
  final TextEditingController textEditingController;

  Stream<bool> get capitalCharStream => _capitalCharBehaviour.stream;

  Stream<bool> get smallCharStream => _smallCharBehaviour.stream;

  Stream<bool> get numberStream => _numberBehaviour.stream;

  Stream<bool> get passwordLengthStream => _passwordLengthBehaviour.stream;

  Stream<bool> get specialCharStream => _specialCharBehaviour.stream;

  Stream<bool> get noSpaceStream => _noSpaceBehaviour.stream;

  Stream<bool> get isAllValid => Rx.combineLatest6(
      capitalCharStream,
      smallCharStream,
      numberStream,
      passwordLengthStream,
      specialCharStream,
      noSpaceStream,
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

  void _validateCapLetter(ValidatorModule validatorModule, String value) {
    if (validatorModule.isCustomValid(
        value, ConstantModule.atLeastUpperCaseRegex)) {
      _capitalCharBehaviour.sink.add(true);
    } else {
      _capitalCharBehaviour.sink.add(false);
    }
  }

  void _validateSmallLetter(ValidatorModule validatorModule, String value) {
    if (validatorModule.isCustomValid(
        value, ConstantModule.atLeastLowerCaseRegex)) {
      _smallCharBehaviour.sink.add(true);
    } else {
      _smallCharBehaviour.sink.add(false);
    }
  }

  void _validateNumberLetter(ValidatorModule validatorModule, String value) {
    if (validatorModule.isCustomValid(
        value, ConstantModule.atLeastNumberCaseRegex)) {
      _numberBehaviour.sink.add(true);
    } else {
      _numberBehaviour.sink.add(false);
    }
  }

  void _validateLength(ValidatorModule validatorModule, String value) {
    if (value.length == ConstantModule.passwordMinLength ||
        value.length > ConstantModule.passwordMinLength) {
      _passwordLengthBehaviour.sink.add(true);
    } else {
      _passwordLengthBehaviour.sink.add(false);
    }
  }

  void _validateSpecialChar(ValidatorModule validatorModule, String value) {
    if (validatorModule.isCustomValid(
        value, ConstantModule.atLeastSpecialCharacter)) {
      _specialCharBehaviour.sink.add(true);
    } else {
      _specialCharBehaviour.sink.add(false);
    }
  }

  void _validateNoSpace(ValidatorModule validatorModule, String value) {
    if (validatorModule.isCustomValid(value, ConstantModule.noSpaceRegex)) {
      _noSpaceBehaviour.sink.add(true);
    } else {
      _noSpaceBehaviour.sink.add(false);
    }
  }

  @override
  void dispose() {
    _capitalCharBehaviour.close();
    _smallCharBehaviour.close();
    _numberBehaviour.close();
    _passwordLengthBehaviour.close();
    _specialCharBehaviour.close();
    _noSpaceBehaviour.close();
  }
}
