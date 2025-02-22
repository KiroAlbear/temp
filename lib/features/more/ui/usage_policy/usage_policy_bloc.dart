import 'package:deel/deel.dart';
import 'package:rxdart/rxdart.dart';

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
