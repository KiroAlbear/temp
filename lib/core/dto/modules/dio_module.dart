import 'package:deel/deel.dart';

abstract class DioModule extends DioBuilder {
  late RequestOptions _options;

  void init() {
    // Initialize DioModule with base URLs and configuration options
    allowRetryInFailed(retryCount: 0);
    allowRetry(false);
    setMaxRedirects(0);
    setDefaultTimeOut(30);
    // Configure logging based on the environment
    if (F.name == Flavor.app_live) {
      addLogger(allowChucker: true, printLog: false);
    } else {
      addLogger(allowChucker: true, printLog: true);
    }

    initialize();
    LoggerModule.log(
      message: 'DioModule.internal',
      name: runtimeType.toString(),
    );
  }

  // Remove custom headers from Dio instance
  void removeHeader() {
    Map<String, dynamic> header = {};
    setHeaders(header);
    initialize();
  }

  // Set custom headers, including authorization and language headers
  void setAppHeaders({String? customToken}) {
    Map<String, dynamic> header = {};
    if (SharedPrefModule().bearerToken != null || customToken != null) {
      header.putIfAbsent('token', () => _getBearerToken(customToken));
    }
    setHeaders(header);
    initialize();
  }

  // Get the Bearer token from the logged-in user or custom token
  String _getBearerToken(String? customToken) =>
      customToken ?? SharedPrefModule().bearerToken ?? '';

  // Handle Dio errors and exceptions
  @override
  handleOnError(DioException dioException, ErrorInterceptorHandler handler) {
    LoggerModule.log(
      message: 'error in api:',
      name: runtimeType.toString(),
      error: dioException,
      stackTrace: dioException.stackTrace,
    );
    switch (dioException.response?.statusCode) {
      case 401:
        handler.next(
          DioException(
            requestOptions: _options,
            message: UnAuthorizedException().toString(),
            response: dioException.response,
          ),
        );
      case -1:
        handler.next(
          DioException(
            requestOptions: _options,
            message: NoInternetDioException().toString(),
          ),
        );
      case 0:
        handler.next(
          DioException(
            requestOptions: _options,
            message: NoInternetDioException().toString(),
          ),
        );
      case 3:
        handler.next(
          DioException(
            requestOptions: _options,
            message: NoInternetDioException().toString(),
          ),
        );
      case -6:
        handler.next(
          DioException(
            requestOptions: _options,
            error: NoInternetDioException().toString(),
          ),
        );
      case -3:
        handler.next(
          DioException(
            requestOptions: _options,
            message: NoInternetDioException().toString(),
          ),
        );
      default:
        try {
          final HeaderResponse headerResponse = HeaderResponse.fromJson(
            dioException.response?.data,
            (json) => null,
          );
          handler.next(
            DioException(
              requestOptions: _options,
              message: CustomDioException().toString(),
              type: DioExceptionType.badResponse,
              error: headerResponse.message ?? '',
            ),
          );
        } catch (e) {
          handler.next(
            DioException(
              requestOptions: _options,
              message: CustomDioException().toString(),
              type: DioExceptionType.badResponse,
              error:
                  dioException.error ??
                  Loc.of(Routes.rootNavigatorKey.currentContext!)!.generalError,
            ),
          );
        }
    }
  }

  // Intercept the request and store request options for error handling
  @override
  handleOnRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LoggerModule.log(message: baseUrl, name: runtimeType.toString());
    _options = options;
    return handler.next(options);
  }

  // Intercept the response and handle success and failure scenarios
  @override
  handleOnResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _logApiRequestAndResponse(response);
    if (response.data == null) {
      throw DioException.badResponse(
        statusCode: 500,
        requestOptions: _options,
        response: response,
      );
    } else {
      try {
        final HeaderResponse headerResponse = HeaderResponse.fromJson(
          response.data,
          (json) => null,
        );
        if (headerResponse.status! == 200) {
          return handler.next(response);
        } else {
          throw DioException.badResponse(
            statusCode: 405,
            requestOptions: _options,
            response: response,
          );
        }
      } catch (e) {
        final AdminHeaderResponse headerResponse = AdminHeaderResponse.fromJson(
          response.data,
          (json) => null,
        );
        if ((headerResponse.isSuccess ?? false) == true) {
          return handler.next(response);
        } else {
          throw DioException.badResponse(
            statusCode: 405,
            requestOptions: _options,
            response: response,
          );
        }
      }
    }
  }

  void _logApiRequestAndResponse(Response<dynamic> response) {
    LoggerModule.log(
      message:
          'api log:'
          'api url: ${_options.path}\n'
          'body: ${_options.data.toString()}\n'
          'header: ${_options.headers.toString()}\n'
          'query: ${_options.queryParameters.toString()}'
          'response: ${response.toString()}',
      name: runtimeType.toString(),
    );
  }
}

// Custom exceptions for Dio errors
class NoInternetDioException implements Exception {}

class UnAuthorizedException implements Exception {}

class CustomDioException implements Exception {}
