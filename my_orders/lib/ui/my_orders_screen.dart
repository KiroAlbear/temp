import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/toggel_button.dart';
import 'package:flutter/material.dart';
import 'package:my_orders/ui/widgets/current_orders/current_orders_page.dart';
import 'package:my_orders/ui/widgets/past_orders/past_orders_page.dart';

class MyOrdersScreen extends BaseStatefulWidget {
  MyOrdersScreen({required this.backIcon, super.key});
  final String backIcon;

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends BaseState<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  ValueNotifier<double> _toggleXAlign = ValueNotifier<double>(-1);
  late final TabController _tabController;
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        _toggleXAlign.value = ToggleButton.leftToggleAlign;
      } else {
        _toggleXAlign.value = ToggleButton.rightToggleAlign;
      }
    });
    super.initState();
  }

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
            _tabController.animateTo(0);
          },
          onRightToggleActive: () {
            _tabController.animateTo(1);
          },
          toggleXAlign: _toggleXAlign,
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: TabBarView(controller: _tabController, children: [
              PastOrdersPage(),
              CurrentOrdersPage(),
            ]),
          ),
        ),
      ],
    );
  }
}
