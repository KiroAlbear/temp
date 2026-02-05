import '../../../../deel.dart';

class CheckPhoneRemote
    extends BaseRemoteModule<bool, List<CheckPhoneResponse>> {
  final bool isForgetPassword;

  @override
  ApiState<bool> onSuccessHandle(List<CheckPhoneResponse>? response) {
    if (response?.first.isExist ?? false) {
      if (isForgetPassword) {
        return SuccessState(true);
      } else {
        return FailedState(
          message: Loc.of(
            Routes.rootNavigatorKey.currentContext!,
          )!.mobileExistBefore,
          loggerName: runtimeType.toString(),
        );
      }
    } else {
      if (isForgetPassword) {
        return FailedState(
          message: Loc.of(
            Routes.rootNavigatorKey.currentContext!,
          )!.mobileIsNotExist,
          loggerName: runtimeType.toString(),
        );
      } else {
        return SuccessState(true);
      }
    }
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }

  CheckPhoneRemote(String phone, {this.isForgetPassword = false}) {
    apiFuture = ApiClient(
      OdooDioModule().build(),
    ).checkPhone(CheckPhoneRequest(phone));
  }
}
