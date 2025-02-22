import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../../core/generated/l10n.dart';

class CancelOrderBottomSheet extends StatelessWidget {
  final MyOrdersBloc myOrdersBloc;
  final int orderId;
  final TextEditingController _cancelReasonController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CancelOrderBottomSheet(
      {super.key, required this.myOrdersBloc, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
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
                height: 5,
              ),
              SizedBox(
                height: 100.h,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _cancelReasonController,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.justify,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return S.of(context).orderCancelReasonValidation;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: S.of(context).orderCancelReasonHint,
                      errorStyle: RegularStyle(color: redColor, fontSize: 14.sp)
                          .getStyle(),
                      hintStyle: RegularStyle(
                              color: lightGreyColorLightMode, fontSize: 14.sp)
                          .getStyle(),
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
              ),
              SizedBox(
                height: 15,
              ),
              CustomButtonWidget(
                idleText: S.of(context).orderCancelConfirmButton,
                onTap: () {
                  if (!_formKey.currentState!.validate()) return;

                  final int clientId =
                      int.tryParse(SharedPrefModule().userId ?? "0") ?? 0;
                  myOrdersBloc.cancelOrder(OrderCancelRequest(
                      customer_id: clientId,
                      order_id: orderId,
                      cancellation_reason: _cancelReasonController.text));
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
        ),
      ),
    );
  }
}
