import 'package:deel/core/generated/l10n.dart';
import 'package:deel/deel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../dto/enums/app_screen_enum.dart';
import 'package:flutter/material.dart';


import 'custom_text.dart';
import 'custom_text_form_filed_widget.dart';

class AppTopWidget extends StatefulWidget {
  final String homeLogo;
  final String supportIcon;
  final String notificationIcon;
  final String scanIcon;
  final String searchIcon;

  final String title;


  final String backIcon;

  final bool hideTop;

  final Stream<TextEditingController>? textFiledControllerStream;

  final ValueChanged<String>? onChanged;

  final VoidCallback? doSearch;
  final ContactUsBloc? contactUsBloc;

  final FocusNode? focusNode;

  const AppTopWidget(
      {super.key,
      required this.notificationIcon,
      required this.homeLogo,
      required this.scanIcon,
      required this.searchIcon,
      required this.supportIcon,
      this.title = '',
      this.backIcon = '',
      this.hideTop = false,
      this.doSearch,
      this.onChanged,
      this.textFiledControllerStream,
      this.contactUsBloc,
      this.focusNode});

  @override
  State<AppTopWidget> createState() => _AppTopWidgetState();
}

class _AppTopWidgetState extends State<AppTopWidget> {
  @override
  Widget build(BuildContext context) => _topStack;

  Widget get _topStack => Container(
        height: widget.hideTop ? 95.h : 150.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.w),
              bottomRight: Radius.circular(16.w)),
          color: secondaryColor,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (!widget.hideTop) ...[
              _logoWidget,
              _supportWidget,
              // _favouriteWidget,
            ],
            if (widget.title.isEmpty) ...[_searchWidget] else ...[_titleRow]
          ],
        ),
      );

  Widget get _favouriteWidget => Positioned(
      top: 18.w,
      left: 16.w,
      child: InkWell(
        onTap: () => _clickOnFavourite(),
        child: ImageHelper(
          image: widget.notificationIcon,
          imageType: ImageType.svg,
          width: 40.w,
          height: 40.h,
        ),
      ));

  Widget get _supportWidget => Positioned(
      top: 18.w,
      // left: 64.w,
      left: 16.w,
      child: InkWell(
        onTap: () => _clickOnSupport(),
        child: ImageHelper(
          image: widget.supportIcon,
          imageType: ImageType.svg,
          width: 40.w,
          height: 40.h,
        ),
      ));

  Widget get _logoWidget => Positioned(
      top: 18.h,
      right: 16.w,
      child: ImageHelper(
        image: widget.homeLogo,
        imageType: ImageType.svg,
        width: 40.w,
        height: 40.h,
      ));

  _clickOnFavourite() {
    /// TODO missing click on favourite
  }

  _clickOnSupport() {
    AlertModule().showContactUsDialog(contactUsBloc: widget.contactUsBloc!, context: context);
  }

  Widget get _searchWidget => Positioned(
        top: 72.h,
        left: 17.w,
        right: 17.w,
        child: CustomTextFormFiled(
          labelText: S.of(context).searchProduct,
          textFiledControllerStream:
              widget.textFiledControllerStream!,
          onChanged: (value) =>
              widget.onChanged!(value),
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.search,
          prefixIcon: _searchProductWidget,
          focusNode: widget.focusNode,
          suffixIcon: _scanIconWidget,
          useOnFieldSubmitted: true,
          onFieldSubmitted: (value) =>widget.doSearch!(),
        ),
      );

  Widget get _scanIconWidget => InkWell(
    onTap: () => CustomNavigatorModule.navigatorKey.currentState?.pushNamed(AppScreenEnum.scanBarcode.name),
    child: ImageHelper(
          image: widget.scanIcon,
          imageType: ImageType.svg,
          color: secondaryColor,
          width: 19.w,
          height: 19.h,
          boxFit: BoxFit.scaleDown,
        ),
  );

  Widget get _searchProductWidget => InkWell(
        onTap: () => widget.doSearch!(),
        child: ImageHelper(
          image: widget.searchIcon,
          imageType: ImageType.svg,
          color: secondaryColor,
          width: 19.w,
          height: 19.h,
          boxFit: BoxFit.scaleDown,
        ),
      );

  Widget get _titleRow => Positioned(
        top: !widget.hideTop? 72.h: 25.h,
        left: 17.w,
        right: 17.w,
        bottom: !widget.hideTop ? null: 30.h,
        child: Row(
          children: [
            if (widget.backIcon.isNotEmpty)
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ImageHelper(
                  image: widget.backIcon,
                  imageType: ImageType.svg,
                  height: 20.h,
                  width: 20.w,
                  color: whiteColor,
                ),
              ),
            SizedBox(
              width: 11.w,
            ),
            CustomText(
                text: widget.title,
                customTextStyle:
                    MediumStyle(fontSize: 26.sp, color: whiteColor)),
          ],
        ),
      );
}
