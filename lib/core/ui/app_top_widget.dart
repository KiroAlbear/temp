import 'package:deel/deel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import 'package:flutter/material.dart';


class AppTopWidget extends StatefulWidget {
  final bool isHavingHomeLogo;
  final bool isHavingSearch;
  final bool isHavingSupport;

  final String title;
  final bool isHavingBack;
  final Stream<TextEditingController>? textFiledControllerStream;

  final ValueChanged<String>? onChanged;

  final VoidCallback? doSearch;

  final FocusNode? focusNode;

  final Function()? onBackPressed;

  const AppTopWidget({
    super.key,
    this.title = '',
    this.isHavingBack = false,
    this.isHavingHomeLogo = false,
    this.isHavingSearch = false,
    this.isHavingSupport = false,
    this.doSearch,
    this.onChanged,
    this.onBackPressed,
    this.textFiledControllerStream,
    this.focusNode,
  });

  @override
  State<AppTopWidget> createState() => _AppTopWidgetState();
}

class _AppTopWidgetState extends State<AppTopWidget> {
  @override
  Widget build(BuildContext context) => _topStack;

  Widget get _topStack => Container(
    color: whiteColor,
    padding: EdgeInsetsDirectional.only(
      start: 16.w,
      end: 16.w,
      bottom: (widget.isHavingHomeLogo == false && widget.title.trim().isEmpty)
          ? 0
          : 20.h,
    ),
    child: Column(
      children: [
        if (widget.isHavingHomeLogo) 15.verticalSpace,
        if (widget.isHavingHomeLogo) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _logoWidget,
              if (widget.isHavingSupport) ...[_supportWidget],
            ],
          ),

          // _favouriteWidget,
        ],
        17.verticalSpace,
        if (widget.isHavingSearch) ...[
          _searchWidget,
        ] else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _titleRow,
              if (widget.isHavingSupport) ...[_supportWidget],
            ],
          ),
        ],
      ],
    ),
  );

  Widget get _supportWidget => widget.isHavingSupport == false
      ? const SizedBox()
      : InkWell(
          onTap: () => _clickOnSupport(),
          child: ImageHelper(
            image: Assets.svg.icContactUs,
            imageType: ImageType.svg,
            color: secondaryColor,
            width: 24.w,
            height: 24.h,
          ),
        );

  Widget get _logoWidget => widget.isHavingHomeLogo == false
      ? const SizedBox()
      : ImageHelper(
          image: Assets.svg.logoYellow,
          imageType: ImageType.svg,
          width: 30.w,
          height: 30.h,
        );

  _clickOnSupport() {
    AlertModule().showContactUsBottomSheet(
      contactUsBloc: getIt(),
      context: context,
    );
  }

  Widget get _searchWidget => SizedBox(
    height: 50.h,
    child: CustomTextFormFiled(
      defaultTextStyle: TextStyle(fontSize: 14.sp, color: blackColor),
      textLabelColor: secondaryColor,
      labelText: Loc.of(context)!.searchProduct,
      textFiledControllerStream: widget.textFiledControllerStream!,
      onChanged: (value) => widget.onChanged!(value),
      customContentPadding: EdgeInsets.only(left: 0.w),
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.search,
      prefixIcon: _searchProductWidget,
      focusNode: widget.focusNode,
      suffixIcon: _scanIconWidget,
      useOnFieldSubmitted: true,
      // hintTextStyle: TextStyle(fontSize: 16.sp, color: secondaryColor,fontFamily: AppConstants.DINNextFont),
      onFieldSubmitted: (value) => widget.doSearch!(),
    ),
  );

  Widget get _scanIconWidget => InkWell(
    onTap: () => Routes.navigateToScreen(
      Routes.barcodePage,
      NavigationType.pushNamed,
      context,
    ),
    child: ImageHelper(
      image: Assets.svg.icScan,
      imageType: ImageType.svg,
      color: secondaryColor,
      width: 19.w,
      height: 19.h,
      boxFit: BoxFit.scaleDown,
    ),
  );

  Widget get _searchProductWidget => InkWell(
    onTap: () => widget.doSearch!(),
    child: Padding(
      padding: const EdgeInsetsDirectional.only(start: 15.0, end: 5.0),
      child: ImageHelper(
        image: Assets.svg.icSearch,
        imageType: ImageType.svg,
        boxFit: BoxFit.scaleDown,
      ),
    ),
  );

  Widget get _titleRow => Expanded(
    // color: Colors.red,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (widget.isHavingBack)
          InkWell(
            onTap:
                widget.onBackPressed ??
                () {
                  Navigator.pop(context);
                },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ImageHelper(
                image: Assets.svg.icPreviousBlue,
                imageType: ImageType.svg,
                height: 25.h,
                width: 25.w,
              ),
            ),
          ),
        SizedBox(width: 11.w),
        Expanded(
          child: CustomText(
            text: widget.title,
            textAlign: TextAlign.start,
            // softWrap: true,
            customTextStyle: BoldStyle(fontSize: 20.sp, color: secondaryColor),
          ),
        ),
      ],
    ),
  );
}
