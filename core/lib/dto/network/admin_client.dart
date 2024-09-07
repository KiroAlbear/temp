import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/admin_header_request.dart';
import 'package:core/dto/models/baseModules/admin_header_response.dart';
import 'package:core/dto/models/contactUs/contact_us_response.dart';
import 'package:core/dto/models/faq/faq_response.dart';
import 'package:core/dto/models/heroBanner/banners_response.dart';

import '../models/usage_policy/usage_policy_response.dart';

part 'admin_client.g.dart';
part 'admin_client_key.dart';

@RestApi()
abstract class AdminClient {
  factory AdminClient(Dio dio) = _AdminClient;

  @POST(_AdminApiKey._faq)
  Future<AdminHeaderResponse<List<FaqResponse>>> getFaq(
      @Body() AdminHeaderRequest request);

  @POST(_AdminApiKey._contactUs)
  Future<AdminHeaderResponse<List<ContactUsResponse>>> getContactUs(
      @Body() AdminHeaderRequest request);

  @POST(_AdminApiKey._heroBanner)
  Future<AdminHeaderResponse<BannersResponse>> getHeroBanner(
      @Body() AdminHeaderRequest request);

  @POST(_AdminApiKey._offerBanner)
  Future<AdminHeaderResponse<BannersResponse>> getOfferBanner(
      @Body() AdminHeaderRequest request);

  @GET(_AdminApiKey._usagePolicy)
  Future<AdminHeaderResponse<UsagePolicyResponse>> getUsagePolicy();
}
