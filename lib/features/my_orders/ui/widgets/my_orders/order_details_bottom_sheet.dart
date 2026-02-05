import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            start: 30,
            end: 30,
            top: 20,
            bottom: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                text: Loc.of(context)!.itemsDetails,
                customTextStyle: MediumStyle(
                  color: lightBlackColor,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: ListView.separated(
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
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
