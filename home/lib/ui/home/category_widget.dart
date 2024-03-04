import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/home/category_mapper.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';

import 'package:core/dto/modules/response_handler_module.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/home.dart';

class CategoryWidget extends StatefulWidget {
  final HomeBloc homeBloc;
  final ScrollController scrollController;
  const CategoryWidget({super.key, required this.homeBloc, required this.scrollController});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget>
    with ResponseHandlerModule {
  @override
  Widget build(BuildContext context) =>
      StreamBuilder<ApiState<List<CategoryMapper>>>(
        stream: widget.homeBloc.categoryStream,
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
            snapshot.data ?? LoadingState<List<CategoryMapper>>(), context,
            onSuccess: _buildWidget(snapshot.data?.response ?? [])),
      );

  Widget _buildWidget(List<CategoryMapper> list) => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 15.w,
          mainAxisExtent: 110.w,
          mainAxisSpacing: 15.h,
        ),
        itemBuilder: (context, index) => _buildItem(list[index]),
        itemCount: list.length,
        controller: widget.scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
      );

  Widget _buildItem(CategoryMapper item) => Container(
        width: 110.h,
        height: 110.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            border: Border.all(width: 1.w, color: primaryColor),
            color: categoryCardColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageHelper(
              image: item.image,
              imageType: ImageType.network,
              height: 70.h,
              width: 70.w,
              boxFit: BoxFit.contain,
            ),
            SizedBox(
              height: 7.h,
            ),
            CustomText(
                text: item.name,
                customTextStyle:
                    MediumStyle(fontSize: 14.sp, color: secondaryColor))
          ],
        ),
      );
}
