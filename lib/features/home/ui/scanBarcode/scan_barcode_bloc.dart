
import 'package:deel/deel.dart';
import 'package:rxdart/rxdart.dart';

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