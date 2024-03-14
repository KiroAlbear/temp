import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:more/dto/models/more_mapper.dart';

class MoreBloc extends BlocBase{
  final BehaviorSubject<ApiState<MoreMapper>> _moreBehaviour = BehaviorSubject();
  @override
  void dispose() {
    _moreBehaviour.close();
  }

}