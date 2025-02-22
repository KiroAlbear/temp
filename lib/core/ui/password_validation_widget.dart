import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

import '../dto/commonBloc/password_validation_bloc.dart';
import '../dto/modules/app_color_module.dart';
import '../dto/modules/custom_text_style_module.dart';
import '../generated/l10n.dart';
import 'custom_text.dart';

class PasswordValidationWidget extends StatefulWidget {
  final TextEditingController passwordController;
  final ValueChanged<bool>? isValid;
  final PasswordValidationBloc passwordValidationBloc;
  const PasswordValidationWidget(
      {super.key,
      required this.passwordController,
      required this.passwordValidationBloc,
      this.isValid});

  @override
  State<PasswordValidationWidget> createState() =>
      _PasswordValidationWidgetState();
}

class _PasswordValidationWidgetState extends State<PasswordValidationWidget> {
  @override
  void initState() {
    super.initState();

    widget.passwordValidationBloc.isAllValid.listen((event) {
      if (widget.isValid != null) {
        widget.isValid!(event);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _passwordType(widget.passwordValidationBloc.passwordLengthBehaviour,
              S.of(context).passwordMinimumCharacters),
          // SizedBox(
          //   height: 2.h,
          // ),
          // _passwordType(
          //     _bloc.capitalCharStream, S.of(context).atLeastOneCapChar),
          SizedBox(
            height: 2.h,
          ),
          _passwordType(widget.passwordValidationBloc.smallCharBehaviour,
              S.of(context).atLeastOneSmallLetter),
          SizedBox(
            height: 2.h,
          ),
          _passwordType(widget.passwordValidationBloc.numberBehaviour,
              S.of(context).atLeastOneNumber),
          SizedBox(
            height: 2.h,
          ),
          // _passwordType(_bloc.specialCharStream,
          //     S.of(context).AtLeastOneSpecialCharacter),
          // SizedBox(
          //   height: 2.h,
          // ),
          _passwordType(widget.passwordValidationBloc.noSpaceBehaviour,
              S.of(context).noSpaceAllowed),
        ],
      );

  Widget _passwordType(BehaviorSubject<bool> stream, String text) =>
      StreamBuilder(
        stream: stream,
        builder: (context, snapshot) => CustomText(
            text: text,
            customTextStyle: RegularStyle(
                fontSize: 12.sp,
                color: widget.passwordValidationBloc.textEditingController.value
                        .text.isEmpty
                    ? lightBlackColor
                    : (snapshot.data ?? false)
                        ? greenColor
                        : redColor)),
      );
}
