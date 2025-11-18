part of 'api_client.dart';

class _ApiClientKey {
  static const String languagePath = "langCode";
  static const String urlLanguageCode = "?lang_code={langCode}";

  static const String _login = 'app/login';
  static const String _getLanguages = 'api/v1/res/lang';
  static const String _category = 'get/category';
  static const String _brandBySubCategory = 'get/brand/by_category';
  static const String _getAllBrands = 'get/brand';
  static const String _subCategoryByCategory = '/get/category/subcategory';
  static const String _allProduct = 'get/product';
  static const String _productBySubCategoryBrand = 'get/product/by_category';
  static const String _productByBrand = 'get/product/by_brand';
  static const String _favouriteProduct = 'get/fav';
  static const String _searchProduct = 'search/product';
  static const String _addFavourite = 'add/favorite';
  static const String _deleteFavourite = 'delete/fav';
  static const String _signUp = 'app/signup';
  static const String _balance = 'get/wallet';
  static const String _changePassword = 'reset/password';
  static const String _resetPassword = 'app/set/password';
  static const String _getCompanyType = '/get/company_type';

  static const String _updateProfileImage = 'app/update_image';
  static const String _deActiveProfile = 'profile/deactivate';
  static const String _updateAddress = 'app/update_address';
  static const String _getProfile = 'get/profile';
  static const String _getCountry = 'get/country?lang_code=ar_001';
  static const String _checkPhone = 'app/checkphone';
  static const String _getState = 'get/state';
  static const String _deliveryAddress = 'get/delivery_address/';
  static const String _updateProfile = 'update/profile';
  static const String _myOrders = 'get/all_order';
  static const String _getCart = 'view/card_items';
  static const String _saveToCart = 'saleorder/create';
  static const String _getCartMinimumOrder = 'api/v1/order/minimum_limit';
  static const String _cancelOrder = 'order/cancel';
  static const String _checkAvailability = 'get/available_quantity';
  static const String _confirmOrder = 'saleorder/confirm';
}
