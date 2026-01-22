import 'package:deel/core/ui/not_logged_in_widget.dart';
import 'package:deel/deel.dart';
import 'package:deel/features/announcements/bloc/announcements_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../core/generated/l10n.dart';
import '../bloc/recommended_items_bloc.dart';

class RecommendedItemsPage extends BaseStatefulWidget {
  RecommendedItemsPage({super.key});

  @override
  State<RecommendedItemsPage> createState() => _ProductCategoryWidgetState();
}

class _ProductCategoryWidgetState extends BaseState<RecommendedItemsPage> {
  final double filterHorizontalPadding = 15.h;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() {
    return false;
  }

  @override
  void onPopInvoked(didPop) {
    changeSystemNavigationBarColor(secondaryColor);
    super.onPopInvoked(didPop);
  }

  @override
  bool isSafeArea() => true;

  @override
  bool isBottomSafeArea() => false;

  @override
  Color? systemNavigationBarColor() {
    return secondaryColor;
  }

  @override
  void initState() {
    // getIt<RecommendedItemsBloc>().getRecommendedItems();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget getBody(BuildContext context) => Column(
    children: [
      AppTopWidget(
        isHavingSupport: true,
        onBackPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            Routes.navigateToScreen(
              Routes.homePage,
              NavigationType.goNamed,
              context,
            );
          }
        },
        isHavingBack: true,
        title: "الأكثر طلبا",
      ),
      Expanded(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: true,
              child: _mostSellingProducts(),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _mostSellingProducts() {
    return StreamBuilder<ApiState<List<ProductMapper>>>(
      stream: getIt<RecommendedItemsBloc>().mostSellingBehaviour.stream,
      initialData: LoadingState(),
      builder: (context, snapshot) {
        if ((snapshot.hasData &&
            snapshot.data!.response != null &&
            snapshot.data!.response!.isEmpty)) {
          return SizedBox(height: 90.h);
        }

        return checkResponseStateWithLoadingWidget(
          onSuccessFunction: () {},
          snapshot.data ?? LoadingState<List<ProductMapper>>(),
          context,
          onSuccess: ProductListWidget(
            isForFavourite: false,
            deleteIcon: Assets.svg.icDelete,
            emptyFavouriteScreen: Assets.svg.emptyFavourite,
            cartBloc: getIt(),
            productCategoryBloc: getIt<ProductCategoryBloc>(),
            productList: snapshot.data?.response ?? [],
            favouriteIcon: Assets.svg.icFavourite,
            favouriteIconFilled: Assets.svg.icFavouriteFilled,
            onTapFavourite: (favourite, productMapper) {},
            loadMore: (Function func) {
              _loadProducts();
            },
          ),
        );
      },
    );
  }

  void _loadProducts() {
    getIt<RecommendedItemsBloc>().loadMoreRecommendedItems();
  }
}
