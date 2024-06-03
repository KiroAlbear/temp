import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

class PasswordValidationWidget extends StatefulWidget {
  final TextEditingController passwordController;
  final ValueChanged<bool>? isValid;

  const PasswordValidationWidget(
      {super.key, required this.passwordController, this.isValid});

  @override
  State<PasswordValidationWidget> createState() =>
      _PasswordValidationWidgetState();
}

class _PasswordValidationWidgetState extends State<PasswordValidationWidget> {
  late final PasswordValidationBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PasswordValidationBloc(widget.passwordController);
    _bloc.isAllValid.listen((event) {
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
          _passwordType(_bloc.passwordLengthStream,
              S.of(context).passwordMinimumCharacters),
          SizedBox(
            height: 2.h,
          ),
          _passwordType(
              _bloc.capitalCharStream, S.of(context).atLeastOneCapChar),
          SizedBox(
            height: 2.h,
          ),
          _passwordType(
              _bloc.smallCharStream, S.of(context).atLeastOneSmallLetter),
          SizedBox(
            height: 2.h,
          ),
          _passwordType(_bloc.numberStream, S.of(context).atLeastOneNumber),
          SizedBox(
            height: 2.h,
          ),
          _passwordType(_bloc.specialCharStream,
              S.of(context).AtLeastOneSpecialCharacter),
          SizedBox(
            height: 2.h,
          ),
          _passwordType(_bloc.noSpaceStream, S.of(context).noSpaceAllowed),
        ],
      );

  Widget _passwordType(Stream<bool> stream, String text) => StreamBuilder(
        stream: stream,
        builder: (context, snapshot) => CustomText(
            text: text,
            customTextStyle: RegularStyle(
                fontSize: 10.sp,
                color: (snapshot.data ?? false) ? greenColor : redColor)),
      );
}
