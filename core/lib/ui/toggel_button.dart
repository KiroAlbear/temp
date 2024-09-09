import 'package:core/core.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

import '../dto/modules/app_color_module.dart';

class ToggleButton extends StatefulWidget {
  final double width;
  final double height;

  final String leftDescription;
  final String rightDescription;

  final Color toggleColor;
  final Color toggleBackgroundColor;
  final Color toggleBorderColor;

  final Color inactiveTextColor;
  final Color activeTextColor;

  static final double leftToggleAlign = -1;
  static final double rightToggleAlign = 1;

  final VoidCallback onLeftToggleActive;
  final VoidCallback onRightToggleActive;
  final ValueNotifier<double> toggleXAlign;
  ToggleButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.toggleBackgroundColor,
      required this.toggleBorderColor,
      required this.toggleColor,
      required this.activeTextColor,
      required this.inactiveTextColor,
      required this.leftDescription,
      required this.rightDescription,
      required this.onLeftToggleActive,
      required this.toggleXAlign,
      required this.onRightToggleActive})
      : super(key: key);

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  // double _toggleXAlign = -1;

  ValueNotifier<Color> _leftDescriptionColor =
      ValueNotifier<Color>(Colors.transparent);
  ValueNotifier<Color> _rightDescriptionColor =
      ValueNotifier<Color>(Colors.transparent);

  final double borderRadious = 10;
  final Duration animatedContainerDuration = Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();

    _leftDescriptionColor.value = widget.activeTextColor;
    _rightDescriptionColor.value = widget.inactiveTextColor;
    // widget.toggleXAlign.value = ToggleButton.rightToggleAlign;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.toggleBackgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadious),
        ),
        border: Border.all(color: widget.toggleBorderColor),
      ),
      child: Stack(
        children: <Widget>[
          ValueListenableBuilder<double>(
            valueListenable: widget.toggleXAlign,
            builder: (_, double value, __) {
              return AnimatedAlign(
                alignment: Alignment(value, 2),
                duration: animatedContainerDuration,
                onEnd: () {
                  if (_leftDescriptionColor.value == widget.activeTextColor) {
                    _leftDescriptionColor.value = widget.inactiveTextColor;
                    _rightDescriptionColor.value = widget.activeTextColor;
                  } else {
                    _leftDescriptionColor.value = widget.activeTextColor;
                    _rightDescriptionColor.value = widget.inactiveTextColor;
                  }
                },
                child: Container(
                  width: widget.width * 0.5,
                  height: widget.height,
                  decoration: BoxDecoration(
                    border: Border.all(color: switchBorderColor),
                    color: widget.toggleColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(borderRadious),
                    ),
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              if (widget.toggleXAlign.value == ToggleButton.leftToggleAlign) {
                return;
              }
              widget.toggleXAlign.value = ToggleButton.rightToggleAlign;

              widget.onRightToggleActive();
            },
            child: ValueListenableBuilder<Color>(
              valueListenable: _leftDescriptionColor,
              builder: (_, Color value, __) {
                final borderColor = value == widget.activeTextColor
                    ? Colors.grey
                    : Colors.transparent;
                return Align(
                  alignment: Alignment(-1, 0),
                  child: AnimatedContainer(
                      duration: animatedContainerDuration,
                      width: widget.width * 0.5,
                      decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: borderColor),
                            bottom: BorderSide(color: borderColor),
                            left: BorderSide(color: borderColor),
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(borderRadious - 1),
                            bottomRight: Radius.circular(borderRadious - 1),
                            bottomLeft: Radius.circular(borderRadious),
                            topLeft: Radius.circular(borderRadious),
                          )),
                      alignment: Alignment.center,
                      child: CustomText(
                          text: widget.leftDescription,
                          customTextStyle: RegularStyle(color: value))),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              if (widget.toggleXAlign.value == ToggleButton.rightToggleAlign) {
                return;
              }
              widget.toggleXAlign.value = ToggleButton.leftToggleAlign;

              widget.onLeftToggleActive();
            },
            child: ValueListenableBuilder<Color>(
                valueListenable: _rightDescriptionColor,
                builder: (_, Color value, __) {
                  final borderColor = value == widget.activeTextColor
                      ? Colors.grey
                      : Colors.transparent;

                  return AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: widget.width * 0.5,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: borderColor),
                          bottom: BorderSide(color: borderColor),
                          right: BorderSide(color: borderColor),
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(borderRadious),
                          bottomRight: Radius.circular(borderRadious),
                          bottomLeft: Radius.circular(borderRadious - 1),
                          topLeft: Radius.circular(borderRadious - 1),
                        )),
                    child: CustomText(
                      text: widget.rightDescription,
                      customTextStyle:
                          RegularStyle(color: value, fontSize: 14.sp),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
