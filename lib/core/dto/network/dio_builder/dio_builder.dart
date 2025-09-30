import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

export 'dart:io';
export 'package:chucker_flutter/chucker_flutter.dart';
export 'package:dio/dio.dart';
export 'package:dio_smart_retry/dio_smart_retry.dart';
export 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'dio_client.dart';

/// The `DioBuilder` class provides a builder pattern for configuring and creating instances of the Dio HTTP client.
/// It abstracts common configurations and interceptors for making HTTP requests.
class DioBuilder {
  bool _allowBadRequest = false;
  String _baseApiUrl = ''; // Stores the base API URL
  bool _allowRetry = false;
  Dio dio = Dio();
  ResponseType _responseType = ResponseType.json;
  String _contentType = "application/json";
  bool _persistentConnection = true;
  bool _followRedirects = true;
  int _maxRedirects = 5;
  ListFormat _listFormat = ListFormat.multiCompatible;
  String? _method;
  Map<String, dynamic>? _extra;
  Map<String, dynamic>? _headers;
  Map<String, dynamic>? _queryParameters;
  bool _receiveDataWhenStatusError = true;
  int _defaultTimeOut = 15;

  /// Initializes the DioBuilder instance with default configurations.
  void initialize() {
    _clearInterceptors();
    addLogger();
    allowRetryInFailed();
    dio.options = _buildBaseOption();
    dio.interceptors.add(_interceptorsWrapper);
    if (_allowBadRequest) {
      dio.httpClientAdapter = Http2Adapter(ConnectionManager(
        idleTimeout: const Duration(seconds: 10),
        onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
      ));
    }
  }

  /// Clears old interceptors if they exist, called every time you call initialize.
  void _clearInterceptors() {
    if (dio.interceptors.isNotEmpty) {
      dio.interceptors.clear();
    }
  }

