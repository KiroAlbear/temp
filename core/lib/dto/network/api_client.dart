import 'package:core/core.dart';
import 'package:core/dto/models/address/address_request.dart';
import 'package:core/dto/models/balance/balance_response.dart';
import 'package:core/dto/models/baseModules/header_response.dart';
import 'package:core/dto/models/brand/all_brands_request.dart';
import 'package:core/dto/models/brand/brand_request.dart';
import 'package:core/dto/models/brand/brand_response.dart';
import 'package:core/dto/models/category/category_response.dart';
import 'package:core/dto/models/checkPhone/check_phone_request.dart';
import 'package:core/dto/models/checkPhone/check_phone_response.dart';
import 'package:core/dto/models/client/client_request.dart';
import 'package:core/dto/models/country/country_response.dart';
import 'package:core/dto/models/favourite/favourite_request.dart';
import 'package:core/dto/models/favourite/favourite_response.dart';
import 'package:core/dto/models/login/login_request.dart';
import 'package:core/dto/models/login/login_response.dart';
import 'package:core/dto/models/my_orders/my_orders_request.dart';
import 'package:core/dto/models/my_orders/my_orders_response.dart';
import 'package:core/dto/models/page_request.dart';
import 'package:core/dto/models/password/change_password_request.dart';
import 'package:core/dto/models/phone/phone_request.dart';
import 'package:core/dto/models/product/favourite_product_response.dart';
import 'package:core/dto/models/product/product_request.dart';
import 'package:core/dto/models/product/product_response.dart';
import 'package:core/dto/models/product/search_product_request.dart';
import 'package:core/dto/models/product_brand_request.dart';
import 'package:core/dto/models/product_subcategory_brand_request.dart';
import 'package:core/dto/models/profile/profile_response.dart';
import 'package:core/dto/models/register/register_request.dart';
import 'package:core/dto/models/state/state_request.dart';
import 'package:core/dto/models/state/state_response.dart';
import 'package:core/dto/models/update_profile/update_profile_request.dart';

import '../models/category/subcategory_request.dart';
import '../models/update_profile/delivery_address_response.dart';

part 'api_client.g.dart';
part 'api_client_key.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(_ApiClientKey._login)
  Future<HeaderResponse<List<LoginResponse>>> login(
      @Body() LoginRequest request);

  @POST(_ApiClientKey._category)
  Future<HeaderResponse<List<CategoryResponse>>> category(
      @Body() PageRequest request);

  @GET("${_ApiClientKey._subCategoryByCategory}/{categoryId}")
  Future<HeaderResponse<List<CategoryResponse>>> getSubCategoryByCategoryId(
      @Path() String categoryId, @Body() SubcategoryRequest request);

  @POST(_ApiClientKey._brandBySubCategory)
  Future<HeaderResponse<List<BrandResponse>>> getBrandBySubCategory(
      @Body() BrandRequest request);

  @POST(_ApiClientKey._getAllBrands)
  Future<HeaderResponse<List<BrandResponse>>> getAllBrands(
      @Body() AllBrandsRequest request);

  @POST(_ApiClientKey._allProduct)
  Future<HeaderResponse<List<ProductResponse>>> getAllProduct(
      @Body() ProductRequest request);

  @GET(_ApiClientKey._productBySubCategoryBrand)
  Future<HeaderResponse<List<ProductResponse>>> getProductBySubCategoryBrand(
      @Body() ProductSubcategoryBrandRequest request);

  @POST(_ApiClientKey._productByBrand)
  Future<HeaderResponse<List<ProductResponse>>> getProductByBrand(
      @Body() ProductBrandRequest request);

  @POST(_ApiClientKey._favouriteProduct)
  Future<HeaderResponse<List<FavouriteProductResponse>>> getFavouriteProduct(
      @Body() PageRequest request);

  @POST(_ApiClientKey._addFavourite)
  Future<HeaderResponse<List<FavouriteResponse>>> addProductToFavourite(
      @Body() FavouriteRequest request);

  @POST(_ApiClientKey._deleteFavourite)
  Future<HeaderResponse<List<FavouriteResponse>>> deleteProductFromFavourite(
      @Body() FavouriteRequest request);

  @POST(_ApiClientKey._searchProduct)
  Future<HeaderResponse<List<ProductResponse>>> searchProduct(
      @Body() SearchProductRequest request);

  @POST(_ApiClientKey._myOrders)
  Future<HeaderResponse<List<MyOrdersResponse>>> getMyOrders(
      @Body() MyOrdersRequest request);

  @POST(_ApiClientKey._signUp)
  Future<HeaderResponse<List<LoginResponse>>> register(
      @Body() RegisterRequest request);

  @POST(_ApiClientKey._balance)
  Future<HeaderResponse<List<BalanceResponse>>> getBalance(
      @Body() ClientRequest request);

  @POST(_ApiClientKey._changePassword)
  Future<HeaderResponse> changePassword(@Body() ChangePasswordRequest request);

  @PUT('${_ApiClientKey._updateProfileImage}/{mobileNumber}')
  @MultiPart()
  @Headers(<String, dynamic>{
    'Content-Type': 'multipart/form-data',
  })
  Future<HeaderResponse<LoginResponse>> updateProfileImage(
    @Path("mobileNumber") String mobileNumber,
    @Part() File file,
  );

  @PUT(_ApiClientKey._deActiveProfile)
  Future<HeaderResponse> deActiveProfile(@Body() PhoneRequest request);

  @PUT(_ApiClientKey._updateAddress)
  Future<HeaderResponse<LoginResponse>> updateAddress(
      @Body() AddressRequest request);

  @GET('${_ApiClientKey._deliveryAddress}/{userId}')
  Future<HeaderResponse<List<DeliveryAddressResponse>>> getDeliveryAddress(
      @Path("userId") String userId);

  @PUT(_ApiClientKey._updateProfile)
  Future<HeaderResponse> updateProfile(@Body() UpdateProfileRequestBody body);

  @POST(_ApiClientKey._getProfile)
  Future<HeaderResponse<ProfileResponse>> getProfile(
      @Body() ClientRequest request);

  @POST(_ApiClientKey._getCountry)
  Future<HeaderResponse<List<CountryResponse>>> getCountry();

  @GET(_ApiClientKey._checkPhone)
  Future<HeaderResponse<List<CheckPhoneResponse>>> checkPhone(
      @Body() CheckPhoneRequest request);

  @POST(_ApiClientKey._getState)
  Future<HeaderResponse<List<StateResponse>>> getState(
      @Body() StateRequest request);
}
