import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/home/offer_mapper.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/response_handler_module.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';

class PromotionWidget extends StatefulWidget {
  final HomeBloc homeBloc;

  const PromotionWidget({super.key, required this.homeBloc});

  @override
  State<PromotionWidget> createState() => _PromotionWidgetState();
}

class _PromotionWidgetState extends State<PromotionWidget>
    with ResponseHandlerModule {
  final PageController _pageScrollController =
      PageController(viewportFraction: 0.6, keepPage: true);

  @override
  Widget build(BuildContext context) =>
      StreamBuilder<ApiState<List<OfferMapper>>>(
        stream: widget.homeBloc.promotionStream,
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
            snapshot.data ?? LoadingState<List<OfferMapper>>(), context,
            onSuccess: _buildWidget(snapshot.data?.response ?? [])),
      );

  Widget _buildWidget(List<OfferMapper> list) => SizedBox(
    height: 83.h,
    child: ListView.separated(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(),
        controller: _pageScrollController,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) => _buildItem(list[index]),
        separatorBuilder: (context, index) => SizedBox(
              width: 20.w,
            ),
        itemCount: list.length),
  );

  Widget _buildItem(OfferMapper item) => Container(
        height: 180.h,
        width: 263.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            border: Border.all(width: 1.w, color: primaryColor),
            color: promotionCardColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 14.h,
            ),
            CustomText(
                text: item.name,
                customTextStyle:
                    BoldStyle(fontSize: 20.sp, color: secondaryColor)),
            // CustomText(
            //     text: item.description,
            //     customTextStyle:
            //         MediumStyle(fontSize: 14.sp, color: greyColor), maxLines: 3, softWrap: true,),
            SizedBox(height: 13.h,),
            ImageHelper(
              image: item.image,
              imageType: ImageType.network,
              height: 83.h,
              width: 159.w,
              boxFit: BoxFit.fill,
            )
          ],
        ),
      );
}
