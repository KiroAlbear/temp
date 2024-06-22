import 'package:core/core.dart';
import 'package:core/dto/modules/dio_module.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:core/dto/models/baseModules/admin_header_request.dart';
import 'package:core/dto/models/baseModules/header_response.dart';
import 'package:core/dto/models/contactUs/contact_us_response.dart';
import 'package:core/dto/models/faq/faq_response.dart';
import 'package:core/dto/models/heroBanner/banners_response.dart';
import 'package:mockito/mockito.dart';


void main() {
  // late MockAdminClient mockAdminClient;
  // late Dio dio;
  //
  // setUp(() {
  //   dio = Dio(BaseOptions(baseUrl: 'https://adminapi.dokkan-app.com/api/'));
  //   mockAdminClient = MockAdminClient();
  // });
  //
  // test('getFaq returns list of FAQs', () async {
  //   // Arrange
  //   final request = AdminHeaderRequest(pageIndex: 0, pageSize: 0);
  //   final faqResponse = HeaderResponse<List<FaqResponse>>();
  //
  //   when(mockAdminClient.getFaq(request)).thenAnswer((_) async => faqResponse);
  //
  //   // Act
  //   final result = await mockAdminClient.getFaq(request);
  //
  //   // Assert
  //   expect(result, faqResponse);
  //   verify(mockAdminClient.getFaq(request)).called(1);
  // });

  // test('getContactUs returns list of ContactUs responses', () async {
  //   // Arrange
  //   final request = AdminHeaderRequest(header: "header");
  //   final contactUsResponse = HeaderResponse<List<ContactUsResponse>>(
  //     header: "header",
  //     body: [
  //       ContactUsResponse(id: "1", name: "Name", email: "email@example.com", message: "Message")
  //     ],
  //   );
  //
  //   when(mockAdminClient.getContactUs(request)).thenAnswer((_) async => contactUsResponse);
  //
  //   // Act
  //   final result = await mockAdminClient.getContactUs(request);
  //
  //   // Assert
  //   expect(result, contactUsResponse);
  //   verify(mockAdminClient.getContactUs(request)).called(1);
  // });
  //
  // test('getHeroBanner returns hero banners', () async {
  //   // Arrange
  //   final request = AdminHeaderRequest(header: "header");
  //   final heroBannerResponse = HeaderResponse<BannersResponse>(
  //     header: "header",
  //     body: BannersResponse(id: "1", imageUrl: "image_url", link: "link"),
  //   );
  //
  //   when(mockAdminClient.getHeroBanner(request)).thenAnswer((_) async => heroBannerResponse);
  //
  //   // Act
  //   final result = await mockAdminClient.getHeroBanner(request);
  //
  //   // Assert
  //   expect(result, heroBannerResponse);
  //   verify(mockAdminClient.getHeroBanner(request)).called(1);
  // });
  //
  // test('getOfferBanner returns offer banners', () async {
  //   // Arrange
  //   final request = AdminHeaderRequest(header: "header");
  //   final offerBannerResponse = HeaderResponse<BannersResponse>(
  //     header: "header",
  //     body: BannersResponse(id: "1", imageUrl: "image_url", link: "link"),
  //   );
  //
  //   when(mockAdminClient.getOfferBanner(request)).thenAnswer((_) async => offerBannerResponse);
  //
  //   // Act
  //   final result = await mockAdminClient.getOfferBanner(request);
  //
  //   // Assert
  //   expect(result, offerBannerResponse);
  //   verify(mockAdminClient.getOfferBanner(request)).called(1);
  // });
}
