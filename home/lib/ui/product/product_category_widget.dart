import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:core/ui/bases/base_state.dart';
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

  final HomeBloc homeBloc;
  final String backIcon;

  final ProductCategoryBloc productCategoryBloc;

  const ProductCategoryWidget(
      {super.key,
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
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 40.h,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 8.w),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return FilterItemWidget(
                    title: "شاي2",
                    isSelected: index == 1,
                    onTap: () {},
                    // imageUrl:
                    imageUrl:
                        "https://lh3.googleusercontent.com/86arOE_jc_FYR6_mPbeXrzWB4LwvgCRWPGXbbftgG4_zAjY05ajbmq3xiG0Xc_uYCoTccikGvLdo5WIlofH5pmySn1VRejqngh2pwDLquiLJYayCOJKUrZKFnOwmSxKzQqqOM1y5o42TPk6LYR1vbPjrEPx3dQIUEwS4IPRjzt3JdPZT32TkqCECm-PoQtsBAPnyN6g46PbiyD9fblgzuBcT2xuO1AaZgOkR53bom8ATCBkDgcYT_mnsxWuxLGp6cNFUR4lWBFKyYkYJWJY--KmIVCWDDoJ3SxwjimGjwRG-X2Qu3AP4wa6tRazHuBo3a8IOofm6f5arSRdpVy4AaXoacTPz8TSkcofA0YaIttHpek1Gi5v1yMSbi5mHV6Mfv4lyczXPp8c5iNR7IFPvgMz1BiCETTxNwSvDjb2JCN94_256Fzejrs-Dk-kMYeCCYQh2Zd_lt9xiEQDgZ5gufdpxxM9xDiP447vrOqKbBMcAS_6hu43EwRi97ILAhBpS3QLP-4WhKf4GHauWqML_EcBvhszB-6T1iGeCWvpAT9jZVDVgekalBvLZiZNoy5Ow9QlnHA=w1827-h711-no-tmp.jpg");
              },
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 40.h,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 8.w),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 14,
              itemBuilder: (context, index) {
                return FilterItemWidget(
                    title: "الكل", isSelected: index == 1, onTap: () {});
              },
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
              child: StreamBuilder<ApiState<List<ProductMapper>>>(
                stream: widget.productCategoryBloc.loadMore(),
                initialData: LoadingState(),
                builder: (context, snapshot) =>
                    checkResponseStateWithLoadingWidget(
                        snapshot.data ?? LoadingState<List<ProductMapper>>(),
                        context,
                        onSuccess: ProductListWidget(
                          productList: snapshot.data?.response ?? [],
                          favouriteIcon: widget.favouriteIcon,
                          addToCart: (productMapper) {},
                          onTapFavourite: (favourite, productMapper) {},
                          loadMore: () {
                            widget.productCategoryBloc.loadMore();
                          },
                        )),
              ),
            ),
          )
        ],
      );
}
