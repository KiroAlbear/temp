import 'package:deel/deel.dart';
import 'package:deel/features/cart/models/payment_visibility_model.dart';
import 'package:deel/features/most_selling/models/most_selling_request_model.dart';
import 'package:deel/features/most_selling/models/most_selling_response_model.dart';
import 'package:deel/features/recommended_items/models/recommended_items_request_model.dart';
import 'package:deel/features/recommended_items/models/recommended_items_response_model.dart';
import 'package:retrofit/error_logger.dart';

import 'package:retrofit/http.dart';

import '../models/save_coordinates_request_model.dart';

part 'admin_client.g.dart';
part 'admin_client_key.dart';

@RestApi()
abstract class AdminClient {
  factory AdminClient(Dio dio) = _AdminClient;

  @POST(_AdminApiKey._saveCoordinates)
  Future<AdminHeaderResponse>
  saveCoordinates(@Body() SaveCoordinatesRequestModel requestModel);

  @POST(_AdminApiKey._getRecommendedItems)
  Future<AdminHeaderResponse<RecommendedItemsResponseModel>>
  getRecommendedItems(@Body() RecommendedItemsRequestModel requestModel);

  @GET(_AdminApiKey._paymentVisibility)
  Future<AdminHeaderResponse<List<PaymentVisibilityResponseModel>>>
  getPaymentVisibility();

  @POST(_AdminApiKey._getMostSelling)
  Future<AdminHeaderResponse<MostSellingResponseModel>> getMostSelling(
    @Body() MostSellingRequestModel requestModel,
  );

  @POST(_AdminApiKey._getAnnouncements)
  Future<AdminHeaderResponse<AnnouncementResponseModel>> getAnnouncements(
    @Body() AnnouncementRequestModel requestModel,
  );

  @GET(_AdminApiKey._updateApp)
  Future<AdminHeaderResponse<List<UpdateAppResponseModel>>> updateApp();

  @POST(_AdminApiKey._faq)
  Future<AdminHeaderResponse<List<FaqResponse>>> getFaq(
    @Body() AdminHeaderRequest request,
  );

  @POST(_AdminApiKey._notificationUpdateDeviceData)
  Future<AdminHeaderResponse<NotificationsUpdateDeviceDataResponseModel>>
  updateNotificationsDeviceData(
    @Body() NotificationsUpdateDeviceDataRequestModel request,
  );

  @POST(_AdminApiKey._contactUs)
  Future<AdminHeaderResponse<List<ContactUsResponse>>> getContactUs(
    @Body() AdminHeaderRequest request,
  );

  @POST(_AdminApiKey._heroBanner)
  Future<AdminHeaderResponse<BannersResponse>> getHeroBanner(
    @Body() AdminHeaderRequest request,
  );

  @POST(_AdminApiKey._offerBanner)
  Future<AdminHeaderResponse<BannersResponse>> getOfferBanner(
    @Body() AdminHeaderRequest request,
  );

  @GET(_AdminApiKey._usagePolicy)
  Future<AdminHeaderResponse<UsagePolicyResponse>> getUsagePolicy();

  @POST(_AdminApiKey._sendOtp)
  Future<AdminHeaderResponse> sendOtp(@Body() SendOtpRequest request);

  @POST(_AdminApiKey._verifyOtp)
  Future<AdminHeaderResponse> verifyOtp(@Body() VerifyOtpRequest request);
}
