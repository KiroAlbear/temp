import 'package:core/core.dart';
import 'package:core/dto/commonBloc/expanded_bloc.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

class ExpandedWidget extends BaseStatefulWidget {
  final String question;
  final String answer;
  final String arrow;

  const ExpandedWidget(
      {super.key,
       required this.answer, required this.question, required this.arrow});

  @override
  State<ExpandedWidget> createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends BaseState<ExpandedWidget>
    with SingleTickerProviderStateMixin {
  final ExpandedBloc _bloc = ExpandedBloc();
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 400));

  @override
  bool canPop() => false;

  @override
  void initState() {
    super.initState();
    useCustomScaffold = true;
  }

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  Widget getBody(BuildContext context) => _blocProvider;

  @override
  bool isSafeArea() => false;

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
    color: faqCardColor,

  );

  Widget _expandedItem(bool expanded) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      _row(expanded),
      SizedBox(height: 7.h,),
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
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      _headerText(expanded),
      _arrowWidget(expanded)
    ],
  );

  Widget _headerText(bool expanded) => Expanded(
    child: AnimatedDefaultTextStyle(
      style: expanded? MediumStyle(
        color: lightBlackColor,
        fontSize: 18.sp,
      ).getStyle():
          RegularStyle(
        color: lightBlackColor,
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
      customTextStyle: RegularStyle(
          fontSize: 14.sp,
          color: lightBlackColor),
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

  ImageHelper get _arrow => ImageHelper(
    image: widget.arrow,
    imageType: ImageType.svg,
    width: 17.w,
    height: 8.h,
    boxFit: BoxFit.fill,
    color: lightBlackColor,
  );


}
