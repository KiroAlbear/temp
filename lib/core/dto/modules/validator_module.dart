import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../deel.dart';
import 'constants_module.dart';

class ValidatorModule {
  /// email validation
  MultiValidator emailValidator(BuildContext? context) => MultiValidator([
    RequiredValidator(
      errorText: context == null ? "" : Loc.of(context)!.emailRequired,
    ),
    EmailValidator(
      errorText: context == null ? "" : Loc.of(context)!.inValidEmail,
    ),
  ]);

  bool isEmailValid(String? value, {BuildContext? context}) =>
      emailValidator(context).isValid(value);

  /// required filed not to be empty validation

  MultiValidator emptyValidator(BuildContext? context) => MultiValidator([
    RequiredValidator(
      errorText: context == null ? "" : Loc.of(context)!.required,
    ),
  ]);

  bool isFiledNotEmpty(String? value, {BuildContext? context}) =>
      emptyValidator(context).isValid(value);

  /// password filed validation
  MultiValidator passwordValidator(
    BuildContext? context, {
    bool showRequiredOption = true,
  }) => MultiValidator([
    RequiredValidator(
      errorText: context == null
          ? ''
          : showRequiredOption
          ? Loc.of(context)!.required
          : '',
    ),
    PatternValidator(ConstantModule.passwordRegex, errorText: ''),
  ]);

  bool isPasswordValid(String? value, {BuildContext? context}) =>
      passwordValidator(context).isValid(value);

  MultiValidator customValidator(BuildContext? context, String regex) =>
      MultiValidator([
        RequiredValidator(
          errorText: context == null ? '' : Loc.of(context)!.required,
        ),
        PatternValidator(regex, errorText: ''),
      ]);

  bool isCustomValid(String? value, String regex, {BuildContext? context}) =>
      customValidator(context, regex).isValid(value);

  /// match filed validation
  MatchValidator matchValidator(BuildContext? context) => MatchValidator(
    errorText: context == null ? "" : Loc.of(context)!.passwordNotMatched,
  );

  isMatchValid(String? value1, String? value2, {BuildContext? context}) =>
      value1 != null && value2 != null ? value1 == value2 : false;

  /// mobile validator
  MultiValidator mobileValidator(BuildContext? context, String? mobileRegex) =>
      MultiValidator([
        RequiredValidator(
          errorText: context == null ? "" : Loc.of(context)!.required,
        ),
        PatternValidator(
          mobileRegex ?? ConstantModule.mobileRegex,
          errorText: context == null ? "" : Loc.of(context)!.invalidMobile,
        ),
      ]);

  bool isMobileValid(String? value, String regex, {BuildContext? context}) =>
      mobileValidator(context, regex).isValid(value);
}
