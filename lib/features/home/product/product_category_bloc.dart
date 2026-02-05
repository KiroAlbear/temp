import 'package:deel/deel.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class ProductCategoryBloc extends LoadMoreBloc<ProductMapper> {
  int categoryId = 1;
  int? subcategoryId;
  int? brandId;

  bool isNavigatingFromMore = false;
  bool isNavigationFromNotifications = false;

  NotificationType? productNotificationType;

  ValueNotifier<bool>? isLoading = ValueNotifier(false);

  static String? searchValue;
  BehaviorSubject<ApiState<List<CategoryMapper>>> subCategoryByCategoryStream =
      BehaviorSubject();
  BehaviorSubject<ApiState<List<BrandMapper>>> brandBySubcategoryStream =
      BehaviorSubject();

  List<ProductMapper> loadedProductsList = [];


  void loadMore(bool isForFavourite, Function? onGettingMoreProducts) {
    if (isForFavourite) {
      _loadWithFavourites(onGettingMoreProducts);
    } else if (searchValue != null) {
      _loadWithSearch(searchValue!);
    } else {
      _getSubcategoryBy(categoryId);
    }

  }

  void disposeReset() {
    searchValue = null;
    subcategoryId = null;
    brandId = null;
    isLoading?.value = false;
    subCategoryByCategoryStream.sink.add(LoadingState());
    brandBySubcategoryStream.sink.add(LoadingState());

    loadedListBehaviour.close();
    loadedListBehaviour.stream.drain();
    loadedListBehaviour = BehaviorSubject()..sink.add(LoadingState());
    super.reset();
  }

  @override
  void reset() {
    searchValue = null;
    subcategoryId = null;
    brandId = null;
    isLoading?.value = false;



    super.reset();
  }

  void _loadWithFavourites(Function? onGettingMoreProducts) {
    FavouriteProductRemote()
        .loadProduct(PageRequest(pageSize, pageNumber, 1,
            int.parse(SharedPrefModule().userId ?? '0')))
        .listen((event) {
      if (event is SuccessState && event.response != null) {
        _handleProductResponse(event.response);
        if (onGettingMoreProducts != null) {
          onGettingMoreProducts();
        }
      } else {
        isLoading?.value = false;
      }
    }).onError((error, stackTrace) {
      isLoading?.value = false;
    });
  }

  void handleNotificationNavigation(NotificationResponseModel responseModel) {
    getIt<ProductCategoryBloc>().isNavigationFromNotifications = true;

    if (responseModel.notificationType == NotificationType.category) {
      getIt<HomeBloc>().selectedCategoryText = responseModel.name!;
      categoryId = int.tryParse(responseModel.id!) ?? 1;

      Routes.navigateToScreen(Routes.productCategoryPage,
          NavigationType.goNamed, Routes.rootNavigatorKey.currentContext!);
    } else if (responseModel.notificationType == NotificationType.brand) {
      getIt<HomeBloc>().selectedCategoryText = responseModel.name!;
      getProductWithSubcategoryBrand(
          null, int.tryParse(responseModel.id!), null);

      Routes.navigateToScreen(Routes.productCategoryPage,
          NavigationType.goNamed, Routes.rootNavigatorKey.currentContext!);
    } else if (responseModel.notificationType == NotificationType.product) {
      getIt<HomeBloc>().selectedCategoryText = responseModel.name!;
      getProductById(int.tryParse(responseModel.id!) ?? 0);

      Routes.navigateToScreen(Routes.productCategoryPage,
          NavigationType.goNamed, Routes.rootNavigatorKey.currentContext!);
    }
  }

  Stream<ApiState<bool>> addProductToFavourite(
      {required int clientId, required int productId}) {
    return FavouriteAddProductRemote()
        .addProduct(FavouriteRequest(clientId, productId));
  }

  Stream<ApiState<bool>> removeProductFromFavourite(
      {required int clientId, required int productId}) {
    return FavouriteAddProductRemote()
        .deleteProduct(FavouriteRequest(clientId, productId));
  }

  void _loadWithSearch(String searchValue) => SearchProductRemote()
          .loadProduct(
              PageRequest(pageSize, pageNumber, categoryId,
                  int.parse(SharedPrefModule().userId ?? '0')),
              searchValue)
          .listen((event) {
        if (event is SuccessState) {
          _handleProductResponse(event.response);
        }
      });


  void _getSubcategoryBy(int categoryId) {
    SubcategoryRemote()
        .loadSubCategoryByCategoryId(categoryId,
            SubcategoryRequest(int.parse(SharedPrefModule().userId ?? '0')))
        .listen(
      (event) {
        if (event is SuccessState) {
          if (event.response != null && event.response!.isNotEmpty) {
            event.response!.insert(
                0,
                CategoryMapper(CategoryResponse(
                  id: null,
                  name: ProductCategoryPage.filterAllText,
                  image: null,
                  parentId: null,
                  parentPath: null,
                )));
            subCategoryByCategoryStream.sink
                .add(SuccessState(event.response ?? []));
            final int? selectedSubCategoryId = event.response?.first.id;
            subcategoryId = selectedSubCategoryId;
            getBrandBy(selectedSubCategoryId ?? categoryId);
          } else {
            subCategoryByCategoryStream.sink.add(SuccessState([]));
            brandBySubcategoryStream.sink.add(SuccessState([]));
            setLoaded([]);
          }
        }
      },
    );
  }

  void getBrandBy(int subCategory) {
    isLoading?.value = false;
    {
      BrandRemote()
          .loadBrandBySubCategoryId(BrandRequest(subCategory, true, 1, 100))
          .listen(
        (event) {
          if (event is SuccessState) {
            _handleBrandResponse(event.response, subCategory);
          }
        },
      );
    }
  }

  void getProductById(int productId) {
    ProductRemote().loadProductById(productId).listen((event) {
      if (event is SuccessState) {
        _handleProductResponse(event.response ?? []);
      }
    });
  }


  void getProductByIdList(List<int> productsIds){
    loadedProductsList.clear();

    for (int i = 0; i < productsIds.length; i++) {
      ProductRemote().loadProductById(productsIds[i]).listen((event) {
        if (event is SuccessState) {
          _handleProductResponse(event.response ?? []);
        }
      });
    }
  }

  void getProductWithSubcategoryBrand(
      int? subCategory, int? brand, Function? onGettingMoreProducts) {
    if ((subCategory == null)) {
      ProductRemote()
          .loadProductBySubCategoryBrand(ProductSubcategoryBrandRequest(
        categoryId,
        brand,
        true,
        pageSize,
        pageNumber,
      ))
          .listen(
        (event) {
          if (event is SuccessState &&
              (event.response?.isNotEmpty ?? false)) {
            _handleProductResponse(event.response);

            if (onGettingMoreProducts != null) {
              onGettingMoreProducts();
            }
          } else if (event.response?.isEmpty ?? false) {
            _handleProductResponse(null);
          }
        },
      );
    }

    else {
      ProductRemote()
          .loadProductBySubCategoryBrand(ProductSubcategoryBrandRequest(
        subCategory,
        brand,
        true,
        pageSize,
        pageNumber,
      ))
          .listen(
        (event) {
          if (event is SuccessState &&
              (event.response?.isNotEmpty ?? false)) {
            _handleProductResponse(event.response);

            if (onGettingMoreProducts != null) {
              onGettingMoreProducts();
            }
          } else if (event.response?.isEmpty ?? false) {
            _handleProductResponse(null);
          }
        },
      );
    }
  }

  void getProductsByBrandId(int brandId) {
    ProductRemote()
        .loadProductByBrand(ProductBrandRequest(
            brand_id: brandId, page: pageNumber, limit: pageSize))
        .listen(
      (event) {
        if (event is SuccessState &&
            (event.response?.isNotEmpty ?? false)) {
          _handleProductResponse(event.response);
        } else if (event.response?.isEmpty ?? false) {
          _handleProductResponse(null);
        }
      },
    );
  }

  void _handleBrandResponse(List<BrandMapper>? response, int? subCategory) {
    if (response != null && response.isNotEmpty) {
      response.insert(
          0,
          BrandMapper(BrandResponse(
            id: null,
            active: true,
            name: ProductCategoryPage.filterAllText,
            display_name: 'All',
          )));

      brandBySubcategoryStream.sink.add(SuccessState(response));
      int? selectedBrandId = response.first.id;

      brandId = selectedBrandId;
      getProductWithSubcategoryBrand(subCategory, selectedBrandId, null);
    } else {
      isLoading?.value = false;
      brandId = null;
      brandBySubcategoryStream.sink.add(SuccessState([]));
      setLoaded([]);
    }
  }

  void _handleProductResponse(List<ProductMapper>? response) {
    isLoading?.value = false;
    setLoaded((response) ?? []);
  }

  void doSearch(String value) {
    searchValue = value;
  }
}
