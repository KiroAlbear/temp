import 'package:deel/core/ui/product/product_widget.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ProductListWidget extends StatefulWidget {
  final List<ProductMapper> productList;
  final String favouriteIcon;
  final String favouriteIconFilled;
  final String deleteIcon;
  final CartBloc cartBloc;
  final ProductCategoryBloc productCategoryBloc;
  final String emptyFavouriteScreen;
  final Function(bool favourite, ProductMapper productMapper) onTapFavourite;
  final Function(ProductMapper productMapper) onAddToCart;
  final Function(ProductMapper productMapper)? onDecrementClicked;
  final Function(ProductMapper productMapper)? onIncrementClicked;
  final Function(ProductMapper productMapper)? onDeleteClicked;

  final Function(Function())? loadMore;

  ProductListWidget(
      {super.key,
      required this.cartBloc,
      required this.productCategoryBloc,
      required this.productList,
      required this.favouriteIcon,
      required this.deleteIcon,
      required this.favouriteIconFilled,
      required this.onTapFavourite,
      required this.onAddToCart,
      required this.loadMore,
      required this.emptyFavouriteScreen,
      required this.onDeleteClicked,
      this.onDecrementClicked,
      this.onIncrementClicked});

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  ValueNotifier<bool> refreshNotifier = ValueNotifier(false);

  List<ProductMapper> favouriteList = [];
  List<int> removedProducts = [];

  @override
  void initState() {
    favouriteList.addAll(widget.productList);
    widget.cartBloc.addCartInfoToProducts(widget.productList);

    if (widget.productCategoryBloc.isForFavourite) addAllProductToFavourite();
    super.initState();
  }

  void resetFavouriteList(int productId) {
    favouriteList.clear(); // TODO: check favourite logic again
    removedProducts.add(productId);
    for (ProductMapper product in widget.productList) {
      if (removedProducts.contains(product.id) == false) {
        favouriteList.add(product);
      }
    }
  }

  void addAllProductToFavourite() {
    favouriteList.clear();
    favouriteList.addAll(widget.productList);
  }

  @override
  Widget build(BuildContext context) => LazyLoadScrollView(
        onEndOfPage: () {
          if (widget.loadMore != null) {
            widget.loadMore!(
              () {
                widget.cartBloc.addCartInfoToProducts(widget.productList);
              },
            );
          }
        },
        child: ValueListenableBuilder(
          valueListenable: refreshNotifier,
          builder: (context, value, child) {
            if (widget.productCategoryBloc.isForFavourite &&
                widget.productList
                    .where(
                      (element) => element.isFavourite == true,
                    )
                    .isEmpty) {
              return EmptyFavouriteProducts(
                emptyFavouriteScreen: widget.emptyFavouriteScreen,
              );
            } else {
              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 11.w,
                    mainAxisSpacing: 11.h,
                    mainAxisExtent: 225.h),
                itemBuilder: (context, index) => ProductWidget(
                  key: UniqueKey(),
                  icDelete: widget.deleteIcon,
                  onProductRemoved: (int productId) {
                    resetFavouriteList(productId);
                    refreshNotifier.value = !refreshNotifier.value;
                  },
                  cartBloc: widget.cartBloc,
                  productCategoryBloc: widget.productCategoryBloc,
                  productMapper: widget.productCategoryBloc.isForFavourite
                      ? favouriteList[index]
                      : widget.productList[index],
                  onAddToCart: widget.onAddToCart,
                  favouriteIcon: widget.favouriteIcon,
                  onTapFavourite: widget.onTapFavourite,
                  onDeleteClicked: widget.onDeleteClicked,
                  onIncrementClicked: widget.onIncrementClicked,
                  onDecrementClicked: widget.onDecrementClicked,
                  favouriteIconFilled: widget.favouriteIconFilled,
                ),
                itemCount: widget.productCategoryBloc.isForFavourite
                    ? favouriteList.length
                    : widget.productList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
              );
            }
          },
        ),
      );
}
