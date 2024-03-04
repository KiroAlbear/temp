import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';

import 'package:core/generated/l10n.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation_bloc.dart';

class BottomNavigationWidget extends BaseStatefulWidget {
  final List<String> svgIconsPath;
  final BottomNavigationBloc homeBloc;

  const BottomNavigationWidget(
      {super.key, required this.svgIconsPath, required this.homeBloc});

  @override
  State<BottomNavigationWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends BaseState<BottomNavigationWidget> {
  late List<BottomNavigationBarItem> _items;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool isSafeArea() => true;

  @override
  Widget getBody(BuildContext context) => StreamBuilder(
        stream: widget.homeBloc.selectedTabStream,
        builder: (context, snapshot) =>
            widget.homeBloc.widgetList[snapshot.data ?? 0],
        initialData: 0,
      );

  @override
  Widget? customBottomNavBar() => StreamBuilder(
        stream: widget.homeBloc.selectedTabStream,
        builder: (context, snapshot) {
          _initBottomNavItems(snapshot.data ?? 0);
          return Stack(
            children: [
              BottomNavigationBar(
                  items: _items,
                  backgroundColor: offWhiteColor,
                  currentIndex: snapshot.data ?? 0,
                  landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                  onTap: (value) {
                    widget.homeBloc.setSelectedTab(
                      value,
                    );
                  },
                  iconSize: 20.r),
            ],
          );
        },
        initialData: 0,
      );

  BottomNavigationBarItem _homeBottomNavigationBarItem(int selectedIndex) =>
      _getBottomNavBarItem(
          widget.svgIconsPath[0], S.of(context).home, selectedIndex, 0);

  BottomNavigationBarItem _searchBottomNavigationBarItem(int selectedIndex) =>
      _getBottomNavBarItem(
          widget.svgIconsPath[1], S.of(context).search, selectedIndex, 1);

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
          activeIcon: Container(
            width: 43.w,
            height: 47.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              color: secondaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _imageIcon(svgPath, selectedIndex, tabIndex),
                SizedBox(
                  height: 4.h,
                ),
                CustomText(
                    text: name,
                    customTextStyle:
                        RegularStyle(color: whiteColor, fontSize: 9.sp))
              ],
            ),
          ),
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _imageIcon(svgPath, selectedIndex, tabIndex),
              SizedBox(
                height: 4.h,
              ),
              CustomText(
                  text: name,
                  customTextStyle:
                      RegularStyle(color: greyColor, fontSize: 9.sp))
            ],
          ),
          label: name);

  Widget _imageIcon(String svgPath, int selectedIndex, int tabIndex) =>
      ImageHelper(
        image: svgPath,
        imageType: ImageType.svg,
        width: 16.w,
        height: 16.h,
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
