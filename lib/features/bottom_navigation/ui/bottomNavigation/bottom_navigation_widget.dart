import 'package:deel/deel.dart';
import 'package:deel/features/cart/ui/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../core/generated/l10n.dart';
import 'bottom_navigation_bloc.dart';

class BottomNavigationWidget extends BaseStatefulWidget {
  final List<String> svgIconsPath;
  final BottomNavigationBloc bottomNavigationBloc;
  final CartBloc cartBloc;

  const BottomNavigationWidget(
      {super.key,
      required this.cartBloc,
      required this.svgIconsPath,
      required this.bottomNavigationBloc});

  @override
  State<BottomNavigationWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends BaseState<BottomNavigationWidget> {
  late List<BottomNavigationBarItem> _items;
  int cartCounter = 0;
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool isSafeArea() => true;

  @override
  Color? systemNavigationBarColor() => secondaryColor;

  @override
  Widget getBody(BuildContext context) => StreamBuilder(
        stream: widget.bottomNavigationBloc.selectedTabStream,
        builder: (context, snapshot) {
          // if((snapshot.data == 1 || snapshot.data == 3) && (SharedPrefModule().userId??'').isEmpty){
          //   return widget.homeBloc.loginWidget;
          // }else{
          //  return widget.homeBloc.widgetList[snapshot.data ?? 0];
          // }
          return widget.bottomNavigationBloc.widgetList[snapshot.data ?? 0];
        },
        initialData: 0,
      );

  @override
  Widget? customBottomNavBar() => StreamBuilder(
        stream: widget.bottomNavigationBloc.selectedTabStream,
        builder: (context, snapshot) {
          _initBottomNavItems(snapshot.data ?? 0);
          return Container(
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.w),
                  topRight: Radius.circular(20.w)),
            ),
            child: BottomNavigationBar(
                items: _items,
                backgroundColor: secondaryColor.withOpacity(0.01),
                currentIndex: snapshot.data ?? 0,
                landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                onTap: (value) {
                  widget.bottomNavigationBloc.setSelectedTab(value, context);
                },
                iconSize: 20.r),
          );
        },
        initialData: 0,
      );

  BottomNavigationBarItem _homeBottomNavigationBarItem(int selectedIndex) =>
      _getBottomNavBarItem(
          widget.svgIconsPath[0], S.of(context).home, selectedIndex, 0);

  BottomNavigationBarItem _searchBottomNavigationBarItem(int selectedIndex) =>
      _getBottomNavBarItem(
          widget.svgIconsPath[1], S.of(context).favourite, selectedIndex, 1);

  BottomNavigationBarItem _promotionBottomNavigationBarItem(
          int selectedIndex) =>
      _getBottomNavBarItem(
          widget.svgIconsPath[2], S.of(context).promotion, selectedIndex, 2);

  BottomNavigationBarItem _basketBottomNavigationBarItem(int selectedIndex) =>
      _getBottomNavBarItem(
          widget.svgIconsPath[3], S.of(context).basket, selectedIndex, 3);

  BottomNavigationBarItem _moreBottomNavigationBarItem(int selectedIndex) =>
      _getBottomNavBarItem(
          widget.svgIconsPath[4], S.of(context).more, selectedIndex, 4);

  BottomNavigationBarItem _getBottomNavBarItem(
          String svgPath, String name, int selectedIndex, int tabIndex) =>
      BottomNavigationBarItem(
          activeIcon:
              _itemIcon(svgPath, selectedIndex, tabIndex, name, tabIndex == 3),
          icon:
              _itemIcon(svgPath, selectedIndex, tabIndex, name, tabIndex == 3),
          label: name);

  Widget _itemIcon(String svgPath, int selectedIndex, int tabIndex, String name,
      bool showBadge) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _imageIcon(svgPath, selectedIndex, tabIndex),
            SizedBox(
              height: 4.h,
            ),
            _label(name, selectedIndex, tabIndex),
            // CustomText(
            //     text: name,
            //     customTextStyle:
            //         RegularStyle(color: primaryColor, fontSize: 9.sp))
          ],
        ),
        StreamBuilder(
          stream: widget.cartBloc.cartProductsBehavior.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.data!.response != null &&
                snapshot.data!.response!.isNotEmpty) {
              cartCounter = snapshot.data!.response!.length;
            } else if (snapshot.data?.response != null &&
                snapshot.data!.response!.isEmpty) {
              cartCounter = 0;
            }
            return (!showBadge || cartCounter == 0)
                ? SizedBox()
                : Container(
                    height: 12.h,
                    width: 12.h,
                    decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: CustomText(
                          text: cartCounter.toString(),
                          customTextStyle: RegularStyle(
                              color: Colors.white, fontSize: 8.sp)),
                    ),
                  );
          },
        )
      ],
    );
  }

  Widget _label(String title, int selectedIndex, int tabIndex) => CustomText(
      text: title,
      customTextStyle: RegularStyle(
          color: selectedIndex == tabIndex ? primaryColor : whiteColor,
          fontSize: 9.sp));
  Widget _imageIcon(String svgPath, int selectedIndex, int tabIndex) =>
      ImageHelper(
        image: svgPath,
        imageType: ImageType.svg,
        scale: 4,
        boxFit: BoxFit.scaleDown,
        color: selectedIndex == tabIndex
            ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
            : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      );

  void _initBottomNavItems(int selectedTab) {
    _items = [
      _homeBottomNavigationBarItem(selectedTab),
      _searchBottomNavigationBarItem(selectedTab),
      _promotionBottomNavigationBarItem(selectedTab),
      _basketBottomNavigationBarItem(selectedTab),
      _moreBottomNavigationBarItem(selectedTab)
    ];
  }

  @override
  bool canPop() => false;
}
