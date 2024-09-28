import 'package:core/core.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';

import 'offers_widget.dart';

class OffersPage extends BaseStatefulWidget {
  HomeBloc homeBloc;
  String emptyOffers;

  OffersPage({
    super.key,
    required this.homeBloc,
    required this.emptyOffers,
  });

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends BaseState<OffersPage> {
  @override
  Widget getBody(BuildContext context) {
    return Column(
      children: [
        AppTopWidget(
          notificationIcon: '',
          homeLogo: '',
          scanIcon: '',
          searchIcon: '',
          supportIcon: '',
          hideTop: true,
          title: S.of(context).offersTitle,
        ),
        SizedBox(
          height: 30.h,
        ),

        // Expanded(
        //     child: ImageHelper(
        //         image: widget.emptyOffers, imageType: ImageType.svg)),
        StreamBuilder(
          stream: widget.homeBloc.offersStream,
          builder: (context, snapshot) {
            return ((snapshot.data != null) &&
                    snapshot.data!.response != null &&
                    snapshot.data!.response!.isNotEmpty)
                ? Expanded(
                    child: OffersWidget(
                      homeBloc: widget.homeBloc,
                      isMainPage: true,
                    ),
                  )
                : Expanded(
                    child: ImageHelper(
                        image: widget.emptyOffers, imageType: ImageType.svg));
          },
        ),
        SizedBox(
          height: 30.h,
        ),
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
