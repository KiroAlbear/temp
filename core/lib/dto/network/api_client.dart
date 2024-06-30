import 'package:core/core.dart';
import 'package:core/dto/models/address/address_request.dart';
import 'package:core/dto/models/balance/balance_response.dart';
import 'package:core/dto/models/baseModules/header_response.dart';
import 'package:core/dto/models/category/category_response.dart';
import 'package:core/dto/models/client/client_request.dart';
import 'package:core/dto/models/login/login_request.dart';
import 'package:core/dto/models/login/login_response.dart';
import 'package:core/dto/models/page_request.dart';
import 'package:core/dto/models/password/change_password_request.dart';
import 'package:core/dto/models/phone/phone_request.dart';
import 'package:core/dto/models/product/favourite_product_response.dart';
import 'package:core/dto/models/product/product_response.dart';
import 'package:core/dto/models/product/search_product_request.dart';
import 'package:core/dto/models/register/register_request.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

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

  @POST(_ApiClientKey._signUp)
  Future<HeaderResponse<LoginResponse>> register(
      @Body() RegisterRequest request);

  @POST(_ApiClientKey._balance)
  Future<HeaderResponse<BalanceResponse>> getBalance(
      @Body() ClientRequest request);

  @POST(_ApiClientKey._changePassword)
  Future<HeaderResponse> changePassword(
      @Body() ChangePasswordRequest request);

  @PUT('${_ApiClientKey._updateProfileImage}/{mobileNumber}')
  Future<HeaderResponse<LoginResponse>> updateProfileImage(
      @Path("mobileNumber") String mobileNumber,
      @Part(fileName: 'image') File file);

  @PUT(_ApiClientKey._deActiveProfile)
  Future<HeaderResponse> deActiveProfile(@Body() PhoneRequest request);

  @PUT(_ApiClientKey._updateAddress)
  Future<HeaderResponse<LoginResponse>> updateAddress(@Body() AddressRequest request);

  @POST(_ApiClientKey._getProfile)
  Future<HeaderResponse<LoginResponse>> getProfile(@Body() ClientRequest request);
}
