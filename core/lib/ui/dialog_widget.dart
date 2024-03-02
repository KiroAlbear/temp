import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import 'custom_text.dart';

class DialogWidget extends StatefulWidget {
  final String? headerSvg;
  final String? headerMessage;
  final String message;
  final String confirmMessage;
  final String? cancelMessage;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const DialogWidget(
      {super.key,
      required this.message,
      required this.confirmMessage,
      this.headerSvg,
      this.headerMessage,
      this.cancelMessage,
      this.onCancel,
      this.onConfirm});

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) => _getContainer(child: _column);

  Widget _getContainer({required Widget child}) => OverflowBox(
        minWidth: MediaQuery.of(context).size.width - 40.w,
        minHeight: MediaQuery.of(context).size.height * 0.1,
        maxHeight: MediaQuery.of(context).size.height * 0.3,
        maxWidth: MediaQuery.of(context).size.width - 40.w,
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                    color: greyColor,
                    blurRadius: 10,
                    spreadRadius: 10,
                    offset: const Offset(0, 5))
              ],
              color: Theme.of(context).scaffoldBackgroundColor),
          child: child,
        ),
      );

  Widget get _column => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.headerMessage != null) _headerMessage,
          if (widget.headerSvg != null && widget.headerMessage == null)
            _headerSvg,
          if (widget.headerSvg != null && widget.headerMessage == null)
          SizedBox(
            height: 10.h,
          ),
          _message,
          SizedBox(
            height: 15.h,
          ),
          _rowButton,
        ],
      );

  Widget get _headerMessage => CustomText(
      text: widget.headerMessage ?? '',
      customTextStyle: BoldStyle(
        color: secondaryColor,
        fontSize: 24.sp,
      ));

  Widget get _headerSvg => ImageHelper(
        image: widget.headerSvg ?? '',
        imageType: ImageType.svg,
        width: 30.w,
        height: 30.h,
        boxFit: BoxFit.contain,
      );

  Widget get _message => CustomText(
      text: widget.message,
      customTextStyle: MediumStyle(
        color: greyColor,
        fontSize: 20.sp,
      ),softWrap: true,maxLines: 4, textAlign: TextAlign.center,);

  Widget get _rowButton => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.cancelMessage == null)
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: _confirmButton),
          if (widget.cancelMessage != null) _confirmButton,
          if (widget.cancelMessage != null)
            SizedBox(
              width: 10.w,
            ),
          if (widget.cancelMessage != null) _cancelButton,
        ],
      );

  Widget get _confirmButton => Expanded(
    child: CustomButtonWidget(
        idleText: widget.confirmMessage,
        textSize: 16.sp,
        height: 40.h,
        onTap: () {
          if (widget.onConfirm != null) {
            widget.onConfirm!();
          }
          Navigator.pop(context);
        }),
  );

  Widget get _cancelButton => Expanded(
    child: CustomButtonWidget(
        idleText: widget.cancelMessage ?? '',
        textSize: 16.sp,
        height: 40.h,
        buttonColor: secondaryColor,
        inLineBackgroundColor: whiteColor,
        textColor: secondaryColor,
        buttonShapeEnum: ButtonShapeEnum.outline,
        onTap: () {
          if (widget.onCancel != null) {
            widget.onCancel!();
          }
          Navigator.pop(context);
        }),
  );
}
