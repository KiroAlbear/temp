import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/home/offer_mapper.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/response_handler_module.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';

class OffersWidget extends StatefulWidget {
  final HomeBloc homeBloc;

  const OffersWidget({super.key, required this.homeBloc});

  @override
  State<OffersWidget> createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget>
    with ResponseHandlerModule {
  final PageController _pageScrollController =
      PageController(viewportFraction: 0.89, initialPage: 0, keepPage: true);

  @override
  Widget build(BuildContext context) =>
      StreamBuilder<ApiState<List<OfferMapper>>>(
        stream: widget.homeBloc.offerStream,
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
            snapshot.data ?? LoadingState<List<OfferMapper>>(), context,
            onSuccess: _loadList(snapshot.data?.response ?? [])),
        initialData: LoadingState(),
      );

  Widget _loadList(List<OfferMapper> list) => Column(
    children: [
      SizedBox(
        height: 100.h,
        child: ListView.separated(
              itemBuilder: (context, index) =>
                  _buildItem(context, index, list[index]),
              shrinkWrap: true,
              // physics: const PageScrollPhysics(),
              // controller: _pageScrollController,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                width: 10.w,
              ),
            ),
      ),
      list.isNotEmpty ? SizedBox(
        height: 50.h,
      ): Container()
    ],
  );

  Widget _buildItem(BuildContext context, int index, OfferMapper item) =>
      Container(
        height: 90.h,
        width: MediaQuery.of(context).size.width - 40.w,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            border: Border.all(width: 1.w, color: _whichBorderColor(index)),
            color: _whichCardColor(index)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomText(
                  text: item.name,
                  customTextStyle:
                      BoldStyle(color: lightBlackColor, fontSize: 14.sp)),
            ),
            Expanded(
                child: ImageHelper(
              image: item.image,
              imageType: ImageType.networkSvg,
              boxFit: BoxFit.contain,
            ))
          ],
        ),
      );

  Color _whichBorderColor(int index) {
    if (index % 3 == 0) {
      return primaryColor;
    } else if (index % 3 == 1) {
      return greenColor;
    } else {
      return redColor;
    }
  }

  Color _whichCardColor(int index) {
    if (index % 3 == 0) {
      return yellowCardColor;
    } else if (index % 3 == 1) {
      return greenCardColor;
    } else {
      return redCardColor;
    }
  }

  @override
  void dispose() {
    _pageScrollController.dispose();
    super.dispose();
  }
}
