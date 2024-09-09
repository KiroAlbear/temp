import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/my_orders/my_orders_request.dart';
import 'package:core/dto/models/my_orders/order_cancel_request.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:my_orders/ui/my_orders_bloc.dart';

import '../../../gen/assets.gen.dart';

class CancelOrderBottomSheet extends StatelessWidget {
  final MyOrdersBloc myOrdersBloc;
  final int orderId;
  const CancelOrderBottomSheet(
      {super.key, required this.myOrdersBloc, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomText(
              textAlign: TextAlign.center,
              text: S.of(context).orderCancelConfirmation,
              customTextStyle:
                  RegularStyle(color: lightBlackColor, fontSize: 20.sp)),
          ImageHelper(
              image: Assets.svg.imgCancelOrder, imageType: ImageType.svg),
          SizedBox(
            height: 10,
          ),
          CustomText(
              textAlign: TextAlign.center,
              text: S.of(context).orderCancelReasonTitle,
              customTextStyle:
                  RegularStyle(color: lightBlackColor, fontSize: 20.sp)),
          SizedBox(
            height: 80,
            child: TextField(
              textAlignVertical: TextAlignVertical.top,
              textAlign: TextAlign.justify,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: S.of(context).orderCancelReasonHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              expands: true,
              maxLines: null,
              minLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CustomButtonWidget(
            idleText: S.of(context).orderCancelConfirmButton,
            onTap: () {
              final int clientId =
                  int.tryParse(SharedPrefModule().userId ?? "0") ?? 0;
              myOrdersBloc.cancelOrder(
                  OrderCancelRequest(customer_id: clientId, order_id: orderId));
              Navigator.of(context).pop();
              myOrdersBloc.cancelOrderBehavior.listen((event) {
                if (event is SuccessState) {
                  myOrdersBloc.getMyOrders(
                      MyOrdersRequest(clientId.toString(), '1', '100'));
                }
              });
            },
            textColor: Colors.white,
            buttonColor: redColor,
          ),
          SizedBox(
            height: 15,
          ),
          CustomButtonWidget(
            idleText: S.of(context).orderCancelBackButton,
            onTap: () {
              Navigator.of(context).pop();
            },
            textColor: Colors.white,
            buttonColor: lightGreyColorLightMode,
          )
        ],
      ),
    );
  }
}
