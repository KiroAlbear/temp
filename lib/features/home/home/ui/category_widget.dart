import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class CategoryWidget extends StatefulWidget {
  final HomeBloc homeBloc;

  final ScrollController scrollController;

  const CategoryWidget({
    super.key,
    required this.homeBloc,
    required this.scrollController,
  });

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
          crossAxisSpacing: 12.w,
          mainAxisExtent: 150.h,
          mainAxisSpacing: 10.h,
        ),
        itemBuilder: (context, index) => _buildItem(list[index]),
        itemCount: list.length,
        controller: widget.scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
      );

  Widget _buildItem(CategoryMapper item) => InkWell(
        onTap: () {
          widget.homeBloc.onCategoryClick(item);
          widget.homeBloc.isBanner = false;
          widget.homeBloc.selectedOffer = null;
          ProductCategoryBloc.searchValue = null;
          ProductCategoryWidget.cateogryId = item.id!;
          ProductCategoryWidget.categoryProductsCount = item.productExactCount;
          CustomNavigatorModule.navigatorKey.currentState
              ?.pushNamed(AppScreenEnum.product.name);
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 112.w,
                height: 98.h,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.w),
                    color: productCardColor),
                child: ImageHelper(
                  image: item.image,
                  imageType: ImageType.network,

                  boxFit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 7.h,
              ),
              CustomText(
                  text:item.name ,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  customTextStyle:
                      MediumStyle(fontSize: 13.sp, color: darkSecondaryColor))
            ],
          ),
        ),
      );
}
