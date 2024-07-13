import 'package:core/core.dart';
import 'package:core/dto/commonBloc/permission_bloc.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../dto/commonBloc/current_location_bloc.dart';

class MapPreviewBloc extends BlocBase {
  final CurrentLocationBloc _currentLocationBloc = CurrentLocationBloc();
  final PermissionBloc _permissionBloc = PermissionBloc();
  final BehaviorSubject<LatLng?> _latLngBehaviour = BehaviorSubject();
  final BehaviorSubject<bool> _mapReadyBehaviour = BehaviorSubject()
    ..sink.add(false);
  final MapController mapController = MapController();
  bool isLocationChanged = false;

  void latLng(double latitude, double longitude) =>
      _latLngBehaviour.sink.add(LatLng(latitude, longitude));

  void mapReady(bool event) => _mapReadyBehaviour.sink.add(event);

  Stream<LatLng?> get latLngStream => _latLngBehaviour.stream;

  Stream<bool> get mapReadyStream => _mapReadyBehaviour.stream;

  void initPermissionAndLocation(BuildContext context, {Function(double latitude, double longitude)? onLocationDetection}) {
    _permissionBloc.requestPermission(context, Permission.location);
    _mapReadyBehaviour.listen((mapReady) {
      if (mapReady) {
        _updateMapCamera();
        _permissionBloc.easyPermissionHandler.isPermissionGrantedStream
            .listen((locationPermissionGranted) {
          if (locationPermissionGranted) {
            _currentLocationBloc.requestLocation();
            _currentLocationBloc.currentLocationStream.listen((event) {
              if (!isLocationChanged) {
                latLng(event.latitude ?? 0.0, event.longitude ?? 0.0);
                if(onLocationDetection != null){
                  onLocationDetection(event.latitude ?? 0.0, event.longitude ?? 0.0);
                }
              }
            });
          }
        });
      }
    });
  }

  void _updateMapCamera() {
    _latLngBehaviour.listen((location) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        if (location != null) {
          mapController.move(location, 18);
        }
      });
    });
  }

  @override
  void dispose() {
    _currentLocationBloc.dispose();
    _permissionBloc.dispose();
    _mapReadyBehaviour.close();
    _latLngBehaviour.close();
    mapController.dispose();
  }
}
