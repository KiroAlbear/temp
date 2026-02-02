import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../dto/commonBloc/expanded_bloc.dart';
import '../dto/modules/app_color_module.dart';
import '../dto/modules/custom_text_style_module.dart';
import 'bases/base_state.dart';
import 'bases/bloc_base.dart';
import 'custom_text.dart';

class ExpandedWidget extends StatefulWidget {
  final String question;
  final String answer;

  const ExpandedWidget(
      {super.key,
      required this.answer,
      required this.question});

  @override
  State<ExpandedWidget> createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends State<ExpandedWidget>
    with SingleTickerProviderStateMixin {
  final ExpandedBloc _bloc = ExpandedBloc();
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 400));

  // @override
  // bool canPop() => true;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   useCustomScaffold = true;
  // }

  // @override
  // PreferredSizeWidget? appBar() => null;

  @override
  Widget build(BuildContext context) => _blocProvider;

  // @override
  // bool isSafeArea() => false;

  BlocProvider get _blocProvider =>
      BlocProvider(bloc: _bloc, child: _expandedWidget);

  StreamBuilder<bool> get _expandedWidget => StreamBuilder(
        stream: _bloc.expandedStream,
        builder: (context, snapshot) {
          (snapshot.data ?? false)
              ? _animationController.forward()
              : _animationController.reverse();
          return InkWell(
            onTap: () => _bloc.expanded = !_bloc.expanded,
            child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: _animationController.duration!,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              decoration: _boxDecoration,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 30.h),
                child: _expandedItem(snapshot.data ?? false),
              ),
            ),
          );
        },
        initialData: false,
      );

  BoxDecoration get _boxDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: productCardColor,
      );

  Widget _expandedItem(bool expanded) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _row(expanded),
          SizedBox(
            height: 7.h,
          ),
          _childExpandedWidget(expanded)
        ],
      );

  Widget _childExpandedWidget(bool expanded) => AnimatedCrossFade(
        firstChild: _childText(expanded),
        secondChild: Container(
          height: 0,
        ),
        crossFadeState:
            expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: _animationController.duration!,
        sizeCurve: Curves.fastOutSlowIn,
        firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      );

  Widget _row(bool expanded) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _headerText(expanded),
          SizedBox(
            width: 5,
          ),
          _arrowWidget(expanded)
        ],
      );

  Widget _headerText(bool expanded) => Expanded(
        child: AnimatedDefaultTextStyle(
          style: MediumStyle(
            color: secondaryColor,
            fontSize: 18.sp,
          ).getStyle(),
          duration: _animationController.duration!,
          child: Text(widget.question),
        ),
      );

  Widget _childText(bool expanded) => AnimatedContainer(
        duration: _animationController.duration!,
        child: CustomText(
          text: widget.answer,
          customTextStyle:
              RegularStyle(fontSize: 14.sp, color: lightBlackColor),
          maxLines: 100,
          softWrap: true,
        ),
      );

  Widget _arrowWidget(bool expanded) => AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Transform.rotate(
          angle: _animationController.value * 1 * 3.14159265,
          child: _arrow,
        ),
      );

  Widget get _arrow => Padding(
        padding: EdgeInsets.only(top: 7.h),
        child: ImageHelper(
          image: Assets.svg.icArrowDownBlue,
          imageType: ImageType.svg,
          width: 17.w,
          height: 8.h,
          boxFit: BoxFit.contain,
          imageShape: ImageShape.rectangle,
        ),
      );
}
