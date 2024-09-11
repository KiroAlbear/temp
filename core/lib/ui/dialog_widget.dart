import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/dialog_header_widget.dart';
import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:dokkan/generated/assets.dart';
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
  final bool errorColorInConfirm;
  final bool hasCloseButton;

  const DialogWidget(
      {super.key,
      required this.message,
      required this.confirmMessage,
      this.headerSvg,
      this.headerMessage,
      this.cancelMessage,
      this.onCancel,
      this.onConfirm,
      this.hasCloseButton = false,
      this.errorColorInConfirm = false});

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) => _getContainer(child: _column);

  Widget _getContainer({required Widget child}) =>
      DialogHeaderWidget(child: child);

  Widget get _column => Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 35.h,
                ),
                if (widget.headerMessage != null) _headerMessage,
                if (widget.headerSvg != null) ...[
                  SizedBox(
                    height: 21.h,
                  ),
                  _headerSvg,
                ],
                if (widget.headerSvg != null && widget.headerMessage != null)
                  SizedBox(
                    height: 14.h,
                  ),
                _message,
                SizedBox(
                  height: 20.h,
                ),
                _confirmButton,
                if (widget.cancelMessage != null) ...[
                  SizedBox(
                    height: 17.h,
                  ),
                  _cancelButton,
                  SizedBox(
                    height: 28.h,
                  ),
                ],
                widget.cancelMessage == null
                    ? SizedBox(
                        height: 28.h,
                      )
                    : SizedBox(),
              ],
            ),
            widget.hasCloseButton
                ? Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 22.h, 5.w, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: ImageHelper(
                              image: Assets.svgIcClose,
                              imageType: ImageType.svg),
                        )
                      ],
                    ),
                  )
                : SizedBox(),
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

  Widget get _headerSvg => ImageHelper(
        image: widget.headerSvg ?? '',
        imageType: ImageType.svg,
        width: 88.w,
        height: 88.h,
        boxFit: BoxFit.contain,
      );

  Widget get _message => CustomText(
        text: widget.message,
        customTextStyle: MediumStyle(
          color: lightBlackColor,
          fontSize: 18.sp,
        ),
        softWrap: true,
        maxLines: 4,
        textAlign: TextAlign.center,
      );

/*  Widget get _rowButton => Row(
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
      );*/

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
      });

  Widget get _cancelButton => CustomButtonWidget(
      idleText: widget.cancelMessage ?? '',
      textSize: 20.sp,
      height: 38.h,
      buttonColor: greyColor,
      textColor: whiteColor,
      validateStream: Stream.value(true),
      buttonShapeEnum: ButtonShapeEnum.flat,
      onTap: () {
        if (widget.onCancel != null) {
          widget.onCancel!();
        }
        Navigator.pop(context);
      });
}
