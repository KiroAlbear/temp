import '../models/baseModules/admin_header_request.dart';
import '../models/baseModules/api_state.dart';
import '../models/faq/faq_mapper.dart';
import '../models/faq/faq_response.dart';
import '../modules/admin_dio_module.dart';
import '../network/admin_client.dart';
import 'admin_base_remote_module.dart';

class FaqRemote
    extends AdminBaseRemoteModule<List<FaqMapper>, List<FaqResponse>> {
  @override
  ApiState<List<FaqMapper>> onSuccessHandle(List<FaqResponse>? response) {
    List<FaqMapper> list = [];
    response?.forEach(
      (element) {
        list.add(FaqMapper(element));
      },
    );
    return SuccessState(list);
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }

  FaqRemote() {
    apiFuture = AdminClient(AdminDioModule().build())
        .getFaq(AdminHeaderRequest(pageIndex: 0, pageSize: 100));
  }
}
