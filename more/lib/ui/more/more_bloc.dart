import 'package:core/core.dart';
import 'package:core/dto/commonBloc/permission_bloc.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:more/dto/models/more_mapper.dart';

class MoreBloc extends BlocBase{
  final BehaviorSubject<ApiState<MoreMapper>> _moreBehaviour = BehaviorSubject();
  final PermissionBloc cameraPermissionBloc = PermissionBloc();
  final PermissionBloc galleryPermissionBloc = PermissionBloc();
  final BehaviorSubject<String> _selectedFileBehaviour= BehaviorSubject()..sink.add('');

  void uploadImage(String filePath){
    _selectedFileBehaviour.sink.add(filePath);
  }

  MoreBloc(){
    _selectedFileBehaviour.listen((value) {

    });
  }
  @override
  void dispose() {
    _moreBehaviour.close();
    cameraPermissionBloc.dispose();
  }

}