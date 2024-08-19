import 'package:core/dto/commonBloc/load_more_bloc.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/brand/brand_mapper.dart';
import 'package:core/dto/models/brand/brand_request.dart';
import 'package:core/dto/models/category/subcategory_request.dart';
import 'package:core/dto/models/home/category_mapper.dart';
import 'package:core/dto/models/favourite/favourite_request.dart';
import 'package:core/dto/models/page_request.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/dto/models/product_subcategory_brand_request.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/remote/brand_remote.dart';
import 'package:core/dto/models/product/product_request.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/remote/favourite_add_product_remote.dart';
import 'package:core/dto/remote/favourite_product_remote.dart';
import 'package:core/dto/remote/product_remote.dart';
import 'package:core/dto/remote/search_product_remote.dart';
import 'package:core/dto/remote/subcategory_remote.dart';
import 'package:core/dto/remote/product_remote.dart';
import 'package:core/dto/remote/search_product_remote.dart';

class ProductCategoryBloc extends LoadMoreBloc<ProductMapper> {
  int categoryId = 1;

  bool isForFavourite = false;

  String? _searchValue;

  Stream<ApiState<List<ProductMapper>>> loadMore() async* {
    Stream<ApiState<List<CategoryMapper>>> subCategoryByCategoryStream =
        _getSubcategoryByCategory(1);

    subCategoryByCategoryStream.listen((event) {
      if (event is SuccessState) {
        print("Subcategory: ${event.response}");
      }
    });

    Stream<ApiState<List<BrandMapper>>> brandBySubcategoryStream =
        _getBrandBySubcategoryId(12);

    brandBySubcategoryStream.listen((event) {
      if (event is SuccessState) {
        print("Brand: ${event.response}");
      }
    });

    Stream<ApiState<List<ProductMapper>>> productBySubCategoryBrandStream =
        _loadProductWithSubcategoryBrand(12, 1);

    productBySubCategoryBrandStream.listen((event) {
      if (event is SuccessState) {
        setLoaded(event.response ?? []);
      }
    });

    // Stream<ApiState<List<ProductMapper>>> stream = isForFavourite
    //     ? loadWithFavourites
    //     : _searchValue != null
    //         ? _loadWithSearch(_searchValue!)
    //         : loadWithSubCategory;
    // stream.listen((event) {
    //   if (event is SuccessState) {
    //     setLoaded(event.response ?? []);
    //   }
    // });
    yield* loadedListStream;
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
          .loadProduct(PageRequest(pageSize, pageNumber, categoryId, null));

  Stream<ApiState<List<ProductMapper>>> _loadProductWithSubcategoryBrand(
          int subCategory, int brand) =>
      ProductRemote().loadProductBySubCategoryBrand(
          ProductSubcategoryBrandRequest(subCategory, brand));

  Stream<ApiState<List<BrandMapper>>> _getBrandBySubcategoryId(
          int subCategory) =>
      BrandRemote().loadBrandBySubCategoryId(BrandRequest(subCategory, 1, 1));

  Stream<ApiState<List<CategoryMapper>>> _getSubcategoryByCategory(
          int subCategory) =>
      SubcategoryRemote().loadSubCategoryByCategoryId(subCategory,
          SubcategoryRequest(int.parse(SharedPrefModule().userId ?? '0')));

  void doSearch(String value) {
    _searchValue = value;
  }
}
