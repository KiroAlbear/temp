import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:deel/core/dto/modules/app_color_module.dart';
import 'package:deel/core/generated/l10n.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';


class CustomNavigationBar extends StatelessWidget {
  Function(int) onTap;
  CustomNavigationBar({required this.onTap});

  BottomNavigationBarItem _buildCurvedNavigationBarItem(
      {
      required String icon,
        required String label,
        required int selectedIndex,
        required int tabIndex,
        required BuildContext context}) {
    return BottomNavigationBarItem(
      label: label,
      icon: ImageHelper(
        image: icon,
        imageType: ImageType.svg,
        scale: 4,
        boxFit: BoxFit.scaleDown,
        color: selectedIndex == tabIndex
            ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
            : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      )
      // label: label,
      // labelStyle: TextStyle(color: Colors.white, fontSize: 10.sp),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.w),
            topRight: Radius.circular(20.w)),
      ),
      child: StreamBuilder(
        stream:getIt<BottomNavigationBloc>().selectedTabStream,
        builder:(context, snapshot) {
          return  BottomNavigationBar(
            backgroundColor: Colors.transparent,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: snapshot.data??0,
            selectedLabelStyle: RegularStyle(color: primaryColor, fontSize: 10.sp).getStyle(),
            unselectedLabelStyle: RegularStyle(color: Colors.white, fontSize: 10.sp).getStyle(),
            items: [
              _buildCurvedNavigationBarItem(icon: Assets.svg.icHome,label: S.of(context).home,selectedIndex: snapshot.data??0,tabIndex: 0,context: context),
              _buildCurvedNavigationBarItem(
                 icon: Assets.svg.icFavourite,label: S.of(context).favourite,selectedIndex:snapshot.data??0,tabIndex: 1,context: context),
              _buildCurvedNavigationBarItem(icon: Assets.svg.icPromo,label: S.of(context).offersTitle,selectedIndex:snapshot.data??0,tabIndex: 2,context: context),
              _buildCurvedNavigationBarItem(icon: Assets.svg.icCart,label: S.of(context).basket,selectedIndex:snapshot.data??0,tabIndex: 3,context: context),
              _buildCurvedNavigationBarItem(icon: Assets.svg.icMore,label: S.of(context).more,selectedIndex:snapshot.data??0,tabIndex: 4,context: context),
            ],
            onTap: (index) {
              getIt<BottomNavigationBloc>().setSelectedTab(index, context);
              onTap(index);
            },
          );
        }


      ),
    );
  }
}
