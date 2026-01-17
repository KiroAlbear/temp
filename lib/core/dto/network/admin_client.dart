import 'package:deel/core/dto/models/notifications/notification_update_device_data_request_model.dart';
import 'package:deel/core/dto/models/notifications/notification_update_device_data_response_model.dart';
import 'package:deel/deel.dart';
import 'package:deel/features/most_selling/models/most_selling_request_model.dart';
import 'package:deel/features/most_selling/models/most_selling_response_model.dart';
import 'package:retrofit/error_logger.dart';

import 'package:retrofit/http.dart';

import '../../../features/announcements/models/announcement_request_model.dart';
import '../../../features/announcements/models/announcement_response_model.dart';
import '../models/update_app_response_model.dart';
part 'admin_client.g.dart';
part 'admin_client_key.dart';

@RestApi()
abstract class AdminClient {
  factory AdminClient(Dio dio) = _AdminClient;

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
