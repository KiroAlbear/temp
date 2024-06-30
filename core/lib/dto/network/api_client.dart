import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/header_response.dart';
import 'package:core/dto/models/category/category_response.dart';
import 'package:core/dto/models/login/login_request.dart';
import 'package:core/dto/models/login/login_response.dart';
import 'package:core/dto/models/my_orders/my_orders_response.dart';
import 'package:core/dto/models/page_request.dart';
import 'package:core/dto/models/product/favourite_product_response.dart';
import 'package:core/dto/models/product/product_response.dart';
import 'package:core/dto/models/product/search_product_request.dart';

part 'api_client.g.dart';
part 'api_client_key.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(_ApiClientKey._login)
  Future<HeaderResponse<LoginResponse>> login(@Body() LoginRequest request);

  @POST(_ApiClientKey._signUp)
  Future<HeaderResponse<LoginResponse>> signUp(@Body() LoginRequest request);

  @POST(_ApiClientKey._category)
  Future<HeaderResponse<List<CategoryResponse>>> category(
      @Body() PageRequest request);

  @POST(_ApiClientKey._allProduct)
  Future<HeaderResponse<List<ProductResponse>>> getAllProduct(
      @Body() PageRequest request);

  @POST(_ApiClientKey._productByCategory)
  Future<HeaderResponse<List<ProductResponse>>> getProductByCategory(
      @Body() PageRequest request);

  @POST(_ApiClientKey._favouriteProduct)
  Future<HeaderResponse<List<FavouriteProductResponse>>> getFavouriteProduct(
      @Body() PageRequest request);

  @POST(_ApiClientKey._searchProduct)
  Future<HeaderResponse<List<ProductResponse>>> searchProduct(
      @Body() SearchProductRequest request);

  @GET(_ApiClientKey._myOrders)
  Future<HeaderResponse<MyOrdersResponse>> getMyOrders();
}
