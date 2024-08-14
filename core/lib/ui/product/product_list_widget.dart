import 'package:core/core.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/ui/product/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:home/ui/product/product_category_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ProductListWidget extends StatelessWidget {
  final List<ProductMapper> productList;
  final String favouriteIcon;
  final ProductCategoryBloc productCategoryBloc;
  final Function(bool favourite, ProductMapper productMapper) onTapFavourite;
  final Function(ProductMapper productMapper) onAddToCart;

  final VoidCallback? loadMore;

  const ProductListWidget(
      {super.key,
      required this.productCategoryBloc,
      required this.productList,
      required this.favouriteIcon,
      required this.onTapFavourite,
      required this.onAddToCart,
      required this.loadMore});

  @override
  Widget build(BuildContext context) => LazyLoadScrollView(
        onEndOfPage: () {
          if (loadMore != null) {
            loadMore!();
          }
        },
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 11.w,
              mainAxisSpacing: 11.h,
              mainAxisExtent: 225.h),
          itemBuilder: (context, index) => ProductWidget(
            productCategoryBloc: productCategoryBloc,
            productMapper: productList[index],
            onAddToCart: onAddToCart,
            favouriteIcon: favouriteIcon,
            onTapFavourite: onTapFavourite,
          ),
          itemCount: productList.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
        ),
      );
}
