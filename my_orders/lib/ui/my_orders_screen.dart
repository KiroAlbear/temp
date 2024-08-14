import 'package:core/core.dart';
import 'package:core/dto/models/my_orders/my_orders_request.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/toggel_button.dart';
import 'package:flutter/material.dart';
import 'package:my_orders/ui/my_orders_bloc.dart';
import 'package:my_orders/ui/widgets/my_orders/orders_page.dart';

class MyOrdersScreen extends BaseStatefulWidget {
  final String backIcon;
  final MyOrdersBloc myOrdersBloc;
  MyOrdersScreen(
      {required this.backIcon, required this.myOrdersBloc, super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends BaseState<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  ValueNotifier<double> _toggleXAlign = ValueNotifier<double>(-1);
  late final TabController _tabController;
  final double horizontalPadding = 17;
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => true;

  @override
  bool isSafeArea() => true;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    // _tabController.animateTo(1, duration: Duration(milliseconds: 1));
    // MyOrdersRemote().callApiAsStream().listen(
    //   (event) {
    //     LoggerModule.log(message: "my orders", name: "getting my orders");
    //   },
    // );
    widget.myOrdersBloc.getMyOrders(MyOrdersRequest('24', '1', '20'));
    _toggleXAlign.value = ToggleButton.rightToggleAlign;
    _tabController.addListener(() {
      if (_tabController.index == 1) {
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
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: TabBarView(controller: _tabController, children: [
              OrdersPage(
                myOrdersBloc: widget.myOrdersBloc,
                orderType: OrderType.currentOrder,
              ),
              OrdersPage(
                myOrdersBloc: widget.myOrdersBloc,
                orderType: OrderType.pastOrder,
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
