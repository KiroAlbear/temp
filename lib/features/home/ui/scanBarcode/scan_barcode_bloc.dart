import 'package:core/core.dart';
import 'package:core/dto/commonBloc/permission_bloc.dart';
import 'package:core/ui/bases/bloc_base.dart';

class ScanBarcodeBloc extends BlocBase{
  final PermissionBloc cameraPermissionBloc = PermissionBloc();
  final BehaviorSubject<bool> _scanBehaviour = BehaviorSubject()..sink.add(false);

  Stream<bool> get scanStream=> _scanBehaviour.stream;

  set scan(bool value){
    _scanBehaviour.sink.add(value);
  }
  @override
  void dispose() {
    _scanBehaviour.close();
    cameraPermissionBloc.dispose();
  }

}