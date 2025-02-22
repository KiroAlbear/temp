
import 'package:rxdart/rxdart.dart';

import '../../ui/bases/bloc_base.dart';
import '../models/baseModules/api_state.dart';

class LoadMoreBloc<T> extends BlocBase {
  int pageNumber = 1;
  int pageSize = 10;

  final BehaviorSubject<ApiState<List<T>>> _loadedListBehaviour =
      BehaviorSubject()..sink.add(LoadingState());

  Stream<ApiState<List<T>>> get loadedListStream => _loadedListBehaviour.stream;

  void reset() {
    _loadedListBehaviour.sink.add(LoadingState());
    pageNumber = 1;
  }

  void setLoaded(List<T> list) {
    List<T> beforeList = _loadedListBehaviour.value.response ?? [];
    beforeList.addAll(list);
    _loadedListBehaviour.sink.add(SuccessState(beforeList));
    pageNumber = pageNumber + 1;
  }

  @override
  void dispose() {
    // _loadedListBehaviour.close();
  }
}
