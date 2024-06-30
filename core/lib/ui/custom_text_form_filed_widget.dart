import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/custom_theme_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

import 'custom_text.dart';

class CustomTextFormFiled extends StatefulWidget {
  final bool enableInteractiveSelection;
  final Color? borderColor;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final Widget? suffixIcon, prefixIcon;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final bool enable;
  final bool expanded;
  final bool isPassword;
  final String labelText;
  final bool isLabel;
  final bool isDense;
  final bool readOnly;
  final ValueChanged<String>? onFieldSubmitted;
  final EdgeInsets? customContentPadding;
  final int? minLines, maxLines;
  final bool hasContentPadding;
  final FocusNode? focusNode;
  final bool autoFocus;
  final List<TextInputFormatter>? inputFormatter;
  final int? maxLength;
  final bool showCounter;
  final bool enableBorder;
  final String? initialValue;
  final TextCapitalization? textCapitalization;
  final bool enableSuggestions;
  final bool useOnFieldSubmitted;
  final bool required;
  final Color? fillColor;
  final Color? textColor;
  final Color? cursorColor;
  final Color? passwordIconColor;
  final Color? textLabelColor;
  final double? radius;
  final Color? errorTextColor;
  final bool isForMobileNumberPicker;
  final Widget? customLabelText;
  final TextAlign textAlign;
  final TextStyle? defaultTextStyle;
  final Color? suffixTextColor;
  final String? suffixText;
  final Stream<TextEditingController> textFiledControllerStream;
  final ValueChanged<bool>? onFocusChange;
  final FloatingLabelBehavior? floatingLabelBehavior;

  const CustomTextFormFiled(
      {super.key,
      required this.labelText,
      required this.textFiledControllerStream,
      required this.onChanged,
      this.enableInteractiveSelection = true,
      this.onTap,
      this.errorText,
      this.prefixIcon,
      this.suffixIcon,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.enable = true,
      this.expanded = false,
      this.isPassword = false,
      this.isLabel = false,
      this.isDense = false,
      this.readOnly = false,
      this.customContentPadding,
      this.onFieldSubmitted,
      this.validator,
      this.minLines,
      this.hasContentPadding = true,
      this.focusNode,
      this.autoFocus = false,
      this.inputFormatter,
      this.borderColor,
      this.showCounter = true,
      this.maxLength,
      this.enableBorder = true,
      this.maxLines,
      this.initialValue,
      this.textCapitalization,
      this.enableSuggestions = true,
      this.useOnFieldSubmitted = false,
      this.onFocusChange,
      this.required = false,
      this.fillColor,
      this.textColor,
      this.cursorColor,
      this.radius,
      this.passwordIconColor,
      this.textLabelColor,
      this.errorTextColor,
      this.isForMobileNumberPicker = false,
      this.customLabelText,
      this.textAlign = TextAlign.start,
      this.defaultTextStyle,
      this.suffixTextColor,
      this.suffixText,
      this.floatingLabelBehavior});

  @override
  State<CustomTextFormFiled> createState() => _CustomTextFormFiledState();
}

class _CustomTextFormFiledState extends State<CustomTextFormFiled> {
  final BehaviorSubject<bool> _passwordToggleBehaviour = BehaviorSubject();
  final BehaviorSubject<bool> _isFocusedBehaviour = BehaviorSubject();
  String _textValue = '';

  @override
  void initState() {
    super.initState();
    _passwordToggleBehaviour.sink.add(true);
  }

  @override
  Widget build(BuildContext context) => _onFocusChange;

  Widget get _onFocusChange => Focus(
        child: _textEditControllerBuilder,
        onFocusChange: (value) {
          if (_textValue.isNotEmpty) {
            _isFocusedBehaviour.sink.add(true);
          } else {
            _isFocusedBehaviour.sink.add(value);
          }
          if (widget.onFocusChange != null) {
            widget.onFocusChange!(value);
          }
        },
      );

  StreamBuilder<TextEditingController> get _textEditControllerBuilder =>
      StreamBuilder(
        builder: (context, snapshot) => widget.isPassword
            ? _passwordToggleStreamBuilder(
                snapshot.data ?? TextEditingController())
            : _textFormFiled(
                controller: snapshot.data ?? TextEditingController(),
                showPassword: false),
        initialData: TextEditingController(),
        stream: widget.textFiledControllerStream,
      );

  StreamBuilder<bool> _passwordToggleStreamBuilder(
          TextEditingController controller) =>
      StreamBuilder(
        builder: (context, snapshot) => _textFormFiled(
            controller: controller, showPassword: snapshot.data ?? false),
        stream: _passwordToggleBehaviour.stream,
        initialData: false,
      );

