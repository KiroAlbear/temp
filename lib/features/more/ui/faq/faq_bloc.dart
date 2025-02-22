import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/faq/faq_mapper.dart';
import 'package:core/dto/remote/faq_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';

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