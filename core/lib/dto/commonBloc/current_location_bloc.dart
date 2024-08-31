import 'package:core/core.dart' hide PermissionStatus;
import 'package:core/dto/commonBloc/permission_bloc.dart';
import 'package:core/dto/modules/logger_module.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:location/location.dart';

class CurrentLocationBloc extends BlocBase {
  // A BehaviorSubject for storing and managing the current location data.
  final BehaviorSubject<LocationData> _currentLocationBehaviour =
      BehaviorSubject();

  // PermissionBloc for managing location permissions.
  final PermissionBloc locationPermissionBloc = PermissionBloc();

  // Location instance for interacting with the device's location services.
  final Location _location = Location();

  // Stream getter to access the current location data.
  Stream<LocationData> get currentLocationStream =>
      _currentLocationBehaviour.stream;

  // Getter to access the current location latitude.
  double get latitude => _currentLocationBehaviour.valueOrNull?.latitude ?? 0.0;

  // Getter to access the current location longitude.
  double get longitude =>
      _currentLocationBehaviour.valueOrNull?.longitude ?? 0.0;

  // Method to request the user's location.
  Future<void> requestLocation() async {
    // Check if location services are enabled on the device.
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      // Request to enable location services if they are not enabled.
      final isEnabled = await _location.requestService();
      // Recursively call requestLocation to start listening once services are enabled.
      if (!isEnabled) {
        await requestLocation();
      } else {
        _handlePermissionAllowed();
      }
    } else {
      _handlePermissionAllowed();
    }
  }

  void _handlePermissionAllowed() {
    // Disable background mode for location updates.
    _backgroundMode();
    // change distance and interval to custom
    _locationSettings();
    // Start listening for location updates.
    _listenForLocation();
  }

  void _locationSettings() {
    _location.changeSettings(distanceFilter: 100, interval: 1000);
  }

  // Method to disable background mode for location updates.
  void _backgroundMode() {
    _location.enableBackgroundMode(enable: false);
  }

  // Method to listen for location changes and update the current location.
  void _listenForLocation() async {
    _location.onLocationChanged.listen((event) {
      // Log the current user's latitude and longitude.
      LoggerModule.log(
          message: 'latitude: ${event.latitude}, longitude: ${event.longitude}',
          name: 'current user location: ');
      // Add the updated location data to the BehaviorSubject.
      _currentLocationBehaviour.sink.add(event);
    });
    // final location = await _location.getLocation();
    // LoggerModule.log(
    //     message: ': ${location.latitude}, longitude: ${location.longitude}',
    //     name: 'current user location: ');
    // _currentLocationBehaviour.sink.add(location);
  }

  @override
  void dispose() {
    // Close the BehaviorSubject when the bloc is disposed.
    // _currentLocationBehaviour.close();
  }
}
