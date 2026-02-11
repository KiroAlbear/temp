import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'loc_ar.dart';
import 'loc_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of Loc
/// returned by `Loc.of(context)`.
///
/// Applications need to include `Loc.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/loc.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Loc.localizationsDelegates,
///   supportedLocales: Loc.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Loc.supportedLocales
/// property.
abstract class Loc {
  Loc(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Loc? of(BuildContext context) {
    return Localizations.of<Loc>(context, Loc);
  }

  static const LocalizationsDelegate<Loc> delegate = _LocDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @accountBalance.
  ///
  /// In en, this message translates to:
  /// **'Account balance'**
  String get accountBalance;

  /// No description provided for @confirmLocation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Location'**
  String get confirmLocation;

  /// No description provided for @accountInfo.
  ///
  /// In en, this message translates to:
  /// **'Account info'**
  String get accountInfo;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCart;

  /// No description provided for @addAllProductsToCart.
  ///
  /// In en, this message translates to:
  /// **'Add all products to cart'**
  String get addAllProductsToCart;

  /// No description provided for @changePasswordError.
  ///
  /// In en, this message translates to:
  /// **'Error in changing password'**
  String get changePasswordError;

  /// No description provided for @atLeastOneCapChar.
  ///
  /// In en, this message translates to:
  /// **'At least one capital letter'**
  String get atLeastOneCapChar;

  /// No description provided for @atLeastOneNumber.
  ///
  /// In en, this message translates to:
  /// **'Must contain numbers'**
  String get atLeastOneNumber;

  /// No description provided for @atLeastOneSmallLetter.
  ///
  /// In en, this message translates to:
  /// **'Must contain letters'**
  String get atLeastOneSmallLetter;

  /// No description provided for @atLeastOneSpecialCharacter.
  ///
  /// In en, this message translates to:
  /// **'At least one special Character'**
  String get atLeastOneSpecialCharacter;

  /// No description provided for @basket.
  ///
  /// In en, this message translates to:
  /// **'Basket'**
  String get basket;

  /// No description provided for @bestOffers.
  ///
  /// In en, this message translates to:
  /// **'Best offers'**
  String get bestOffers;

  /// No description provided for @lastOffers.
  ///
  /// In en, this message translates to:
  /// **'Last offers'**
  String get lastOffers;

  /// No description provided for @biometricLoginMessage.
  ///
  /// In en, this message translates to:
  /// **'Please authenticate to login'**
  String get biometricLoginMessage;

  /// No description provided for @browseSections.
  ///
  /// In en, this message translates to:
  /// **'Browse sections'**
  String get browseSections;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancelOrder;

  /// No description provided for @cartCashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get cartCashOnDelivery;

  /// No description provided for @payCashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Pay Cash on delivery'**
  String get payCashOnDelivery;

  /// No description provided for @cartConfirmOrder.
  ///
  /// In en, this message translates to:
  /// **'Confirm order'**
  String get cartConfirmOrder;

  /// No description provided for @cartDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to remove the product from the cart?'**
  String get cartDeleteMessage;

  /// No description provided for @cartDokkanWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get cartDokkanWallet;

  /// No description provided for @cartDokkanWalletNumber.
  ///
  /// In en, this message translates to:
  /// **'Wallet Number'**
  String get cartDokkanWalletNumber;

  /// No description provided for @cartDokkanBankCard.
  ///
  /// In en, this message translates to:
  /// **'Bank Card'**
  String get cartDokkanBankCard;

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'There is no orders'**
  String get cartEmpty;

  /// No description provided for @cartMaximumProductsReached.
  ///
  /// In en, this message translates to:
  /// **'The maximum quantity you can add to this product is'**
  String get cartMaximumProductsReached;

  /// No description provided for @cartMinimumOrder.
  ///
  /// In en, this message translates to:
  /// **'Minimum order !'**
  String get cartMinimumOrder;

  /// No description provided for @cartMinimumProductsReached.
  ///
  /// In en, this message translates to:
  /// **'The minimum amount you can add to this product is'**
  String get cartMinimumProductsReached;

  /// No description provided for @cartOrderNow.
  ///
  /// In en, this message translates to:
  /// **'Order now'**
  String get cartOrderNow;

  /// No description provided for @cartOrderOrderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order details'**
  String get cartOrderOrderDetails;

  /// No description provided for @cartPaymentOptions.
  ///
  /// In en, this message translates to:
  /// **'Choose payment method'**
  String get cartPaymentOptions;

  /// No description provided for @cartProductDetails.
  ///
  /// In en, this message translates to:
  /// **'Products Details'**
  String get cartProductDetails;

  /// No description provided for @cartProductsSummary.
  ///
  /// In en, this message translates to:
  /// **'Products Summary'**
  String get cartProductsSummary;

  /// No description provided for @cartProductQuantityNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'only available with quantity'**
  String get cartProductQuantityNotAvailable;

  /// No description provided for @cartProductsNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Some products are not available'**
  String get cartProductsNotAvailable;

  /// No description provided for @cartSuccessConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Order is confirmed successfully'**
  String get cartSuccessConfirmation;

  /// No description provided for @cartSuccessIsDelivering.
  ///
  /// In en, this message translates to:
  /// **'Your order will be delivered to you within 24 hours \nYou can now track the progress of your orderً'**
  String get cartSuccessIsDelivering;

  /// No description provided for @cartSuccessTrackButton.
  ///
  /// In en, this message translates to:
  /// **'Track your order'**
  String get cartSuccessTrackButton;

  /// No description provided for @cartTitle.
  ///
  /// In en, this message translates to:
  /// **'Basket'**
  String get cartTitle;

  /// No description provided for @cartRemoveAllProducts.
  ///
  /// In en, this message translates to:
  /// **'Remove all products'**
  String get cartRemoveAllProducts;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @chooseCity.
  ///
  /// In en, this message translates to:
  /// **'Choose your city'**
  String get chooseCity;

  /// No description provided for @chooseYourCountry.
  ///
  /// In en, this message translates to:
  /// **'Choose your country'**
  String get chooseYourCountry;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'Governorate'**
  String get city;

  /// No description provided for @closeApplicationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit Deely?'**
  String get closeApplicationMessage;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter to confirm the new password'**
  String get confirmNewPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUs;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @currentOrders.
  ///
  /// In en, this message translates to:
  /// **'Current orders'**
  String get currentOrders;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @createAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'create your account and start order all your needs now from the same place '**
  String get createAccountMessage;

  /// No description provided for @deleteAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'\nAre you sure you want to delete your account?\nThis will erase all your data and previous requests.'**
  String get deleteAccountMessage;

  /// No description provided for @doNotHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have account?'**
  String get doNotHaveAccount;

  /// No description provided for @editLocation.
  ///
  /// In en, this message translates to:
  /// **'Edit location'**
  String get editLocation;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email required'**
  String get emailRequired;

  /// No description provided for @emptyFavourite.
  ///
  /// In en, this message translates to:
  /// **'There are no favorite products'**
  String get emptyFavourite;

  /// No description provided for @enterCity.
  ///
  /// In en, this message translates to:
  /// **'Enter the name of the governorate'**
  String get enterCity;

  /// No description provided for @enterConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter confirm password'**
  String get enterConfirmPassword;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter full name'**
  String get enterFullName;

  /// No description provided for @threeFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter full name'**
  String get threeFullName;

  /// No description provided for @enterMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter mobile number'**
  String get enterMobileNumber;

  /// No description provided for @enterNeighborhood.
  ///
  /// In en, this message translates to:
  /// **'Enter the neighborhood name'**
  String get enterNeighborhood;

  /// No description provided for @enterPlatformName.
  ///
  /// In en, this message translates to:
  /// **'Enter establishment name'**
  String get enterPlatformName;

  /// No description provided for @platformType.
  ///
  /// In en, this message translates to:
  /// **'Platform type'**
  String get platformType;

  /// No description provided for @choosePlatformType.
  ///
  /// In en, this message translates to:
  /// **'Chose Platform type'**
  String get choosePlatformType;

  /// No description provided for @enterStreetName.
  ///
  /// In en, this message translates to:
  /// **'Enter the building number and street name'**
  String get enterStreetName;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get enterVerificationCode;

  /// No description provided for @enterYouRegisteredMobile.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered mobile'**
  String get enterYouRegisteredMobile;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @faceBook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get faceBook;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @favourite.
  ///
  /// In en, this message translates to:
  /// **'Favourite'**
  String get favourite;

  /// No description provided for @favourites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favourites;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @resetPasswordSetting.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordSetting;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @generalError.
  ///
  /// In en, this message translates to:
  /// **'General error.\nPlease try again later!'**
  String get generalError;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccount;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @hotline.
  ///
  /// In en, this message translates to:
  /// **'Hotline'**
  String get hotline;

  /// No description provided for @howCanWeHelp.
  ///
  /// In en, this message translates to:
  /// **'How can we help?'**
  String get howCanWeHelp;

  /// No description provided for @inValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get inValidEmail;

  /// No description provided for @invalidMobile.
  ///
  /// In en, this message translates to:
  /// **'Invalid mobile'**
  String get invalidMobile;

  /// No description provided for @invalidWallet.
  ///
  /// In en, this message translates to:
  /// **'11 numbers are required'**
  String get invalidWallet;

  /// No description provided for @invalidPayment.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong with payment'**
  String get invalidPayment;

  /// No description provided for @itemsDetails.
  ///
  /// In en, this message translates to:
  /// **'Items details'**
  String get itemsDetails;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @locationYourLocation.
  ///
  /// In en, this message translates to:
  /// **'Search your location'**
  String get locationYourLocation;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginEnter.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginEnter;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Login now'**
  String get loginNow;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutMessage;

  /// No description provided for @mobileAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'Mobile already registered before'**
  String get mobileAlreadyRegistered;

  /// No description provided for @mobileExistBefore.
  ///
  /// In en, this message translates to:
  /// **'You mobile exist before'**
  String get mobileExistBefore;

  /// No description provided for @mobileIsNotExist.
  ///
  /// In en, this message translates to:
  /// **'Phone number is not exist'**
  String get mobileIsNotExist;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get myOrders;

  /// No description provided for @neighborhood.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get neighborhood;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter the new password'**
  String get enterNewPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet Connection.\nPlease try again later'**
  String get noInternetConnection;

  /// No description provided for @noSpaceAllowed.
  ///
  /// In en, this message translates to:
  /// **'No space allowed'**
  String get noSpaceAllowed;

  /// No description provided for @offersTitle.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offersTitle;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @orderAccepting.
  ///
  /// In en, this message translates to:
  /// **'Accepting order'**
  String get orderAccepting;

  /// No description provided for @orderAgain.
  ///
  /// In en, this message translates to:
  /// **'Order again'**
  String get orderAgain;

  /// No description provided for @orderCancelBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get orderCancelBackButton;

  /// No description provided for @orderCancelConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm Cancellation'**
  String get orderCancelConfirmButton;

  /// No description provided for @orderCancelConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this order?'**
  String get orderCancelConfirmation;

  /// No description provided for @orderCancelReasonHint.
  ///
  /// In en, this message translates to:
  /// **'Reason for canceling the order'**
  String get orderCancelReasonHint;

  /// No description provided for @orderCancelReasonTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get orderCancelReasonTitle;

  /// No description provided for @orderCancelReason.
  ///
  /// In en, this message translates to:
  /// **'Reason for canceling your order'**
  String get orderCancelReason;

  /// No description provided for @orderCancelReasonValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter a reason for canceling the order'**
  String get orderCancelReasonValidation;

  /// No description provided for @orderDelivered.
  ///
  /// In en, this message translates to:
  /// **'Order delivered'**
  String get orderDelivered;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order details'**
  String get orderDetails;

  /// No description provided for @orderInProgress.
  ///
  /// In en, this message translates to:
  /// **'Order in progress'**
  String get orderInProgress;

  /// No description provided for @orderItem.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get orderItem;

  /// No description provided for @orderItemCount.
  ///
  /// In en, this message translates to:
  /// **'Items count:'**
  String get orderItemCount;

  /// No description provided for @orderNotRecieved.
  ///
  /// In en, this message translates to:
  /// **'Order canceled'**
  String get orderNotRecieved;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order number:'**
  String get orderNumber;

  /// No description provided for @orderOutside.
  ///
  /// In en, this message translates to:
  /// **'Outside for delivery'**
  String get orderOutside;

  /// No description provided for @orderRecieved.
  ///
  /// In en, this message translates to:
  /// **'Order received'**
  String get orderRecieved;

  /// No description provided for @orderSending.
  ///
  /// In en, this message translates to:
  /// **'Receiving order'**
  String get orderSending;

  /// No description provided for @orderShipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping order'**
  String get orderShipping;

  /// No description provided for @orderTotal.
  ///
  /// In en, this message translates to:
  /// **'Order total:'**
  String get orderTotal;

  /// No description provided for @cartDetailsTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get cartDetailsTotal;

  /// No description provided for @ordersNotFound.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any order till now'**
  String get ordersNotFound;

  /// No description provided for @otpIsNotValid.
  ///
  /// In en, this message translates to:
  /// **'Problem with verification code'**
  String get otpIsNotValid;

  /// No description provided for @otpAuthenticate.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get otpAuthenticate;

  /// No description provided for @otpPhoneIsNotValid.
  ///
  /// In en, this message translates to:
  /// **'Problem with Phone number '**
  String get otpPhoneIsNotValid;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordMinimumCharacters.
  ///
  /// In en, this message translates to:
  /// **'At lest 8 characters'**
  String get passwordMinimumCharacters;

  /// No description provided for @passwordNotMatched.
  ///
  /// In en, this message translates to:
  /// **'Password and confirm password didn\'t match'**
  String get passwordNotMatched;

  /// No description provided for @pastOrders.
  ///
  /// In en, this message translates to:
  /// **'Past orders'**
  String get pastOrders;

  /// No description provided for @pickLocationEnsureMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to select this location?'**
  String get pickLocationEnsureMessage;

  /// No description provided for @platformName.
  ///
  /// In en, this message translates to:
  /// **'Establishment name'**
  String get platformName;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'previous'**
  String get previous;

  /// No description provided for @previousOrder.
  ///
  /// In en, this message translates to:
  /// **'Previous orders'**
  String get previousOrder;

  /// No description provided for @productIsNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Product is not available'**
  String get productIsNotAvailable;

  /// No description provided for @productNotAvailableNow.
  ///
  /// In en, this message translates to:
  /// **'Not available now'**
  String get productNotAvailableNow;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @productsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get productsFilterAll;

  /// No description provided for @promoDetails.
  ///
  /// In en, this message translates to:
  /// **'Promo details'**
  String get promoDetails;

  /// No description provided for @promoItems.
  ///
  /// In en, this message translates to:
  /// **'Offer Items'**
  String get promoItems;

  /// No description provided for @promotion.
  ///
  /// In en, this message translates to:
  /// **'Promotion'**
  String get promotion;

  /// No description provided for @registerMessageOtp.
  ///
  /// In en, this message translates to:
  /// **'Once you press on next you will receive message to activate your account'**
  String get registerMessageOtp;

  /// No description provided for @registerNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Register new account'**
  String get registerNewAccount;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerNow;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Filed required'**
  String get required;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saveChange.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChange;

  /// No description provided for @editData.
  ///
  /// In en, this message translates to:
  /// **'Edit data'**
  String get editData;

  /// No description provided for @scanBarcode.
  ///
  /// In en, this message translates to:
  /// **'Search by Barcode'**
  String get scanBarcode;

  /// No description provided for @scanText.
  ///
  /// In en, this message translates to:
  /// **'Make sure barcode is\nblack mark to scan'**
  String get scanText;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchProduct.
  ///
  /// In en, this message translates to:
  /// **'Looking for a specific product?'**
  String get searchProduct;

  /// No description provided for @selectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select your location'**
  String get selectLocation;

  /// No description provided for @selectPhotoFromCameraOrGallery.
  ///
  /// In en, this message translates to:
  /// **'Which you would like to use?'**
  String get selectPhotoFromCameraOrGallery;

  /// No description provided for @sendOTP.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOTP;

  /// No description provided for @sendOtpAgain.
  ///
  /// In en, this message translates to:
  /// **'Send OTP again'**
  String get sendOtpAgain;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @streetName.
  ///
  /// In en, this message translates to:
  /// **'Building number / street name'**
  String get streetName;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @supportAndAssistance.
  ///
  /// In en, this message translates to:
  /// **'Support & Assistance'**
  String get supportAndAssistance;

  /// No description provided for @updateProfileBuildingData.
  ///
  /// In en, this message translates to:
  /// **'Building Information'**
  String get updateProfileBuildingData;

  /// No description provided for @updateProfileBuildingName.
  ///
  /// In en, this message translates to:
  /// **'Building Name'**
  String get updateProfileBuildingName;

  /// No description provided for @updateProfileBuildingNumber.
  ///
  /// In en, this message translates to:
  /// **'Building number / Street name'**
  String get updateProfileBuildingNumber;

  /// No description provided for @updateProfileDistrict.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get updateProfileDistrict;

  /// No description provided for @updateProfileGovernorate.
  ///
  /// In en, this message translates to:
  /// **'Governorate'**
  String get updateProfileGovernorate;

  /// No description provided for @updateProfileLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get updateProfileLocation;

  /// No description provided for @updateProfilePersonalData.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get updateProfilePersonalData;

  /// No description provided for @updateProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Update profile'**
  String get updateProfileTitle;

  /// No description provided for @usagePolicy.
  ///
  /// In en, this message translates to:
  /// **'Usage Policy'**
  String get usagePolicy;

  /// No description provided for @usagePolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Usage Policy'**
  String get usagePolicyTitle;

  /// No description provided for @validateOtp.
  ///
  /// In en, this message translates to:
  /// **'Validate'**
  String get validateOtp;

  /// No description provided for @welcomeToDokkan.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeToDokkan;

  /// No description provided for @whatsApp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get whatsApp;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @youCanStartOrderNow.
  ///
  /// In en, this message translates to:
  /// **'You can start order now'**
  String get youCanStartOrderNow;

  /// No description provided for @startOrderNow.
  ///
  /// In en, this message translates to:
  /// **'Order all your needs from the same place'**
  String get startOrderNow;

  /// No description provided for @youNeedToLoginToUseApp.
  ///
  /// In en, this message translates to:
  /// **'You need to login'**
  String get youNeedToLoginToUseApp;

  /// No description provided for @yourMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get yourMobile;

  /// No description provided for @goToMainPage.
  ///
  /// In en, this message translates to:
  /// **'Go to main page'**
  String get goToMainPage;

  /// No description provided for @firstStep.
  ///
  /// In en, this message translates to:
  /// **'1. Create account'**
  String get firstStep;

  /// No description provided for @secondStep.
  ///
  /// In en, this message translates to:
  /// **'2. Choose your location'**
  String get secondStep;

  /// No description provided for @thirdStep.
  ///
  /// In en, this message translates to:
  /// **'3. Set your password'**
  String get thirdStep;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @deniedPermission.
  ///
  /// In en, this message translates to:
  /// **'has been denied. our app required this permission in order to continue.'**
  String get deniedPermission;

  /// No description provided for @enter.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get enter;

  /// No description provided for @the.
  ///
  /// In en, this message translates to:
  /// **'the'**
  String get the;

  /// No description provided for @numberSentTo.
  ///
  /// In en, this message translates to:
  /// **'The 6 numbers sent to number'**
  String get numberSentTo;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @mostSelling.
  ///
  /// In en, this message translates to:
  /// **'Most selling'**
  String get mostSelling;

  /// No description provided for @recommendedForYourStore.
  ///
  /// In en, this message translates to:
  /// **'Recommended for your store'**
  String get recommendedForYourStore;

  /// No description provided for @totalBeforeDiscount.
  ///
  /// In en, this message translates to:
  /// **'Total before discount'**
  String get totalBeforeDiscount;

  /// No description provided for @totalDiscount.
  ///
  /// In en, this message translates to:
  /// **'Total discount'**
  String get totalDiscount;

  /// No description provided for @deliveryFees.
  ///
  /// In en, this message translates to:
  /// **'Delivery fees'**
  String get deliveryFees;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @timeSlotMorning.
  ///
  /// In en, this message translates to:
  /// **'8 - 9 AM'**
  String get timeSlotMorning;

  /// No description provided for @fawry.
  ///
  /// In en, this message translates to:
  /// **'Fawry'**
  String get fawry;

  /// No description provided for @chooseDistrict.
  ///
  /// In en, this message translates to:
  /// **'Choose district'**
  String get chooseDistrict;

  /// No description provided for @invalidPhoneOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong phone number or password'**
  String get invalidPhoneOrPassword;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;
}

class _LocDelegate extends LocalizationsDelegate<Loc> {
  const _LocDelegate();

  @override
  Future<Loc> load(Locale locale) {
    return SynchronousFuture<Loc>(lookupLoc(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_LocDelegate old) => false;
}

Loc lookupLoc(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return LocAr();
    case 'en':
      return LocEn();
  }

  throw FlutterError(
    'Loc.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
