import 'package:core/dto/models/baseModules/admin_header_request.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/heroBanner/banners_response.dart';
import 'package:core/dto/models/home/offer_mapper.dart';
import 'package:core/dto/modules/admin_dio_module.dart';
import 'package:core/dto/network/admin_client.dart';

import 'admin_base_remote_module.dart';

class HeroBannerRemote
    extends AdminBaseRemoteModule<List<OfferMapper>, BannersResponse> {
  @override
  ApiState<List<OfferMapper>> onSuccessHandle(BannersResponse? response) {
    List<OfferMapper> list = [];
    response?.bannerList?.forEach(
      (element) {
        list.add(OfferMapper(element));
      },
    );
    return SuccessState(list);
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }

  HeroBannerRemote() {
    apiFuture = AdminClient(AdminDioModule().build())
        .getHeroBanner(AdminHeaderRequest(pageIndex: 0, pageSize: 0));
  }
}
