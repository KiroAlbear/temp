import 'package:core/ui/bases/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class VisibilityBloc extends BlocBase {
  // A BehaviorSubject for managing the visibility state.
  final BehaviorSubject<bool> _visibilityBehaviour = BehaviorSubject();

  // Stream getter to access the visibility state.
  Stream<bool> get visibilityStream => _visibilityBehaviour.stream;

  // Constructor to initialize the visibility state with a default value.
  VisibilityBloc(bool defaultValue) {
    _visibilityBehaviour.sink.add(defaultValue);
  }

  // Method to update the visibility state with an optional new value.
  void updateVisibility({bool? value}) =>
      _visibilityBehaviour.sink.add(value ?? !_visibilityBehaviour.value);

  @override
  void dispose() {
    // Close the BehaviorSubject when the bloc is disposed to release resources.
    _visibilityBehaviour.close();
  }
}
