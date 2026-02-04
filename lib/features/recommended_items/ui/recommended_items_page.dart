import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/recommended_items_bloc.dart';

class RecommendedItemsPage extends BaseStatefulWidget {
  RecommendedItemsPage({super.key});

  @override
  State<RecommendedItemsPage> createState() => _RecommendedItemsPageState();
}

class _RecommendedItemsPageState extends BaseState<RecommendedItemsPage> {
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

        isHavingBack: true,
        title: Loc.of(context)!.recommendedForYourStore,
      ),
      Expanded(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: true,
              child: _recommendedItemsProducts(),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _recommendedItemsProducts() {
    return StreamBuilder<ApiState<List<ProductMapper>>>(
      stream: getIt<RecommendedItemsBloc>().recommendedItemsBehaviour.stream,
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
            cartBloc: getIt(),
            productCategoryBloc: getIt<ProductCategoryBloc>(),
            productList: snapshot.data?.response ?? [],
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