  /// Adds a logger interceptor to the Dio client for logging HTTP requests and responses.
  /// The logger can be printed to the console or integrated with the Chucker library for more detailed logs.
  DioBuilder addLogger({bool allowChucker = true, bool printLog = true}) {
    if (allowChucker) {
      dio.interceptors.add(ChuckerDioInterceptor());
    }
    if (printLog) {
      dio.interceptors.add(PrettyDioLogger(
        request: true,
        enabled:  true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
    }
    return this;
  }

  /// Adds a retry interceptor to the Dio client for automatically retrying failed requests.
  /// The number of retries can be specified with the `retryCount` parameter (default is 3).
  DioBuilder allowRetryInFailed({int retryCount = 3}) {
    if (_allowRetry) {
      dio.interceptors.add(RetryInterceptor(
        dio: dio,
        retries: retryCount,
        retryDelays: List.generate(
          retryCount,
          (index) => Duration(seconds: retryCount + index),
        ),
      ));
    }
    return this;
  }

  /// Enables or disables the ability to handle bad SSL certificates or invalid HTTPS connections.
  /// This can be useful for testing or development purposes but should be used with caution.
  DioBuilder allowBadRequest(bool value) {
    _allowBadRequest = value;
    return this;
  }

  /// Sets the default timeout for network requests, in seconds.
  DioBuilder setDefaultTimeOut(int value) {
    _defaultTimeOut = value;
    dio.options.connectTimeout = Duration(seconds: value);
    dio.options.receiveTimeout = Duration(seconds: value);
    dio.options.sendTimeout = Duration(seconds: value);
    initialize();
    return this;
  }

  /// Sets the response type for the HTTP requests.
  DioBuilder setResponseType(ResponseType value) {
    _responseType = value;
    dio.options.responseType = value;
    initialize();
    return this;
  }

  /// Sets the content type for the HTTP requests.
  DioBuilder setContentType(String value) {
    _contentType = value;
    dio.options.contentType = value;
    initialize();
    return this;
  }

  /// Sets whether the connection should be persistent or not.
  DioBuilder setPersistentConnection(bool value) {
    _persistentConnection = value;
    dio.options.persistentConnection = value;
    initialize();
    return this;
  }

  /// Sets whether the client should follow redirects or not.
  DioBuilder setFollowRedirects(bool value) {
    _followRedirects = value;
    dio.options.followRedirects = value;
    initialize();
    return this;
  }

  /// Sets the maximum number of redirects to follow.
  DioBuilder setMaxRedirects(int value) {
    _maxRedirects = value;
    dio.options.maxRedirects = value;
    initialize();
    return this;
  }

  /// Sets extra options to be included in the requests.
  DioBuilder setExtras(Map<String, dynamic> value) {
    _extra = value;
    dio.options.extra = value;
    initialize();
    return this;
  }

  /// Sets the headers to be included in the requests.
  DioBuilder setHeaders(Map<String, dynamic> value) {
    _headers = value;
    dio.options.headers = _headers;
    initialize();
    return this;
  }

  /// Sets the query parameters to be included in the requests.
  DioBuilder queryParameters(Map<String, dynamic> value) {
    _queryParameters = value;
    dio.options.queryParameters = value;
    initialize();
    return this;
  }

  DioBuilder allowRetry(bool value) {
    _allowRetry = value;
    return this;
  }

  /// Sets the format for lists serialization in the requests.
  DioBuilder setListFormat(ListFormat value) {
    _listFormat = value;
    dio.options.listFormat = value;
    initialize();
    return this;
  }

  /// Sets the HTTP method for the requests.
  DioBuilder setMethod(String value) {
    _method = value;
    dio.options.method = value;
    initialize();
    return this;
  }

  /// Sets whether to receive the response data when the status is an error or not.
  void setReceiveDataWhenStatusError(bool value) {
    _receiveDataWhenStatusError = value;
  }

  /// Checks if there is an internet connection between the client and server.
  /// Returns `true` if there is a connection, otherwise `false`.
  Future<bool> checkInternetConnection({String? lookUpAddress}) async {
    try {
      final result = await InternetAddress.lookup(lookUpAddress ?? baseUrl);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  /// Builds the Dio client with the configured options and interceptors.
  Dio build() {
    return dio;
  }

  /// Builds the base options for the Dio client.
  BaseOptions _buildBaseOption() => BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: _defaultTimeOut),
        receiveTimeout: Duration(seconds: _defaultTimeOut),
        sendTimeout: Duration(seconds: _defaultTimeOut),
        responseType: _responseType,
        contentType: _contentType,
        persistentConnection: _persistentConnection,
        followRedirects: _followRedirects,
        maxRedirects: _maxRedirects,
        extra: _extra,
        headers: _headers,
        listFormat: _listFormat,
        method: _method,
        queryParameters: _queryParameters,
        receiveDataWhenStatusError: _receiveDataWhenStatusError,
      );

  /// Returns the base URL based on the current environment.
  set baseUrl(String baseUrl) {
    _baseApiUrl = baseUrl;
  }

  String get baseUrl => _baseApiUrl.isNotEmpty
      ? _baseApiUrl
      : throw Exception("No URL has been set yet.");

  /// Wraps the interceptors for error, request, and response.
  InterceptorsWrapper get _interceptorsWrapper => InterceptorsWrapper(
        onError: (dioException, handler) =>
            handleOnError(dioException, handler),
        onRequest: (options, handler) => handleOnRequest(options, handler),
        onResponse: (response, handler) => handleOnResponse(response, handler),
      );

  /// Handles the error that occurred during the HTTP request.
  void handleOnError(
      DioException dioException, ErrorInterceptorHandler handler){
    handler.next(dioException);
  }

  /// Handles the request before it is sent.
  void handleOnRequest(
      RequestOptions options, RequestInterceptorHandler handler){
    handler.next(options);
  }

  /// Handles the response after it is received.
  void handleOnResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler){
    handler.next(response);
  }
}
