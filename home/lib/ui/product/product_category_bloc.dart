import 'package:core/core.dart';
import 'package:core/dto/commonBloc/load_more_bloc.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/brand/brand_mapper.dart';
import 'package:core/dto/models/brand/brand_request.dart';
import 'package:core/dto/models/brand/brand_response.dart';
import 'package:core/dto/models/category/subcategory_request.dart';
import 'package:core/dto/models/favourite/favourite_request.dart';
import 'package:core/dto/models/home/category_mapper.dart';
import 'package:core/dto/models/page_request.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/dto/models/product/product_request.dart';
import 'package:core/dto/models/product_subcategory_brand_request.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/remote/brand_remote.dart';
import 'package:core/dto/remote/favourite_add_product_remote.dart';
import 'package:core/dto/remote/favourite_product_remote.dart';
import 'package:core/dto/remote/product_remote.dart';
import 'package:core/dto/remote/search_product_remote.dart';
import 'package:core/dto/remote/subcategory_remote.dart';
import 'package:flutter/cupertino.dart';

class ProductCategoryBloc extends LoadMoreBloc<ProductMapper> {
  int categoryId = 1;
  int subcategoryId = 0;
  int? brandId;

  bool isForFavourite = false;
  ValueNotifier<bool>? isLoading = null;

  String? _searchValue;
  BehaviorSubject<ApiState<List<CategoryMapper>>> subCategoryByCategoryStream =
      BehaviorSubject();
  BehaviorSubject<ApiState<List<BrandMapper>>> brandBySubcategoryStream =
      BehaviorSubject();
  // BehaviorSubject<ApiState<List<ProductMapper>>>
  //     productBySubCategoryBrandStream = BehaviorSubject();

  void loadMore() {
    // await loadedListStream.drain();

    _getSubcategoryByCategory(1);
  }

  Stream<ApiState<List<ProductMapper>>> get loadWithFavourites {
    return FavouriteProductRemote().loadProduct(PageRequest(
        pageSize, pageNumber, 1, int.parse(SharedPrefModule().userId ?? '0')));
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

  Stream<ApiState<List<ProductMapper>>> _loadWithSearch(String searchValue) =>
      SearchProductRemote().loadProduct(
          PageRequest(pageSize, pageNumber, categoryId,
              int.parse(SharedPrefModule().userId ?? '0')),
          searchValue);

  Stream<ApiState<List<ProductMapper>>> get loadWithSubCategory =>
      ProductRemote()
          .loadProduct(ProductRequest(pageSize, pageNumber, categoryId));

  void getProductWithSubcategoryBrand(int subCategory, int? brand) {
    ProductRemote()
        .loadProductBySubCategoryBrand(
            ProductSubcategoryBrandRequest(subCategory, brand))
        .listen(
      (event) {
        if (event is SuccessState) {
          isLoading?.value = false;
          setLoaded(event.response ?? []);

          // productBySubCategoryBrandStream.sink
          //     .add(SuccessState(event.response ?? []));
        }
      },
    );
  }

  void getBrandBySubcategoryId(int subCategory) {
    isLoading?.value = true;
    BrandRemote()
        .loadBrandBySubCategoryId(BrandRequest(subCategory, 1, 100))
        .listen(
      (event) {
        if (event is SuccessState) {
          if (event.response!.isNotEmpty) {
            event.response!.insert(
                0,
                BrandMapper(BrandResponse(
                  id: null,
                  active: true,
                  name: 'All',
                  display_name: 'All',
                )));

            brandBySubcategoryStream.sink
                .add(SuccessState(event.response ?? []));
            int? selectedBrandId = event.response!.first.id;

            brandId = selectedBrandId;
            getProductWithSubcategoryBrand(subCategory, selectedBrandId);
          } else {
            isLoading?.value = false;
            brandBySubcategoryStream.sink.add(SuccessState([]));
            setLoaded([]);
          }
        }
      },
    );
  }

  void _getSubcategoryByCategory(int categoryId) {
    SubcategoryRemote()
        .loadSubCategoryByCategoryId(categoryId,
            SubcategoryRequest(int.parse(SharedPrefModule().userId ?? '0')))
        .listen(
      (event) {
        if (event is SuccessState) {
          // print("Subcategory: ${event.response}");
          if (event.response!.isNotEmpty) {
            subCategoryByCategoryStream.sink
                .add(SuccessState(event.response ?? []));
            // int selectedSubCategoryId = 12; // this is for testing
            int selectedSubCategoryId = event.response!.first.id;
            subcategoryId = selectedSubCategoryId;
            // _getBrandBySubcategoryId(event.response!.first.id);
            getBrandBySubcategoryId(selectedSubCategoryId);
          }
        }
      },
    );
  }

  void doSearch(String value) {
    _searchValue = value;
  }
}
