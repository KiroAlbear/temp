import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/usage_policy/usage_policy_response.dart';
import 'package:core/dto/remote/usage_policy_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';

class UsagePolicyBloc extends BlocBase {
  final BehaviorSubject<ApiState<UsagePolicyResponse>> usagePolicyBehaviour =
      BehaviorSubject();

  void getUsagePolicy() {
    UsagePolicyRemote().getUsagePolicy().listen((event) {
      if (event is SuccessState) {
        usagePolicyBehaviour.sink.add(event);
      }
    });
  }

  @override
  void dispose() {}
}
