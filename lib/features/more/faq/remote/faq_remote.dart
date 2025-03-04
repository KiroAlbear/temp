import '../../../../core/dto/models/baseModules/admin_header_request.dart';
import '../../../../core/dto/models/baseModules/api_state.dart';
import '../../../../core/dto/models/faq/faq_mapper.dart';
import '../../../../core/dto/models/faq/faq_response.dart';
import '../../../../core/dto/modules/admin_dio_module.dart';
import '../../../../core/dto/network/admin_client.dart';
import '../../../../core/dto/remote/admin_base_remote_module.dart';

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
