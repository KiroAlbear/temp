import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/page_request.dart';
import 'package:core/dto/remote/search_product_remote.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/remote/product_remote.dart';
import 'package:core/dto/commonBloc/load_more_bloc.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/dto/remote/favourite_product_remote.dart';

class ProductCategoryBloc extends LoadMoreBloc<ProductMapper> {
  int categoryId = 1;

  bool isForFavourite = false;

  String? _searchValue;

  Stream<ApiState<List<ProductMapper>>> loadMore() async* {
    Stream<ApiState<List<ProductMapper>>> stream = isForFavourite
        ? loadWithFavourites
        : _searchValue != null
            ? _loadWithSearch(_searchValue!)
            : loadWithSubCategory;
    stream.listen((event) {
      if (event is SuccessState) {
        setLoaded(event.response ?? []);
      }
    });
    yield* loadedListStream;
  }

  Stream<ApiState<List<ProductMapper>>> get loadWithFavourites {
    return FavouriteProductRemote().loadProduct(PageRequest(
        pageSize, pageNumber, 1, int.parse(SharedPrefModule().userId ?? '0')));
  }

  Stream<ApiState<List<ProductMapper>>> _loadWithSearch(String searchValue) =>
      SearchProductRemote().loadProduct(
          PageRequest(pageSize, pageNumber, categoryId,
              int.parse(SharedPrefModule().userId ?? '0')),
          searchValue);

  Stream<ApiState<List<ProductMapper>>> get loadWithSubCategory =>
      ProductRemote()
          .loadProduct(PageRequest(pageSize, pageNumber, categoryId, null));

  void doSearch(String value) {
    _searchValue = value;
  }
}
