import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/toggel_button.dart';
import 'package:flutter/material.dart';
import 'package:my_orders/ui/widgets/order_item.dart';

class MyOrdersScreen extends BaseStatefulWidget {
  MyOrdersScreen({required this.backIcon, super.key});
  final String backIcon;

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends BaseState<MyOrdersScreen> {
  ValueNotifier<double> mynotifier = ValueNotifier<double>(-1);

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;

  @override
  Widget getBody(BuildContext context) {
    return Column(
      children: [
        AppTopWidget(
          title: S.of(context).myOrders,
          notificationIcon: '',
          homeLogo: '',
          scanIcon: '',
          searchIcon: '',
          supportIcon: '',
          hideTop: true,
          backIcon: widget.backIcon,
        ),
        SizedBox(
          height: 20,
        ),
        ToggleButton(
          height: 40,
          width: ScreenUtil.defaultSize.width,
          toggleBackgroundColor: Colors.transparent,
          toggleBorderColor: Colors.transparent,
          toggleColor: switchColor,
          activeTextColor: greyColor,
          inactiveTextColor: Colors.black,
          leftDescription: S.of(context).pastOrders,
          rightDescription: S.of(context).currentOrders,
          onLeftToggleActive: () {
            // mynotifier.value = ToggleButton.leftToggleAlign;
          },
          onRightToggleActive: () {
            // mynotifier.value = ToggleButton.rightToggleAlign;
          },
          toggleXAlign: mynotifier,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: OrderItem(),
        )
      ],
    );
  }
}
