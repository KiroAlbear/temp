import 'package:deel/deel.dart';
import 'package:rxdart/rxdart.dart';

class FaqBloc extends BlocBase{
  final BehaviorSubject<ApiState<List<FaqMapper>>> _faqBehaviour = BehaviorSubject();

  Stream<ApiState<List<FaqMapper>>> get faqStream=> _faqBehaviour.stream;


  FaqBloc(){
    FaqRemote().callApiAsStream().listen((event) {
      _faqBehaviour.sink.add(event);
    },);
  }

  @override
  void dispose() {
    _faqBehaviour.close();
  }

}