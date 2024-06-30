import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/product/product_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:home/ui/home/home_bloc.dart';
import 'package:core/ui/app_top_widget.dart';
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
    return widget.productCategoryBloc.isForFavourite ?  false: true;
  }

  @override
  bool isSafeArea() => true;

  @override
  Widget getBody(BuildContext context) => Column(
        children: [
          AppTopWidget(
            notificationIcon: widget.notificationIcon,
            homeLogo: widget.homeLogo,
            scanIcon: widget.scanIcon,
            searchIcon: widget.searchIcon,
            supportIcon: widget.supportIcon,
            doSearch: () => widget.homeBloc.doSearch(widget.homeBloc.searchBloc.value),
            textFiledControllerStream: widget.homeBloc.searchBloc.textFormFiledStream,
            onChanged: (value) => widget.homeBloc.searchBloc.updateStringBehaviour(value),
            backIcon: widget.productCategoryBloc.isForFavourite? '': widget.backIcon,
            title: widget.productCategoryBloc.isForFavourite
                ? S.of(context).favourites
                : S.of(context).products,
            hideTop: true,
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
