import 'package:deel/deel.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class ProductCategoryBloc extends LoadMoreBloc<ProductMapper> {
  int categoryId = 1;
  int? subcategoryId;
  int? brandId;

  // bool isForFavourite = false;
  bool isNavigatingFromMore = false;
  ValueNotifier<bool>? isLoading = null;

  static String? searchValue;
  BehaviorSubject<ApiState<List<CategoryMapper>>> subCategoryByCategoryStream =
      BehaviorSubject();
  BehaviorSubject<ApiState<List<BrandMapper>>> brandBySubcategoryStream =
      BehaviorSubject();
  // BehaviorSubject<ApiState<List<ProductMapper>>>
  //     productBySubCategoryBrandStream = BehaviorSubject();

  void loadMore(bool isForFavourite) {
    // await loadedListStream.drain();
    Stream<ApiState<List<ProductMapper>>> stream = Stream.empty();
    if (isForFavourite) {
      _loadWithFavourites();
    } else if (searchValue != null) {
      _loadWithSearch(searchValue!);
    } else {
      _getSubcategoryBy(categoryId);
    }

    // stream.listen((event) {
    //   if (event is SuccessState) {
    //     setLoaded(event.response ?? []);
    //   }
    // });
  }

  void reset() {
    searchValue = null;
    subcategoryId = null;
    brandId = null;
    isLoading?.value = false;
    subCategoryByCategoryStream.sink.add(LoadingState());
    brandBySubcategoryStream.sink.add(LoadingState());
    super.reset();
  }

  void _loadWithFavourites() {
    FavouriteProductRemote()
        .loadProduct(PageRequest(pageSize, pageNumber, 1,
            int.parse(SharedPrefModule().userId ?? '0')))
        .listen((event) {
      if (event is SuccessState && event.response != null) {
        _handleProductResponse(event.response);
      }
    });
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

  // Stream<ApiState<List<ProductMapper>>> get getAllProducts =>
  //     ProductRemote()
  //         .loadProduct(ProductRequest(pageSize, pageNumber, categoryId));

  void _getSubcategoryBy(int categoryId) {
    SubcategoryRemote()
        .loadSubCategoryByCategoryId(categoryId,
            SubcategoryRequest(int.parse(SharedPrefModule().userId ?? '0')))
        .listen(
      (event) {
        if (event is SuccessState) {
          // print("Subcategory: ${event.response}");
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
            // int selectedSubCategoryId = 12; // this is for testing
            int? selectedSubCategoryId = event.response!.first.id;
            subcategoryId = selectedSubCategoryId;
            // _getBrandBySubcategoryId(event.response!.first.id);
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
    isLoading?.value = true;
    // if (subCategory == null) {
    //   BrandRemote().loadAllBrands(AllBrandsRequest(1, 1000)).listen(
    //     (event) {
    //       if (event is SuccessState) {
    //         _handleBrandResponse(event.response, subCategory);
    //       }
    //     },
    //   );
    // } else
    {
      BrandRemote()
          .loadBrandBySubCategoryId(BrandRequest(subCategory!, true, 1, 100))
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

  void getProductWithSubcategoryBrand(
      int? subCategory, int? brand, Function? onGettingMoreProducts) {
    if ((subCategory == null && brand == null)) {
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
              event.response != null &&
              event.response!.isNotEmpty) {
            _handleProductResponse(event.response);

            if (onGettingMoreProducts != null) {
              onGettingMoreProducts();
            }
          } else if (event.response != null && event.response!.isEmpty) {
            _handleProductResponse(null);
          }
        },
      );
    } else if (subCategory == null && brand != null) {
      ProductRemote()
          .loadProductByBrand(ProductBrandRequest(
              brand_id: brand, page: pageNumber, limit: pageSize))
          .listen(
        (event) {
          if (event is SuccessState &&
              event.response != null &&
              event.response!.isNotEmpty) {
            _handleProductResponse(event.response);

            if (onGettingMoreProducts != null) {
              onGettingMoreProducts();
            }
          } else if (event.response != null && event.response!.isEmpty) {
            _handleProductResponse(null);
          }
        },
      );
    } else {
      ProductRemote()
          .loadProductBySubCategoryBrand(ProductSubcategoryBrandRequest(
        subCategory!,
        brand,
        true,
        pageSize,
        pageNumber,
      ))
          .listen(
        (event) {
          if (event is SuccessState &&
              event.response != null &&
              event.response!.isNotEmpty) {
            _handleProductResponse(event.response);

            if (onGettingMoreProducts != null) {
              onGettingMoreProducts();
            }
          } else if (event.response != null && event.response!.isEmpty) {
            _handleProductResponse(null);
          }
        },
      );
    }
  }

  void _handleBrandResponse(List<BrandMapper>? response, int? subCategory) {
    if (response != null && response!.isNotEmpty) {
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
