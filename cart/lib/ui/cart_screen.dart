import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/custom_text.dart';

import 'package:flutter/material.dart';

class CartScreen extends BaseStatefulWidget {
  final String backIcon;

  CartScreen({required this.backIcon, super.key});

  @override
  State<CartScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends BaseState<CartScreen> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;

  @override
  Widget getBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTopWidget(
          title: "السلة",
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
        CustomText(
            text: "تفاصيل المنتجات",
            customTextStyle:
                MediumStyle(color: lightBlackColor, fontSize: 26.sp))
      ],
    );
  }
}
