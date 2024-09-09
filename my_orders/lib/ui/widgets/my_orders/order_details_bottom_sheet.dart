import 'package:core/core.dart';
import 'package:core/dto/models/my_orders/my_orders_mappers.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:my_orders/gen/assets.gen.dart';

import '../current_orders/current_order_details_item.dart';

class OrderDetailsBottomSheet extends StatelessWidget {
  final List<OrderItemMapper> items;
  const OrderDetailsBottomSheet({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
              start: 30, end: 30, top: 20, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: S.of(context).itemsDetails,
                  customTextStyle:
                      MediumStyle(color: lightBlackColor, fontSize: 20.sp)),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ImageHelper(
                    image: Assets.svg.icClose,
                    width: 20,
                    height: 20,
                    imageType: ImageType.svg,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(height: 15),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return CurrentOrderDetailsItem(
              title: items[index].title,
              subtitle: items[index].description,
              price: items[index].price,
              orderImage: items[index].image,
              quantity: items[index].count,
            );
          },
        ),
        // CurrentOrderDetailsItem(
        //   title: "ربيع",
        //   subtitle:
        //       "شاي أخضر بالليمون - 25 فتلة   (x6 علبة)  شاي أخضر بالليمون - 25 فتلة   (x6 علبة) شاي أخضر بالليمون - 25 فتلة   (x6 علبة)",
        //   price: "25",
        //   orderImage: Assets.svg.icClose,
        //   quantity: 5,
        // ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
