import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/generated/l10n.dart';
import 'new_account_bloc.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12.h,
          ),
          CustomText(
              text: S.of(context).fullName,
              customTextStyle:
                  MediumStyle(fontSize: 16.sp, color: darkSecondaryColor)),
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
              MediumStyle(fontSize: 16.sp, color: darkSecondaryColor)),
          SizedBox(
            height: 12.h,
          ),
          _platformNameTextFiled,
          SizedBox(
            height: 160.h,
          ),
          _button,
        ],
      );

  Widget get _fullNameTextFiled => CustomTextFormFiled(
        defaultTextStyle:
            RegularStyle(color: lightBlackColor, fontSize: 16.w).getStyle(),
        labelText: S.of(context).enterFullName,
        textFiledControllerStream:
            widget.newAccountBloc.fullNameBloc.textFormFiledStream,
        onChanged: (value) =>
            widget.newAccountBloc.fullNameBloc.updateStringBehaviour(value),
        validator: (value) =>
            ValidatorModule().emptyValidator(context).call(value),
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\u0621-\u064a-\ ]')),
          FilteringTextInputFormatter.allow(RegExp(r'^(?!\s).*$')),
        ],
        textInputAction: TextInputAction.next,
      );

  Widget get _platformNameTextFiled => CustomTextFormFiled(
        labelText: S.of(context).platformName,
        defaultTextStyle:
            RegularStyle(color: lightBlackColor, fontSize: 16.w).getStyle(),
        textFiledControllerStream:
            widget.newAccountBloc.facilityNameBloc.textFormFiledStream,
        onChanged: (value) =>
            widget.newAccountBloc.facilityNameBloc.updateStringBehaviour(value),
        validator: (value) =>
            ValidatorModule().emptyValidator(context).call(value),
        inputFormatter: [
          FilteringTextInputFormatter.allow(
              RegExp(r'[a-z0-9\A-Z\u0621-\u064a-\u0660-\u0669 ]')),
          FilteringTextInputFormatter.allow(RegExp(r'^(?!\s).*$')),
          // FilteringTextInputFormatter.allow(RegExp(r'^[\u0660-\u0669]+$')),
        ],
        textInputAction: TextInputAction.next,
      );

  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).next,
        onTap: () {
          if (widget.newAccountBloc.isInfoValid) {
            widget.newAccountBloc.nextStep(NewAccountStepEnum.locationInfo);
          }
        },
        buttonBehaviour: widget.newAccountBloc.buttonBloc.buttonBehavior,
        failedBehaviour: widget.newAccountBloc.buttonBloc.failedBehaviour,
        validateStream: widget.newAccountBloc.validateInfoStream,
      );
}
