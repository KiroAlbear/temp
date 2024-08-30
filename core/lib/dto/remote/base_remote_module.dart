import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/baseModules/header_response.dart';
import 'package:core/dto/modules/constants_module.dart';
import 'package:core/dto/modules/dio_module.dart';
import 'package:core/dto/modules/logger_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:flutter/foundation.dart';

/// A base class for remote modules responsible for making API requests
/// and handling responses.
///
/// This abstract class provides a foundation for creating remote modules that
/// interact with APIs. It encapsulates common functionality for making API
/// requests, handling responses, and managing authentication tokens.
///
/// Type Parameters:
///   - T: The type of data to be mapped from the API response.
///   - K: The type of response received from the API.
abstract class BaseRemoteModule<T, K> {
  /// The future representing the API call.
  late bool isFormLogin = false;
  Future<HeaderResponse<K>> _apiFuture = Future.value(HeaderResponse<K>());

  /// The header response received from the API.
  @protected
  HeaderResponse<K> headerResponse = HeaderResponse<K>();

  /// Sets the API future to a provided value.
  ///
  /// This setter allows setting the `_apiFuture` property to a specific API
  /// call's future.
  set apiFuture(Future<HeaderResponse<K>> apiFuture) {
    this._apiFuture = apiFuture;
  }

  /// Checks if an internet connection is available.
  Future<bool> _isInternetConnectionAvailable() async {
    try {
      final isConnect = await _checkIfConnectToAnySourceType();
      if (isConnect) {
        final result = await InternetAddress.lookup(ConstantModule.lookUpUrl);
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } on SocketException catch (e, stackTrace) {
      LoggerModule.log(
          message: e.toString(),
          name: runtimeType.toString(),
          error: e,
          stackTrace: stackTrace);
      return false;
    }
  }

  /// Checks if the device is connected to any source of internet.
  Future<bool> _checkIfConnectToAnySourceType() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.vpn)) {
      return true;
    } else {
      return false;
    }
  }

  /// Streams API states asynchronously.
  ///
  /// This method streams API states, such as `LoadingState`, `SuccessState`,
  /// `FailedState`, `NoInternetState`, or `ErrorState`, based on the API call
  /// and its response. It handles various exceptions and performs token
  /// refreshing if necessary.
  ///
  /// Returns:
  ///   A stream of `ApiState<T>` representing the API call's progress and result.
  Stream<ApiState<T>> callApiAsStream() async* {
    try {
      final isConnected = await _isInternetConnectionAvailable();
      if (!isConnected) {
        yield NoInternetState();
      } else {
        yield LoadingState(); // Emit a loading state initially

        yield await _apiFuture.then((value) {
          // Handle the API response
          LoggerModule.log(
              message: 'callApiAsStream', name: runtimeType.toString());

          if ((value.status ?? 400) == 200) {
            headerResponse = value;
            return onSuccessHandle(value.data); // Handle success
          } else {
            return FailedState(
                message: value.message ?? value.error?.first ?? '',
                loggerName: runtimeType.toString());
          }
        });
      }
    } catch (e, stackTrace) {
      LoggerModule.log(
          message: 'error in api:',
          name: runtimeType.toString(),
          error: e,
          stackTrace: stackTrace);
      yield (await _handleOnError(e));
    }
  }

  /// Executes the API call and returns the result as a future.
  ///
  /// This method performs the API call and returns the result as an `ApiState<T>`
  /// wrapped in a future. It handles exceptions and token refreshing if needed.
  ///
  /// Returns:
  ///   A `Future<ApiState<T>>` representing the API call's result.
  Future<ApiState<T>> callApiAsFuture() async {
    try {
      bool isConnected = await _isInternetConnectionAvailable();
      if (!isConnected) {
        return NoInternetState();
      } else {
        return await _apiFuture.then((value) {
          if ((value.status ?? 400) == 200) {
            return onSuccessHandle(value.data); // Handle success
          } else {
            return FailedState(
                message: value.message ?? '',
                loggerName: runtimeType.toString());
          }
        });
      }
    } catch (e, stackTrace) {
      LoggerModule.log(
          message: 'error in api:',
          name: runtimeType.toString(),
          error: e,
          stackTrace: stackTrace);
      return (await _handleOnError(e));
    }
  }

  /// Handles errors and exceptions.
  Future<ApiState<T>> _handleOnError(Object e) async {
    if (e is DioException) {
      if (e.message == UnAuthorizedException().toString()) {
        // Token unauthorized, attempt token refresh
        if (!isFormLogin) {
          await refreshToken();
          callApiAsStream();
          return LoadingState();
        } else {
          return FailedState(
            message: e.response?.data['errors'][0] ?? S.current.generalError,
            loggerName: runtimeType.toString(),
          );
        }
      } else if (e.message == NoInternetDioException().toString()) {
        return NoInternetState(); // No internet connectivity
      } else if (e.message == CustomDioException().toString()) {
        return FailedState(
            message: e.error.toString(),
            loggerName: runtimeType.toString()); // Custom Dio exception
      } else {
        // Other exceptions
        LoggerModule.log(
            message: e.message ?? '',
            name: runtimeType.toString(),
            error: e,
            stackTrace: e.stackTrace);
        return ErrorState(
            message: e.message ?? '', loggerName: runtimeType.toString());
      }
    } else if (e is CheckedFromJsonException) {
      // Exception related to JSON deserialization
      LoggerModule.log(
          message: e.message ?? '',
          name: runtimeType.toString(),
          error: e,
          stackTrace: e.innerStack);
      return FailedState(
        message: S.current.generalError,
        loggerName: runtimeType.toString(),
      );
    } else {
      return FailedState(
        message: S.current.generalError,
        loggerName: runtimeType.toString(),
      );
    }
  }

  /// Handles the API response and returns an `ApiState<T>`.
  ///
  /// This abstract method must be implemented by subclasses to handle the
  /// API response and return an appropriate `ApiState<T>`. It is called when
  /// a successful API response is received.
  ///
  /// Parameters:
  ///   - response: The API response data.
  ///
  /// Returns:
  ///   An `ApiState<T>` representing the result of handling the response.
  ApiState<T> onSuccessHandle(K? response);

  /// Refreshes the authentication token.
  ///
  /// This abstract method must be implemented by subclasses to handle the
  /// token refreshing process. It is called when the API request encounters
  /// an unauthorized token.
  ///
  /// Returns:
  ///   A future with a boolean value indicating the success of token refresh.
  Future<bool> refreshToken();
}
