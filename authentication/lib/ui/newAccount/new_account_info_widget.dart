import 'package:authentication/ui/newAccount/new_account_bloc.dart';
import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:core/ui/custom_text_form_filed_widget.dart';
import 'package:flutter/material.dart';

class NewAccountInfoWidget extends StatefulWidget {
  final NewAccountBloc newAccountBloc;

  const NewAccountInfoWidget({super.key, required this.newAccountBloc});

  @override
  State<NewAccountInfoWidget> createState() => _NewAccountInfoWidgetState();
}

class _NewAccountInfoWidgetState extends State<NewAccountInfoWidget> {
  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 12.h,
          ),
          CustomText(
              text: S.of(context).fullName,
              customTextStyle:
                  RegularStyle(fontSize: 20.sp, color: secondaryColor)),
          SizedBox(
            height: 12.h,
          ),
          _fullNameTextFiled,
          SizedBox(
            height: 24.h,
          ),
          CustomText(
              text: S.of(context).platformName,
              customTextStyle:
                  RegularStyle(fontSize: 20.sp, color: secondaryColor)),
          _platformNameTextFiled,
          SizedBox(
            height: 260.h,
          ),
          _button,
        ],
      );

  Widget get _fullNameTextFiled => CustomTextFormFiled(
        labelText: S.of(context).enterFullName,
        textFiledControllerStream:
            widget.newAccountBloc.fullNameBloc.textFormFiledStream,
        onChanged: (value) =>
            widget.newAccountBloc.fullNameBloc.updateStringBehaviour(value),
        validator: (value) =>
            ValidatorModule().emailValidator(context).call(value),
        textInputType: TextInputType.text,
        textInputAction: TextInputAction.next,
      );

  Widget get _platformNameTextFiled => CustomTextFormFiled(
        labelText: S.of(context).platformName,
        textFiledControllerStream:
            widget.newAccountBloc.platformNameBloc.textFormFiledStream,
        onChanged: (value) =>
            widget.newAccountBloc.platformNameBloc.updateStringBehaviour(value),
        validator: (value) =>
            ValidatorModule().emailValidator(context).call(value),
        textInputType: TextInputType.text,
        textInputAction: TextInputAction.next,
      );

  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).next,
        onTap: () {
          if (widget.newAccountBloc.isInfoValid) {
            widget.newAccountBloc.stepBehaviour.sink
                .add(NewAccountStepEnum.location);
          }
        },
        buttonBehaviour: widget.newAccountBloc.buttonBloc.buttonBehavior,
        failedBehaviour: widget.newAccountBloc.buttonBloc.failedBehaviour,
        validateStream: widget.newAccountBloc.validateInfoStream,
      );
}
