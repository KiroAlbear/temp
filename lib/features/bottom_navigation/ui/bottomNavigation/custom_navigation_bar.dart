import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class CustomNavigationBar extends StatelessWidget {
  final ValueChanged<int> onTap;
  const CustomNavigationBar({super.key, required this.onTap});

  BottomNavigationBarItem _buildCurvedNavigationBarItem({
    required String icon,
    required String label,
    required int selectedIndex,
    required int tabIndex,
    bool showBadge = false,
    required BuildContext context,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Stack(
        children: [
          ImageHelper(
            image: icon,
            imageType: ImageType.svg,
            scale: 4,
            boxFit: BoxFit.scaleDown,
            color: selectedIndex == tabIndex
                ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
                : Theme.of(
                    context,
                  ).bottomNavigationBarTheme.unselectedItemColor,
          ),
          showBadge == false
              ? SizedBox()
              : StreamBuilder(
                  stream: getIt<CartBloc>().cartProductsBehavior.stream,
                  builder: (context, snapshot) {
                    final cartCounter =
                        (snapshot.data?.response?.getFirst.isNotEmpty ?? false)
                            ? snapshot.data!.response!.getFirst.length
                            : 0;
                    return cartCounter == 0
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
                                  color: Colors.white,
                                  fontSize: 8.sp,
                                ),
                              ),
                            ),
                          );
                  },
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.w),
          topRight: Radius.circular(20.w),
        ),
      ),
      child: StreamBuilder(
        stream: getIt<BottomNavigationBloc>().selectedTabStream,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            backgroundColor: Colors.transparent,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: snapshot.data ?? 0,
            selectedLabelStyle: RegularStyle(
              color: primaryColor,
              fontSize: 10.sp,
            ).getStyle(),
            unselectedLabelStyle: RegularStyle(
              color: Colors.white,
              fontSize: 10.sp,
            ).getStyle(),
            items: [
              _buildCurvedNavigationBarItem(
                icon: Assets.svg.icHome,
                label: Loc.of(context)!.home,
                selectedIndex: snapshot.data ?? 0,
                tabIndex: 0,
                context: context,
              ),
              _buildCurvedNavigationBarItem(
                icon: Assets.svg.icFavourite,
                label: Loc.of(context)!.favourite,
                selectedIndex: snapshot.data ?? 0,
                tabIndex: 1,
                context: context,
              ),
              _buildCurvedNavigationBarItem(
                icon: Assets.svg.icPromo,
                label: Loc.of(context)!.offersTitle,
                selectedIndex: snapshot.data ?? 0,
                tabIndex: 2,
                context: context,
              ),
              _buildCurvedNavigationBarItem(
                icon: Assets.svg.icCart,
                label: Loc.of(context)!.basket,
                selectedIndex: snapshot.data ?? 0,
                tabIndex: 3,
                context: context,
                showBadge: true,
              ),
              _buildCurvedNavigationBarItem(
                icon: Assets.svg.icMore,
                label: Loc.of(context)!.more,
                selectedIndex: snapshot.data ?? 0,
                tabIndex: 4,
                context: context,
              ),
            ],
            onTap: (index) {
              onTap(index);
            },
          );
        },
      ),
    );
  }
}
