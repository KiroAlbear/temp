import 'package:core/core.dart';

import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/utility_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {


  OrderItem(
      {});

  final CustomTextStyleModule titleTextStyle =
      MediumStyle(color: lightBlackColor, fontSize: 18.sp);

  final double borderRadious = 10;

  final ImageHelper icDelete = ImageHelper(
      image: Assets.svg.icDeleteOrder,
      width: 40,
      height: 40,
      imageType: ImageType.svg);

  final ValueNotifier<bool> isExpanded = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: myOrdersCardColor,
        borderRadius: BorderRadius.circular(borderRadious),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          children: [
            Container(
              color: Colors.black,
              width: double.infinity,
              height: 1,
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPastOrdersTrailingWidget(
      BuildContext context, bool isOrderReceived) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isOrderReceived ? greenColor : Colors.red,
      ),
      child: CustomText(
        // text: S.of(context).orderNotRecieved,
        text: isOrderReceived
            ? S.of(context).orderRecieved
            : S.of(context).orderNotRecieved,
        customTextStyle: SemiBoldStyle(color: Colors.white, fontSize: 12.sp),
      ),
    );
  }

  ValueListenableBuilder<bool> _getCurrentOrdersTrailingWidget() {
    return ValueListenableBuilder(
      valueListenable: isExpanded,
      builder: (context, value, child) {
        return Visibility(
          visible: value,
          maintainAnimation: true,
          maintainState: true,
          child: AnimatedOpacity(
            opacity: value ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: InkWell(
              onTap: () async {
                await UtilityModule().showBottomSheetDialog(
                    child: const CancelOrderBottomSheet(), context: context);
              },
              child: ImageHelper(
                image: Assets.svg.icDeleteOrder,
                width: 40,
                height: 40,
                imageType: ImageType.svg,
              ),
            ),
          ),
        );
      },
    );
  }
}
