import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogWidget extends StatefulWidget {
  final String? headerMessage;
  final String message;
  final String confirmMessage;
  final String? cancelMessage;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool errorColorInConfirm;
  final bool hasCloseButton;
  final bool sameButtonsColor;

  const DialogWidget({
    super.key,
    required this.message,
    required this.confirmMessage,
    this.headerMessage,
    this.cancelMessage,
    this.onCancel,
    this.onConfirm,
    this.hasCloseButton = false,
    required this.sameButtonsColor,
    this.errorColorInConfirm = false,
  });

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) => _column;

  Widget get _column => Padding(
    padding: EdgeInsets.symmetric(horizontal: 17.w),
    child: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            if (widget.headerMessage != null) _headerMessage,
            SizedBox(height: 21.h),
            _message,
            SizedBox(height: 20.h),
            _confirmButton,
            if (widget.cancelMessage != null) ...[
              SizedBox(height: 17.h),
              _cancelButton,
              SizedBox(height: 28.h),
            ],
            widget.cancelMessage == null ? SizedBox(height: 28.h) : SizedBox(),

            AppConstants.isHavingBottomPadding
                ? SizedBox(height: 32)
                : SizedBox(),
          ],
        ),
      ],
    ),
  );

  Widget get _headerMessage => CustomText(
    text: widget.headerMessage ?? '',
    customTextStyle: BoldStyle(
      color: widget.errorColorInConfirm ? redColor : secondaryColor,
      fontSize: 26.sp,
    ),
    textAlign: TextAlign.center,
  );

  Widget get _message => CustomText(
    text: widget.message,
    customTextStyle: MediumStyle(color: lightBlackColor, fontSize: 18.sp),
    softWrap: true,
    maxLines: 4,
    textAlign: TextAlign.center,
  );

  Widget get _confirmButton => CustomButtonWidget(
    idleText: widget.confirmMessage,
    textSize: 20.sp,
    height: 38.h,
    buttonColor: widget.errorColorInConfirm ? redColor : primaryColor,
    textColor: widget.errorColorInConfirm ? whiteColor : lightBlackColor,
    onTap: () {
      if (widget.onConfirm != null) {
        widget.onConfirm!();
      }
      Navigator.pop(context);
    },
  );

  Widget get _cancelButton => CustomButtonWidget(
    idleText: widget.cancelMessage ?? '',
    textSize: 20.sp,
    height: 38.h,
    buttonColor: widget.sameButtonsColor ? primaryColor : greyColor,
    textColor: widget.sameButtonsColor ? lightBlackColor : whiteColor,
    validateStream: Stream.value(true),
    buttonShapeEnum: ButtonShapeEnum.flat,
    onTap: () {
      if (widget.onCancel != null) {
        widget.onCancel!();
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
    },
  );
}
