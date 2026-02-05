import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../../dto/commonBloc/current_location_bloc.dart';
import '../../dto/commonBloc/permission_bloc.dart';
import '../bases/bloc_base.dart';

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

  void initPermissionAndLocation(BuildContext context,
      {Function(double latitude, double longitude)? onLocationDetection}) async {
    await _permissionBloc.requestPermission(context, Permission.location);
    _currentLocationBloc.currentLocationBehaviour.listen((Position event) async {
      if (!isLocationChanged) {
        latLng(event.latitude, event.longitude);
        if (onLocationDetection != null) {
          await Future.delayed(const Duration(seconds: 1));
          onLocationDetection(event.latitude, event.longitude);
        }
      }
    });

    _mapReadyBehaviour.listen((mapReady) {
      if (mapReady) {
        _updateMapCamera();
      }
    });

    _permissionBloc.easyPermissionHandler.isPermissionGrantedStream
        .listen((locationPermissionGranted) async {
      if (locationPermissionGranted) {
        await _currentLocationBloc.requestLocation();
      }
    });
  }

  void _updateMapCamera() {
    _latLngBehaviour.listen((location) {
      Future.delayed(const Duration(seconds: 0)).then((value) {
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
