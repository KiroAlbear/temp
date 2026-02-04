import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class CancelOrderBottomSheet extends StatelessWidget {
  final MyOrdersBloc myOrdersBloc;
  final int orderId;
  final TextEditingController _cancelReasonController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CancelOrderBottomSheet({
    super.key,
    required this.myOrdersBloc,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17, vertical: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  130, // <-- Fill remaining space
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10),
                      ImageHelper(
                        image: Assets.png.orderCancel.path,
                        imageType: ImageType.asset,
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(height: 5),
                      CustomText(
                        textAlign: TextAlign.center,
                        text: Loc.of(context)!.orderCancelReasonTitle,
                        customTextStyle: BoldStyle(
                          color: secondaryColor,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 25),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: Loc.of(context)!.orderCancelReason,
                        customTextStyle: RegularStyle(
                          color: black,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 260.h,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _cancelReasonController,
                            textAlignVertical: TextAlignVertical.top,
                            textAlign: TextAlign.justify,
                            onChanged: (value) {
                              myOrdersBloc.cancelOrderReason.add(value);

                              if (value.trim().isEmpty) {
                                myOrdersBloc.buttonBloc.buttonBehavior.sink.add(
                                  ButtonState.idle,
                                );
                                myOrdersBloc.buttonBloc.buttonBehavior.add(
                                  ButtonState.idle,
                                );
                              } else {
                                myOrdersBloc.buttonBloc.buttonBehavior.sink.add(
                                  ButtonState.success,
                                );
                                myOrdersBloc.buttonBloc.buttonBehavior.add(
                                  ButtonState.success,
                                );
                              }
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().isEmpty) {
                                return Loc.of(
                                  context,
                                )!.orderCancelReasonValidation;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: Loc.of(context)!.orderCancelReasonHint,
                              errorStyle: RegularStyle(
                                color: redColor,
                                fontSize: 14.sp,
                              ).getStyle(),
                              hintStyle: RegularStyle(
                                color: lightGreyColorLightMode,
                                fontSize: 14.sp,
                              ).getStyle(),
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
                      SizedBox(height: 15),
                    ],
                  ),
                  Spacer(),
                  CustomButtonWidget(
                    idleText: Loc.of(context)!.next,
                    buttonBehaviour: myOrdersBloc.buttonBloc.buttonBehavior,
                    buttonColor: disabledButtonColorLightMode,
                    successColor: primaryColor,
                    idleTextColor: disabledButtonTextColorLightMode,

                    onTap: () {
                      if (!_formKey.currentState!.validate()) return;

                      final int clientId =
                          int.tryParse(SharedPrefModule().userId ?? "0") ?? 0;
                      myOrdersBloc.cancelOrder(
                        OrderCancelRequest(
                          customer_id: clientId,
                          order_id: orderId,
                          cancellation_reason: _cancelReasonController.text,
                        ),
                      );
                      Navigator.of(context).pop();
                      myOrdersBloc.cancelOrderBehavior.listen((event) {
                        if (event is SuccessState) {
                          myOrdersBloc.getMyOrders(
                            MyOrdersRequest(clientId.toString(), '1', '100'),
                          );
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
