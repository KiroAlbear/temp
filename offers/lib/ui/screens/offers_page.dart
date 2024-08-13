import 'package:core/generated/l10n.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:flutter/material.dart';
import 'package:offers/ui/widget/offers_item.dart';

class OffersPage extends BaseStatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends BaseState<OffersPage> {
  final double horizontalPadding = 17;
  @override
  Widget getBody(BuildContext context) {
    return Column(
      children: [
        AppTopWidget(
          title: S.of(context).offersTitle,
          notificationIcon: '',
          homeLogo: '',
          scanIcon: '',
          searchIcon: '',
          supportIcon: '',
          hideTop: true,
          backIcon: "",
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 20,
              );
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              return OffersItem(
                title: "خصم 0.75% على طلبك$index",
                subtitle: "لما تشتري من 7 منتجات مختلفة$index",
              );
            },
          ),
        )
      ],
    );
  }

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;
}
