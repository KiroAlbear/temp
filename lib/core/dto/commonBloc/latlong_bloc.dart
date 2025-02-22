
import 'package:rxdart/rxdart.dart';

import '../../ui/bases/bloc_base.dart';

class LatLongBloc extends BlocBase{
  final BehaviorSubject<double> latitudeBehaviour = BehaviorSubject()..sink.add(0.0);

  final BehaviorSubject<double> longitudeBehaviour = BehaviorSubject()..sink.add(0.0);



  @override
  void dispose() {
    latitudeBehaviour.close();
    longitudeBehaviour.close();
  }

}