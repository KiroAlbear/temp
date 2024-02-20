import 'package:core/core.dart';
import 'package:core/ui/bases/bloc_base.dart';

class ExpandedBloc extends BlocBase {
  final BehaviorSubject<bool> _isExpandedBehaviour = BehaviorSubject();

  set expanded(bool event) => _isExpandedBehaviour.sink.add(event);

  bool get expanded => _isExpandedBehaviour.value;

  Stream<bool> get expandedStream => _isExpandedBehaviour.stream;

  ExpandedBloc() {
    _isExpandedBehaviour.sink.add(false);
  }

  @override
  void dispose() {
    _isExpandedBehaviour.close();
  }
}
