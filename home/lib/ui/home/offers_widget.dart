import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/home/offer_mapper.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/response_handler_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';

class OffersWidget extends StatefulWidget {
  final HomeBloc homeBloc;
  final bool isForPromoTap;

  const OffersWidget(
      {super.key, required this.homeBloc, this.isForPromoTap = false});

  @override
  State<OffersWidget> createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget>
    with ResponseHandlerModule {
  final PageController _pageScrollController =
      PageController(viewportFraction: 0.6, keepPage: true);

  @override
  Widget build(BuildContext context) =>
      StreamBuilder<ApiState<List<OfferMapper>>>(
        stream: widget.homeBloc.offersStream,
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
            snapshot.data ?? LoadingState<List<OfferMapper>>(), context,
            onSuccess: _buildWidget(snapshot.data?.response ?? [])),
      );

  Widget _buildWidget(List<OfferMapper> list) => SizedBox(
        height: 85.h,
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            // physics: const PageScrollPhysics(),
            // controller: _pageScrollController,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemBuilder: (context, index) => _buildItem(list[index]),
            separatorBuilder: (context, index) => SizedBox(
                  width: 20.w,
                ),
            itemCount: list.length),
      );

  Widget _buildItem(OfferMapper item) => Container(
        height: widget.isForPromoTap ? 104.h : 82.h,
        width: widget.isForPromoTap
            ? MediaQuery.of(context).size.width - 40.w
            : 258.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            color: promotionCardColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: item.name,
                      customTextStyle:
                          BoldStyle(fontSize: 16.sp, color: lightBlackColor)),
                  if (widget.isForPromoTap) ...[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.w),
                          border: Border.all(color: primaryColor, width: 1.w)),
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
                      child: CustomText(
                        text: S.of(context).promoDetails,
                        customTextStyle: MediumStyle(
                            color: lightBlackColor, fontSize: 12.sp),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // CustomText(
            //     text: item.description,
            //     customTextStyle:
            //         MediumStyle(fontSize: 14.sp, color: greyColor), maxLines: 3, softWrap: true,),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: ImageHelper(
                  image: item.image,
                  imageType: ImageType.networkSvg,
                  boxFit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
          ],
        ),
      );
}
