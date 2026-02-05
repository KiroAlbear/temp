import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ProductListWidget extends StatefulWidget {
  final List<ProductMapper> productList;
  final CartBloc cartBloc;
  final ProductCategoryBloc productCategoryBloc;
  final bool isForFavourite;
  final ScrollPhysics? scrollPhysics;
  final bool isHorizontalListView;

  final Function(bool favourite, ProductMapper productMapper) onTapFavourite;

  // final Function(ProductMapper productMapper) onAddToCart;
  // final Function(ProductMapper productMapper)? onDecrementClicked;
  // final Function(ProductMapper productMapper)? onIncrementClicked;
  // final Function(ProductMapper productMapper)? onDeleteClicked;

  final Function(Function())? loadMore;

  final ValueNotifier<bool> showOverlayLoading = ValueNotifier(false);

  ProductListWidget({
    super.key,
    required this.cartBloc,
    required this.productCategoryBloc,
    required this.productList,
    required this.onTapFavourite,
    // required this.onAddToCart,
    required this.loadMore,
    // required this.onDeleteClicked,
    required this.isForFavourite,
    this.isHorizontalListView = false,
    this.scrollPhysics,
    // this.onDecrementClicked,
    // this.onIncrementClicked,
  });

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

    if (widget.isForFavourite) addAllProductToFavourite();
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
        widget.loadMore!(() {
          widget.cartBloc.addCartInfoToProducts(widget.productList);
          if (widget.isForFavourite) addAllProductToFavourite();
        });
      }
    },
    child: ValueListenableBuilder(
      valueListenable: refreshNotifier,
      builder: (context, value, child) {
        if (widget.isForFavourite &&
            widget.productList
                .where((element) => element.isFavourite == true)
                .isEmpty) {
          return EmptyFavouriteProducts();
        } else {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: widget.isForFavourite ? 0 : 18.h,
                ),
                child: widget.isHorizontalListView
                    ? _buildHorizontalListView()
                    : _buildGridView(),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: OverlayLoadingWidget(
                  showOverlayLoading: widget.showOverlayLoading,
                ),
              ),
            ],
          );
        }
      },
    ),
  );

  GridView _buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      physics: widget.scrollPhysics,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 11.w,
        mainAxisSpacing: 11.h,
        mainAxisExtent: 220.h,
      ),
      itemBuilder: (context, index) => _buildProductWidget(index),
      itemCount: widget.isForFavourite
          ? favouriteList.length
          : widget.productList.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
    );
  }

  Widget _buildHorizontalListView() {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(width: 12.w);
        },
        scrollDirection: Axis.horizontal,
        itemCount: widget.productList.length <= 16
            ? widget.productList.length
            : 16,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Row(
            children: [
              index == 0 ? SizedBox(width: 16.w) : SizedBox(),
              SizedBox(width: 165, child: _buildProductWidget(index)),
              index == widget.productList.length - 1
                  ? SizedBox(width: 16.w)
                  : SizedBox(),
            ],
          );
        },
      ),
    );
  }

  ProductWidget _buildProductWidget(int index) {
    return ProductWidget(
      key: ValueKey(index),
      index: index,
      onProductRemoved: (int productId) {
        resetFavouriteList(productId);
        refreshNotifier.value = !refreshNotifier.value;
      },
      cartBloc: widget.cartBloc,
      productCategoryBloc: widget.productCategoryBloc,
      productMapper: widget.isForFavourite
          ? favouriteList[index]
          : widget.productList[index],
      onAddToCart: (productMapper) {
        widget.showOverlayLoading.value = true;
        widget.cartBloc.onAddToCart(productMapper, widget.productList, () {
          widget.showOverlayLoading.value = false;
        });
      },
      onTapFavourite: widget.onTapFavourite,
      onDeleteClicked: (productMapper) {
        widget.showOverlayLoading.value = true;
        widget.cartBloc.onDeleteFromCart(productMapper, widget.productList, () {
          widget.showOverlayLoading.value = false;
        });
      },
      onIncrementClicked: (productMapper) {
        widget.showOverlayLoading.value = true;
        widget.cartBloc.onDecrementIncrement(
          productMapper,
          widget.productList,
          () {
            widget.showOverlayLoading.value = false;
          },
        );
      },
      onDecrementClicked: (productMapper) {
        widget.showOverlayLoading.value = true;
        widget.cartBloc.onDecrementIncrement(
          productMapper,
          widget.productList,
          () {
            widget.showOverlayLoading.value = false;
          },
        );
      },
    );
  }
}