  Widget _textFormFiled(
          {required TextEditingController controller,
          bool showPassword = false}) =>
      TextFormField(
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        style: widget.defaultTextStyle ?? _defaultTextStyle,
        textAlignVertical: TextAlignVertical.center,
        initialValue: widget.initialValue,
        textInputAction: widget.textInputAction,
        cursorColor: widget.cursorColor ?? primaryColor,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textCapitalization: widget.textCapitalization == null
            ? TextCapitalization.sentences
            : widget.textCapitalization!,
        showCursor: !widget.readOnly,
        controller: controller,
        keyboardType: widget.textInputType,
        enabled: widget.enable,

        enableInteractiveSelection: widget.enableInteractiveSelection,
        expands: widget.expanded,
        autofocus: widget.autoFocus,
        maxLength: widget.maxLength,
        inputFormatters: widget.inputFormatter,
        maxLines: widget.isPassword ? 1 : widget.maxLines,
        validator: (value) =>
            widget.validator == null ? null : widget.validator!(value),
        obscureText: showPassword,
        readOnly: widget.readOnly,
        onChanged: (value) {
          _textValue = value;
          widget.onChanged != null ? widget.onChanged!(value) : null;
        },
        minLines: widget.isPassword ? 1 : widget.minLines,
        enableSuggestions: widget.enableSuggestions,
        decoration: _inputDecoration(showPassword, controller),
        textAlign: widget.textAlign,
        cursorRadius: Radius.circular(5.r),
        cursorWidth: 2.w,
        selectionControls: CupertinoTextSelectionControls(),
        onFieldSubmitted: (value) =>
            widget.useOnFieldSubmitted ? widget.onFieldSubmitted!(value) : null,
      );

  InputDecoration _inputDecoration(bool showPassword, TextEditingController controller) => InputDecoration(
        errorStyle: _errorTextStyle,
        errorMaxLines: 4,
        contentPadding: widget.hasContentPadding
            ? widget.customContentPadding ??
                EdgeInsets.symmetric(vertical: 17.h, horizontal: 15.w)
            : null,
        errorText: widget.errorText,
        enabled: widget.enable,
        counterStyle: _counterTextStyle,
        hintStyle: _hintTextStyle,
        floatingLabelStyle: _defaultFloatingLabelStyle,
        helperStyle: _counterTextStyle,
        suffixStyle: widget.suffixText != null ? _suffixTextStyle : null,
        suffixText: widget.suffixText,
        labelStyle: widget.defaultTextStyle ?? _defaultTextStyle,
        isDense: widget.isDense,
        fillColor: widget.fillColor ?? whiteColor,
        filled: true,
        floatingLabelBehavior:
            widget.floatingLabelBehavior ?? FloatingLabelBehavior.never,
        label: widget.customLabelText ?? _labelText,
        suffixIcon: widget.isPassword ? _passwordIcon : widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        hintText: widget.isLabel ? widget.labelText : null,
        border: _getBorder(greyColor),
        disabledBorder: _getBorder(greyColor),
        enabledBorder: _getBorder(greyColor),
        errorBorder: _getBorder(Theme.of(context).colorScheme.error),
        focusedBorder: _getBorder(secondaryColor),
        focusedErrorBorder: _getBorder(widget.errorTextColor ?? redColor),
      );

  Widget get _passwordIcon => StreamBuilder<bool>(
      stream: _passwordToggleBehaviour.stream,
      initialData: false,
      builder: (context, snapshot) => InkWell(
            child: Icon(
              snapshot.data ?? false
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              // imageType: ImageType.svg,
              // boxFit: BoxFit.scaleDown,
              // scale: 0.5,
              color: greyColor,
            ),
            onTap: () => _passwordToggleBehaviour.sink
                .add(!_passwordToggleBehaviour.value),
          ));

  Widget get _labelText => StreamBuilder<bool>(
      stream: _isFocusedBehaviour.stream,
      initialData: false,
      builder: (context, snapshot) => Padding(
            padding: (snapshot.data ?? false)
                ? EdgeInsets.only(top: 5.h)
                : EdgeInsets.zero,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                    decoration: BoxDecoration(
                        color: snapshot.data ?? false
                            ? whiteColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6.sp)),
                    child: CustomText(
                      text: widget.labelText,
                      customTextStyle: MediumStyle(
                          color: widget.textLabelColor ?? greyColor,
                          fontSize: 16.sp),
                    ),
                  ),
                ),
                if (widget.required)
                  Flexible(
                    fit: FlexFit.loose,
                    child: CustomText(
                      text: ' * ',
                      customTextStyle: MediumStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 18.sp),
                    ),
                  ),
              ],
            ),
          ));

  TextStyle get _counterTextStyle =>
      MediumStyle(color: widget.textLabelColor ?? primaryColor, fontSize: 16.sp)
          .getStyle();

  TextStyle get _suffixTextStyle => MediumStyle(
          color: widget.suffixTextColor ?? greyColor, fontSize: 20.sp)
      .getStyle();

  TextStyle get _errorTextStyle =>
      MediumStyle(color: widget.errorTextColor ?? redColor, fontSize: 16.sp)
          .getStyle();

  TextStyle get _hintTextStyle =>
      MediumStyle(color: widget.textLabelColor ?? primaryColor, fontSize: 16.sp)
          .getStyle();

  TextStyle get _defaultFloatingLabelStyle => RegularStyle(
          color: widget.textLabelColor ?? primaryColor, fontSize: 16.sp)
      .getStyle();

  TextStyle get _defaultTextStyle =>
      MediumStyle(color: greyColor, fontSize: 17.sp).getStyle();

  InputBorder? _getBorder(Color color) => getOutLineBorder(color);

  InputBorder getOutLineBorder(Color color) => OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(widget.radius == null ? 6.r : widget.radius!),
      borderSide: BorderSide(
          color: widget.borderColor == null ? color : widget.borderColor!,
          width: 1.0.w));

  @override
  void dispose() {
    super.dispose();
    _passwordToggleBehaviour.close();
  }
}
