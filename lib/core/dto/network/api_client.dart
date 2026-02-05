import 'package:deel/deel.dart';
import 'package:retrofit/error_logger.dart';

import 'package:retrofit/http.dart' as http;

part 'api_client.g.dart';
part 'api_client_key.dart';

@http.RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @http.GET(_ApiClientKey._getLanguages)
  Future<HeaderResponse<List<LanguageResponseModel>>> getLanguages();

  @http.POST(_ApiClientKey._login)
  Future<HeaderResponse<List<LoginResponse>>> login(
    @http.Body() LoginRequest request,
  );

  @http.POST("${_ApiClientKey._getCompanyType}${_ApiClientKey.urlLanguageCode}")
  Future<HeaderResponse<List<CompanyTypeResponseModel>>> getCompanyType(
    @http.Path(_ApiClientKey.languagePath) String langCode,
  );

  @http.POST("${_ApiClientKey._category}${_ApiClientKey.urlLanguageCode}")
  Future<HeaderResponse<List<CategoryResponse>>> category(
    @http.Body() PageRequest request,
    @http.Path(_ApiClientKey.languagePath) String langCode,
  );

  @http.GET(
    "${_ApiClientKey._subCategoryByCategory}/{categoryId}${_ApiClientKey.urlLanguageCode}",
  )
  Future<HeaderResponse<List<CategoryResponse>>> getSubCategoryByCategoryId(
    @http.Path() String categoryId,
    @http.Body() SubcategoryRequest request,
    @http.Path(_ApiClientKey.languagePath) String lang_code,
  );

  @http.POST(
    "${_ApiClientKey._brandBySubCategory}${_ApiClientKey.urlLanguageCode}",
  )
  Future<HeaderResponse<List<BrandResponse>>> getBrandBySubCategory(
    @http.Body() BrandRequest request,
    @http.Path(_ApiClientKey.languagePath) String lang_code,
  );

  @http.POST("${_ApiClientKey._getAllBrands}${_ApiClientKey.urlLanguageCode}")
  Future<HeaderResponse<List<BrandResponse>>> getAllBrands(
    @http.Body() AllBrandsRequest request,
    @http.Path(_ApiClientKey.languagePath) String lang_code,
  );

  @http.POST(_ApiClientKey._allProduct)
  Future<HeaderResponse<List<ProductResponse>>> getAllProduct(
    @http.Body() ProductRequest request,
  );

  @http.POST("${_ApiClientKey._allProduct}/{productId}")
  Future<HeaderResponse<List<ProductResponse>>> getProductById(
    @http.Path() String productId,
  );

  @http.POST(
    "${_ApiClientKey._productBySubCategoryBrand}${_ApiClientKey.urlLanguageCode}",
  )
  Future<HeaderResponse<List<ProductResponse>>> getProductBySubCategoryBrand(
    @http.Body() ProductSubcategoryBrandRequest request,
    @http.Path(_ApiClientKey.languagePath) String lang_code,
  );

  @http.POST("${_ApiClientKey._productByBrand}${_ApiClientKey.urlLanguageCode}")
  Future<HeaderResponse<List<ProductResponse>>> getProductByBrand(
    @http.Body() ProductBrandRequest request,
    @http.Path(_ApiClientKey.languagePath) String lang_code,
  );

  @http.POST(_ApiClientKey._favouriteProduct)
  Future<HeaderResponse<List<FavouriteProductResponse>>> getFavouriteProduct(
    @http.Body() PageRequest request,
  );

  @http.POST(_ApiClientKey._addFavourite)
  Future<HeaderResponse<List<FavouriteResponse>>> addProductToFavourite(
    @http.Body() FavouriteRequest request,
  );

  @http.POST(_ApiClientKey._deleteFavourite)
  Future<HeaderResponse<List<FavouriteResponse>>> deleteProductFromFavourite(
    @http.Body() FavouriteRequest request,
  );

  @http.POST("${_ApiClientKey._searchProduct}${_ApiClientKey.urlLanguageCode}")
  Future<HeaderResponse<List<ProductResponse>>> searchProduct(
    @http.Body() SearchProductRequest request,
    @http.Path(_ApiClientKey.languagePath) String lang_code,
  );

  @http.POST(_ApiClientKey._myOrders)
  Future<HeaderResponse<List<MyOrdersResponse>>> getMyOrders(
    @http.Body() MyOrdersRequest request,
  );

  @http.POST(_ApiClientKey._getCart)
  Future<HeaderResponse<List<MyOrderItemResponse>>> getMyCart(
    @http.Body() CartRequest request,
  );

  @http.POST(_ApiClientKey._getCartMinimumOrder)
  Future<HeaderResponse<List<CartMinimumOrderResponse>>> getCartMinimumOrder(
    @http.Body() CartMinimumOrderRequest request,
  );

  @http.POST(_ApiClientKey._saveToCart)
  Future<HeaderResponse<List<CartSaveResponse>>> saveToCart(
    @http.Body() CartSaveRequest request,
  );

  @http.POST(_ApiClientKey._saveToCart)
  Future<HeaderResponse<List<CartSaveResponse>>> editCart(
    @http.Body() CartEditRequest request,
  );

  @http.POST(_ApiClientKey._checkAvailability)
  Future<HeaderResponse<List<CartCheckAvailabilityResponse>>> checkAvailability(
    @http.Body() CartCheckAvailabilityRequest request,
  );

  @http.POST(_ApiClientKey._confirmOrder)
  Future<HeaderResponse<List<CartConfirmOrderResponse>>> confirmOrder(
    @http.Body() CartConfirmOrderRequest request,
  );

  @http.POST(_ApiClientKey._cancelOrder)
  Future<HeaderResponse<List<CartConfirmOrderResponse>>> cancelOrder(
    @http.Body() OrderCancelRequest request,
  );

  @http.POST(_ApiClientKey._signUp)
  Future<HeaderResponse<List<LoginResponse>>> register(
    @http.Body() RegisterRequest request,
  );

  @http.POST(_ApiClientKey._balance)
  Future<HeaderResponse<List<BalanceResponse>>> getBalance(
    @http.Body() ClientRequest request,
  );

  @http.POST(_ApiClientKey._changePassword)
  Future<HeaderResponse> changePassword(
    @http.Body() ChangePasswordRequest request,
  );

  @http.POST(_ApiClientKey._resetPassword)
  Future<HeaderResponse> resetPassword(
    @http.Body() ResetPasswordRequest request,
  );

  @http.PUT('${_ApiClientKey._updateProfileImage}/{mobileNumber}')
  @http.MultiPart()
  @http.Headers(<String, dynamic>{'Content-Type': 'multipart/form-data'})
  Future<HeaderResponse<LoginResponse>> updateProfileImage(
    @http.Path("mobileNumber") String mobileNumber,
    @http.Part() File file,
  );

  @http.POST(_ApiClientKey._deActiveProfile)
  Future<HeaderResponse> deActiveProfile(@http.Body() PhoneRequest request);

  @http.PUT(_ApiClientKey._updateAddress)
  Future<HeaderResponse<LoginResponse>> updateAddress(
    @http.Body() AddressRequest request,
  );

  @http.GET('${_ApiClientKey._deliveryAddress}/{userId}')
  Future<HeaderResponse<List<DeliveryAddressResponse>>> getDeliveryAddress(
    @http.Path("userId") String userId,
  );

  @http.PUT(_ApiClientKey._updateProfile)
  Future<HeaderResponse> updateProfile(
    @http.Body() UpdateProfileRequestBody body,
  );

  @http.POST(_ApiClientKey._getProfile)
  Future<HeaderResponse<ProfileResponse>> getProfile(
    @http.Body() ClientRequest request,
  );

  @http.POST(_ApiClientKey._getCountry)
  Future<HeaderResponse<List<CountryResponse>>> getCountry();

  @http.POST(_ApiClientKey._checkPhone)
  Future<HeaderResponse<List<CheckPhoneResponse>>> checkPhone(
    @http.Body() CheckPhoneRequest request,
  );

  @http.POST('${_ApiClientKey._getState}${_ApiClientKey.urlLanguageCode}')
  Future<HeaderResponse<List<StateResponse>>> getState(
    @http.Body() StateRequest request,
    @http.Path(_ApiClientKey.languagePath) String lang_code,
  );

  @http.POST('${_ApiClientKey._getDistrict}${_ApiClientKey.urlLanguageCode}')
  Future<HeaderResponse<List<StateResponse>>> getDistrict(
    @http.Body() DistrictRequest request,
    @http.Path(_ApiClientKey.languagePath) String lang_code,
  );
}
