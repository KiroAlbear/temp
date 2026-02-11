import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogWidget extends StatefulWidget {
  final String message;
  final String? confirmMessage;
  final String? cancelMessage;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isConfirmButtonPrimary;
  final bool hasBottomPadding;


  const DialogWidget({
    super.key,
    required this.message,
    this.confirmMessage,
    this.cancelMessage,
    this.onCancel,
    this.onConfirm,
    this.isConfirmButtonPrimary = false,
    this.hasBottomPadding = false,

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

            SizedBox(height: 21.h),
            _message,
            SizedBox(height: 25.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: Column(
                children: [
                  if (widget.cancelMessage != null) ...[
                    _cancelButton,
                    SizedBox(height: 10.h),
                  ],

                  if (widget.confirmMessage != null) ...[
                    _confirmButton,
                   (widget.isConfirmButtonPrimary == false || widget.hasBottomPadding )?SizedBox(height: 28.h): SizedBox(),
                  ],
                ],
              ),
            ),

            widget.cancelMessage == null ? SizedBox(height: 28.h) : const SizedBox(),

            AppConstants.isHavingBottomPadding
                ? const SizedBox(height: 32)
                : const SizedBox(),
          ],
        ),
      ],
    ),
  );

  Widget get _message => CustomText(
    text: widget.message,
    customTextStyle: RegularStyle(color: lightBlackColor, fontSize: 14.sp),
    softWrap: true,
    maxLines: 4,
    textAlign: TextAlign.center,
  );

  Widget get _confirmButton => CustomButtonWidget(
    idleText: widget.confirmMessage,
    height: 38.h,
    textSize: 14.sp,
    buttonColor:  widget.isConfirmButtonPrimary?null:Colors.transparent,
    onTap: () {
      if (widget.onConfirm != null) {
        widget.onConfirm!();
      }
      Navigator.pop(context);
    },
  );

  Widget get _cancelButton => CustomButtonWidget(
    idleText: widget.cancelMessage ?? '',
    height: 38.h,
    validateStream: Stream.value(true),
    buttonShapeEnum: ButtonShapeEnum.flat,
    textSize: 14.sp,
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
