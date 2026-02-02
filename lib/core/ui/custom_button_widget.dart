import 'package:custom_progress_button/custom_icon_button.dart';
import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import '../../deel.dart';
import 'custom_progress_widget.dart';

class CustomButtonWidget extends StatefulWidget {
  final BehaviorSubject<ButtonState>? buttonBehaviour;
  final BehaviorSubject<String>? failedBehaviour;
  final Stream<bool>? validateStream;
  final String? idleText;
  final VoidCallback onTap;
  final bool enableClick;
  final bool isAllCaps;
  final bool useGradient;
  final Color? buttonColor;
  final Color? idleTextColor;
  final String? loadingText;
  final double? textSize;
  final ButtonShapeEnum buttonShapeEnum;
  final Color? textColor;
  final Color? inLineBackgroundColor;
  final double? elevation;
  final double? borderRadius;
  final Color? progressColor;
  final double? height;
  final bool iconButton;
  final Widget? idleIconButton;
  final TextStyle? textStyle;
  final bool useSuccessState;
  final String? successText;
  final Color? successColor;
  final double? width;

  const CustomButtonWidget({
    super.key,
    required this.idleText,
    this.buttonBehaviour,
    this.failedBehaviour,
    required this.onTap,
    this.validateStream,
    this.isAllCaps = false,
    this.enableClick = true,
    this.useGradient = false,
    this.buttonColor,
    this.idleTextColor,
    this.loadingText,
    this.textSize,
    this.elevation = 0.0,
    this.inLineBackgroundColor,
    this.buttonShapeEnum = ButtonShapeEnum.flat,
    this.textColor,
    this.borderRadius,
    this.progressColor,
    this.height,
    this.iconButton = false,
    this.idleIconButton,
    this.textStyle,
    this.useSuccessState = false,
    this.successText,
    this.successColor,
    this.width,
  });

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.buttonBehaviour == null) {
      return widget.iconButton
          ? _iconButton(ButtonState.idle)
          : _button(ButtonState.idle);
    } else {
      return _buttonStateStream;
    }
  }

  StreamBuilder<ButtonState> get _buttonStateStream =>
      StreamBuilder<ButtonState>(
        builder: (context, snapshot) => widget.failedBehaviour == null
            ? widget.iconButton
                  ? _iconButton(snapshot.data!)
                  : _button(snapshot.data!)
            : failedStream(snapshot.data!),
        stream: widget.buttonBehaviour!,
        initialData: ButtonState.idle,
      );

  StreamBuilder<String> failedStream(ButtonState buttonState) =>
      StreamBuilder<String>(
        builder: (context, snapshot) => widget.validateStream == null
            ? widget.iconButton
                  ? _iconButton(buttonState, failedText: snapshot.data!)
                  : _button(buttonState, failedText: snapshot.data!)
            : enableButton(buttonState, snapshot.data!),
        stream: widget.failedBehaviour!.stream.asBroadcastStream(),
        initialData: Loc.of(context)!.failed,
      );

  StreamBuilder<bool> enableButton(
    ButtonState buttonState,
    String failedText,
  ) => StreamBuilder<bool>(
    builder: (context, snapshot) => widget.iconButton
        ? _iconButton(
            buttonState,
            enable: snapshot.data,
            failedText: failedText,
          )
        : _button(
            buttonState,
            enable: snapshot.data ?? false,
            failedText: failedText,
          ),
    initialData: false,
    stream: widget.validateStream!,
  );

  Widget _button(
    ButtonState buttonState, {
    String failedText = '',
    bool? enable,
  }) {
    bool isIgnoring = false;
    if (enable == null)
      isIgnoring = false;
    else
      isIgnoring = !enable;

    return IgnorePointer(
      ignoring: isIgnoring,
      child: CustomProgressButton(
        stateWidgets: {
          ButtonState.idle: _idleText(
            enable ?? true,
            idleTextColor: widget.idleTextColor,
          ),
          ButtonState.fail: _failText(failedText),
          ButtonState.loading: _loadingText,
          ButtonState.success: widget.useSuccessState
              ? successText(widget.successText)
              : _idleText(enable ?? true),
        },
        stateColors: {
          ButtonState.idle: enable ?? true
              ? (widget.buttonColor ?? primaryColor)
              : disabledButtonColorLightMode,
          ButtonState.fail: redColor,
          ButtonState.loading: widget.buttonColor ?? primaryColor,
          ButtonState.success:
              widget.successColor ?? (widget.buttonColor ?? primaryColor),
        },
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (buttonState != ButtonState.loading && (enable ?? true)) {
            widget.onTap();
          }
        },
        elevation: widget.elevation == null ? 0.r : widget.elevation!,
        progressWidget: FittedBox(
          child: CustomProgress(color: widget.progressColor ?? secondaryColor),
        ),
        progressIndicatorSize: 30.r,
        padding: EdgeInsets.zero,
        height: widget.height ?? 50.h,
        enable: widget.enableClick,
        buttonShapeEnum: widget.buttonShapeEnum,
        progressAlignment: MainAxisAlignment.center,
        minWidth: 60.w,
        maxWidth: widget.width ?? MediaQuery.of(context).size.width - 34.w,
        radius: widget.borderRadius ?? 8.0.r,
        state: buttonState,
        inLineBackgroundColor: widget.inLineBackgroundColor ?? whiteColor,
      ),
    );
  }

  Widget _iconButton(
    ButtonState buttonState, {
    String failedText = '',
    bool? enable,
  }) => CustomProgressButton.icon(
    minWidth: widget.width ?? MediaQuery.of(context).size.width / 2,
    maxWidth: widget.width ?? MediaQuery.of(context).size.width,
    iconButtons: {
      ButtonState.idle: CustomIconButton(
        icon: widget.idleIconButton,
        color: widget.buttonColor ?? primaryColor,
        text: widget.idleText,
      ),
      ButtonState.loading: CustomIconButton(
        icon: CustomProgress(color: widget.buttonColor ?? primaryColor),
        color: widget.buttonColor ?? primaryColor,
        text: widget.idleText,
      ),
      ButtonState.success: CustomIconButton(
        icon: widget.idleIconButton,
        color: widget.buttonColor ?? primaryColor,
        text: widget.idleText,
      ),
      ButtonState.fail: CustomIconButton(
        icon: widget.idleIconButton,
        color: redColor,
        text: widget.idleText,
      ),
    },
    onPressed: () {
      FocusScope.of(context).requestFocus(FocusNode());
      widget.onTap();
    },
    elevation: widget.elevation == null ? 8.r : widget.elevation!,
    progressWidget: FittedBox(
      child: CustomProgress(color: widget.progressColor ?? primaryColor),
    ),
    progressIndicatorSize: 30.r,
    height: widget.height == null ? 45.h : widget.height!,
    enable: widget.enableClick,
    buttonShapeEnum: widget.buttonShapeEnum,
    radius: widget.borderRadius ?? 8,
    state: buttonState,
    inLineBackgroundColor: widget.inLineBackgroundColor ?? whiteColor,
    textStyle: widget.textStyle ?? _textStyle,
    progressIndicatorAlignment: MainAxisAlignment.center,
    iconPadding: 4.w,
    padding: EdgeInsets.only(top: 8.h),
  );

  Widget _idleText(bool enable, {Color? idleTextColor}) => Text(
    widget.isAllCaps
        ? (widget.idleText ?? '').toUpperCase()
        : (widget.idleText ?? ''),
    style: enable
        ? widget.textStyle ?? _successTextStyle.copyWith(color: idleTextColor)
        : widget.textStyle ?? _textStyle,
  );

  Widget _failText(String text) => Text(
    widget.isAllCaps ? _failedString(text).toUpperCase() : _failedString(text),
    style: widget.textStyle ?? _textStyle,
  );

  String _failedString(String failedText) {
    if (failedText.isEmpty) return Loc.of(context)!.failed;
    return failedText;
  }

  Widget get _loadingText => Text('', style: widget.textStyle ?? _textStyle);

  String get loadingString => widget.loadingText == null
      ? Loc.of(context)!.loading
      : widget.loadingText!;

  Widget successText(String? text) => Text(
    text ??
        (widget.isAllCaps
            ? Loc.of(context)!.success.toUpperCase()
            : Loc.of(context)!.success),
    style: widget.textStyle ?? _successTextStyle,
  );

  TextStyle get _successTextStyle => MediumStyle(
    color: widget.textColor ?? secondaryColor,
    fontSize: widget.textSize == null ? 16.sp : widget.textSize!,
  ).getStyle();

  TextStyle get _textStyle => MediumStyle(
    color: widget.textColor ?? disabledButtonTextColorLightMode,
    fontSize: widget.textSize == null ? 16.sp : widget.textSize!,
  ).getStyle();
}
