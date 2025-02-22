import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:rxdart/rxdart.dart';

import '../../ui/bases/bloc_base.dart';

class ButtonBloc extends BlocBase {
  // A BehaviorSubject for managing failed states.
  final BehaviorSubject<String> failedBehaviour = BehaviorSubject<String>();

  // A BehaviorSubject for managing button states.
  final BehaviorSubject<ButtonState> buttonBehavior =
      BehaviorSubject<ButtonState>();

  @override
  void dispose() {
    // Close the BehaviorSubjects when the bloc is disposed to release resources.
    failedBehaviour.close();
    buttonBehavior.close();
  }
}
