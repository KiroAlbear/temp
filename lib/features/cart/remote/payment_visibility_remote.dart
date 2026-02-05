import 'package:deel/deel.dart';

import '../models/payment_visibility_model.dart';

class PaymentVisibilityRemote
    extends
        AdminBaseRemoteModule<
          List<PaymentVisibilityMapper>,
          List<PaymentVisibilityResponseModel>
        > {
  PaymentVisibilityRemote() {
    apiFuture = AdminClient(AdminDioModule().build()).getPaymentVisibility();
  }

  @override
  ApiState<List<PaymentVisibilityMapper>> onSuccessHandle(
    List<PaymentVisibilityResponseModel>? response,
  ) {
    List<PaymentVisibilityMapper> list = [];

    response?.forEach((element) {
      final paymentType = PaymentTypeX.fromId(element.type);
      if (paymentType != null) {
        list.add(
          PaymentVisibilityMapper(
            type: paymentType,
            visible: element.visible ?? false,
          ),
        );
      }
    });

    return SuccessState(list);
  }

  @override
  Future<bool> refreshToken() async {
    return false;
  }
}
