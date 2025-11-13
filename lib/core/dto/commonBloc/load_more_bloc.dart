import 'package:rxdart/rxdart.dart';

import '../../ui/bases/bloc_base.dart';
import '../models/baseModules/api_state.dart';

class LoadMoreBloc<T> extends BlocBase {
  int pageNumber = 1;
  int pageSize = 10;

   BehaviorSubject<ApiState<List<T>>> loadedListBehaviour =
      BehaviorSubject()..sink.add(LoadingState());

  Stream<ApiState<List<T>>> get loadedListStream => loadedListBehaviour.stream;

  void reset() {
    loadedListBehaviour.sink.add(LoadingState());
    pageNumber = 1;
  }

  void setLoaded(List<T> list) {
    List<T> beforeList = loadedListBehaviour.value.response ?? [];
    beforeList.addAll(list);
    loadedListBehaviour.sink.add(SuccessState(beforeList));
    pageNumber = pageNumber + 1;
  }

  @override
  void dispose() {
    loadedListBehaviour.close();
  }
}
