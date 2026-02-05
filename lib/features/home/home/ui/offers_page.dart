import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class OffersPage extends BaseStatefulWidget {
  HomeBloc homeBloc;

  OffersPage({super.key, required this.homeBloc});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends BaseState<OffersPage> {
  @override
  Color? systemNavigationBarColor() => secondaryColor;

  @override
  void onPopInvoked(didPop) {
    Routes.navigateToScreen(Routes.homePage, NavigationType.goNamed, context);
  }

  @override
  Widget getBody(BuildContext context) {
    return Column(
      children: [
        AppTopWidget(
          isHavingSupport: true,
          title: Loc.of(context)!.offersTitle,
        ),

        StreamBuilder(
          stream: widget.homeBloc.offersStream,
          builder: (context, snapshot) {
            return ((snapshot.data != null) &&
                    snapshot.data!.response != null &&
                    snapshot.data!.response!.isNotEmpty)
                ? Expanded(
                    child: OffersListingWidget(
                      homeBloc: widget.homeBloc,
                      isMainPage: true,
                    ),
                  )
                : Expanded(
                    child: ImageHelper(
                      image: Assets.svg.emptyOffers,
                      imageType: ImageType.svg,
                    ),
                  );
          },
        ),
        SizedBox(height: 30.h),
      ],
    );
  }

  @override
  PreferredSizeWidget? appBar() {
    return null;
  }

  @override
  bool canPop() {
    return false;
  }

  @override
  bool isSafeArea() {
    return true;
  }
}
