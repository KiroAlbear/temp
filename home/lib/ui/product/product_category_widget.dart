import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/brand/brand_mapper.dart';
import 'package:core/dto/models/home/category_mapper.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/custom_text.dart';
import 'package:core/ui/product/product_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:home/ui/home/filter_item_widget.dart';
import 'package:home/ui/home/home_bloc.dart';
import 'package:home/ui/product/product_category_bloc.dart';

class ProductCategoryWidget extends BaseStatefulWidget {
  final String favouriteIcon;
  final String homeLogo;
  final String supportIcon;
  final String notificationIcon;
  final String scanIcon;
  final String searchIcon;
  final String emptyFavouriteScreen;

  final HomeBloc homeBloc;
  final String backIcon;

  final ProductCategoryBloc productCategoryBloc;
  ValueNotifier<int> selectedCategoryIndex = ValueNotifier(0);
  ValueNotifier<int> selectedBrandIndex = ValueNotifier(0);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  bool isLoadingWidgetBuilt = false;

  ProductCategoryWidget(
      {super.key,
      required this.emptyFavouriteScreen,
      required this.favouriteIcon,
      required this.backIcon,
      required this.homeBloc,
      required this.homeLogo,
      required this.notificationIcon,
      required this.scanIcon,
      required this.searchIcon,
      required this.supportIcon,
      required this.productCategoryBloc});

  @override
  State<ProductCategoryWidget> createState() => _ProductCategoryWidgetState();
}

