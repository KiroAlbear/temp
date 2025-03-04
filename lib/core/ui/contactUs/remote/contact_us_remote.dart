
import '../../../dto/models/baseModules/admin_header_request.dart';
import '../../../dto/models/baseModules/api_state.dart';
import '../../../dto/models/contactUs/contact_us_mapper.dart';
import '../../../dto/models/contactUs/contact_us_response.dart';
import '../../../dto/modules/admin_dio_module.dart';
import '../../../dto/network/admin_client.dart';
import '../../../dto/remote/admin_base_remote_module.dart';

class ContactUsRemote
    extends AdminBaseRemoteModule<ContactUsMapper, List<ContactUsResponse>> {
  @override
  ApiState<ContactUsMapper> onSuccessHandle(List<ContactUsResponse>? response) {
    ContactUsMapper contactUsMapper = ContactUsMapper();
    response?.forEach(
      (element) {
        contactUsMapper.init(element);
      },
    );
    return SuccessState(contactUsMapper);
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }

  ContactUsRemote() {
    apiFuture = AdminClient(AdminDioModule().build())
        .getContactUs(AdminHeaderRequest(pageSize: 0, pageIndex: 0));
  }
}
