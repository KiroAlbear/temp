import 'package:deel/deel.dart';
import 'package:deel/features/my_orders/ui/widgets/my_orders/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/generated/l10n.dart';
import 'my_orders_bloc.dart';

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
  bool isBottomSafeArea() =>false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    // _tabController.animateTo(1, duration: Duration(milliseconds: 1));
    // MyOrdersRemote().callApiAsStream().listen(
    //   (event) {
    //     LoggerModule.log(message: "my orders", name: "getting my orders");
    //   },
    // );
    // get client id from shared prefrences
    //

    widget.myOrdersBloc.getMyOrders(MyOrdersRequest(
        int.parse(SharedPrefModule().userId ?? '0').toString(), '1', '100'));
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