class _ProductCategoryWidgetState extends BaseState<ProductCategoryWidget> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() {
    return widget.productCategoryBloc.isForFavourite ? false : true;
  }

  @override
  bool isSafeArea() => true;

  @override
  void initState() {
    widget.productCategoryBloc.isLoading = widget.isLoading;
    widget.productCategoryBloc.reset();
    widget.productCategoryBloc.loadMore();

    super.initState();
  }

  void _loadProducts() {
    widget.isLoading.value = true;
    widget.productCategoryBloc.getProductWithSubcategoryBrand(
        widget.productCategoryBloc.subcategoryId,
        widget.productCategoryBloc.brandId);
  }

  @override
  Widget getBody(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTopWidget(
            notificationIcon: widget.notificationIcon,
            homeLogo: widget.homeLogo,
            scanIcon: widget.scanIcon,
            searchIcon: widget.searchIcon,
            supportIcon: widget.supportIcon,
            doSearch: () =>
                widget.homeBloc.doSearch(widget.homeBloc.searchBloc.value),
            textFiledControllerStream:
                widget.homeBloc.searchBloc.textFormFiledStream,
            onChanged: (value) =>
                widget.homeBloc.searchBloc.updateStringBehaviour(value),
            backIcon: widget.productCategoryBloc.isForFavourite
                ? ''
                : widget.backIcon,
            title: widget.productCategoryBloc.isForFavourite
                ? S.of(context).favourites
                : S.of(context).products,
            hideTop: true,
          ),
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    StreamBuilder<ApiState<List<CategoryMapper>>>(
                      stream: widget
                          .productCategoryBloc.subCategoryByCategoryStream,
                      builder: (context, snapshot) {
                        return !snapshot.hasData
                            ? Container()
                            : SizedBox(
                                height: 40.h,
                                child: ValueListenableBuilder<int>(
                                  valueListenable: widget.selectedCategoryIndex,
                                  builder: (context, value, child) {
                                    return ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: 8.w),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount:
                                          snapshot.data!.response!.length,
                                      itemBuilder: (context, index) {
                                        return FilterItemWidget(
                                            title: snapshot
                                                .data!.response![index].name,
                                            isSelected: index == value,
                                            onTap: () {
                                              widget.selectedCategoryIndex
                                                  .value = index;
                                              widget.productCategoryBloc
                                                      .subcategoryId =
                                                  snapshot.data!
                                                      .response![index].id;
                                              widget.productCategoryBloc
                                                  .reset();
                                              widget.productCategoryBloc
                                                  .getBrandBySubcategoryId(
                                                      widget.productCategoryBloc
                                                          .subcategoryId);
                                            },
                                            // imageUrl:
                                            imageUrl: snapshot
                                                .data!.response![index].image);
                                        // "https://lh3.googleusercontent.com/86arOE_jc_FYR6_mPbeXrzWB4LwvgCRWPGXbbftgG4_zAjY05ajbmq3xiG0Xc_uYCoTccikGvLdo5WIlofH5pmySn1VRejqngh2pwDLquiLJYayCOJKUrZKFnOwmSxKzQqqOM1y5o42TPk6LYR1vbPjrEPx3dQIUEwS4IPRjzt3JdPZT32TkqCECm-PoQtsBAPnyN6g46PbiyD9fblgzuBcT2xuO1AaZgOkR53bom8ATCBkDgcYT_mnsxWuxLGp6cNFUR4lWBFKyYkYJWJY--KmIVCWDDoJ3SxwjimGjwRG-X2Qu3AP4wa6tRazHuBo3a8IOofm6f5arSRdpVy4AaXoacTPz8TSkcofA0YaIttHpek1Gi5v1yMSbi5mHV6Mfv4lyczXPp8c5iNR7IFPvgMz1BiCETTxNwSvDjb2JCN94_256Fzejrs-Dk-kMYeCCYQh2Zd_lt9xiEQDgZ5gufdpxxM9xDiP447vrOqKbBMcAS_6hu43EwRi97ILAhBpS3QLP-4WhKf4GHauWqML_EcBvhszB-6T1iGeCWvpAT9jZVDVgekalBvLZiZNoy5Ow9QlnHA=w1827-h711-no-tmp.jpg");
                                      },
                                    );
                                  },
                                ),
                              );
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    StreamBuilder<ApiState<List<BrandMapper>>>(
                      stream:
                          widget.productCategoryBloc.brandBySubcategoryStream,
                      builder: (context, snapshot) {
                        return !snapshot.hasData
                            ? Container()
                            : SizedBox(
                                height: 40.h,
                                child: ValueListenableBuilder<int>(
                                  valueListenable: widget.selectedBrandIndex,
                                  builder: (context, value, child) {
                                    return ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: 8.w),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount:
                                          snapshot.data?.response?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return FilterItemWidget(
                                            title: snapshot
                                                .data!.response![index].name,
                                            isSelected: index == value,
                                            onTap: () {
                                              widget.selectedBrandIndex.value =
                                                  index;
                                              widget.productCategoryBloc
                                                      .brandId =
                                                  snapshot.data!
                                                      .response![index].id;
                                              widget.productCategoryBloc
                                                  .reset();
                                              _loadProducts();
                                            });
                                      },
                                    );
                                  },
                                ),
                              );
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 18.h),
                        child: StreamBuilder<ApiState<List<ProductMapper>>>(
                          stream: widget.productCategoryBloc.loadedListStream,
                          initialData: LoadingState(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.response != null &&
                                  snapshot.data!.response!.isEmpty &&
                                  widget.productCategoryBloc.isForFavourite) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ImageHelper(
                                        image: widget.emptyFavouriteScreen,
                                        imageType: ImageType.svg),
                                    SizedBox(
                                      height: 37.h,
                                    ),
                                    CustomText(
                                        text: S.of(context).emptyFavourite,
                                        customTextStyle: RegularStyle(
                                          fontSize: 26.sp,
                                          color: lightBlackColor,
                                        ))
                                  ],
                                );
                              }
                            }
                            // if (widget.isLoadingWidgetBuilt) {
                            //   widget.isLoading.value = true;
                            // }

                            return checkResponseStateWithLoadingWidget(
                                onSuccessFunction: () {},
                                snapshot.data ??
                                    LoadingState<List<ProductMapper>>(),
                                context,
                                onSuccess: ProductListWidget(
                                  productCategoryBloc:
                                      widget.productCategoryBloc,
                                  productList: snapshot.data?.response ?? [],
                                  favouriteIcon: widget.favouriteIcon,
                                  addToCart: (productMapper) {},
                                  onTapFavourite: (favourite, productMapper) {
                                    // widget.productCategoryBloc.addProductToFavourite();
                                  },
                                  loadMore: () {
                                    // widget.productCategoryBloc.isForFavourite
                                    // _loadProducts();
                                  },
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                ValueListenableBuilder(
                  valueListenable: widget.isLoading,
                  builder: (context, value, child) {
                    widget.isLoadingWidgetBuilt = true;
                    return !value
                        ? SizedBox()
                        : Expanded(
                            child: Container(
                            color: Colors.black.withOpacity(0.3),
                          ));
                  },
                ),
              ],
            ),
          )
        ],
      );
}
