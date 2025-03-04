part of 'dio_builder.dart';

typedef T = dynamic;

/// Performs a POST request to the specified endpoint.
///
/// [endPoint] - The API endpoint to send the POST request to.
/// [data] - The data to include in the request body.
/// [cancelToken] - (Optional) A token that can be used to cancel the request.
/// [onSendProgress] - (Optional) A callback to track the send progress.
/// [onReceiveProgress] - (Optional) A callback to track the receive progress.
Future<Response<T>> post(
    {required String endPoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    Function(int count, int total)? onSendProgress,
    Function(int count, int total)? onReceiveProgress}) async {
  try {
    final response = await DioBuilder().dio.post<T>(
      endPoint,
      data: data,
      cancelToken: cancelToken,
      onSendProgress: (count, total) {
        if (onSendProgress != null) {
          onSendProgress(count, total);
        }
      },
      onReceiveProgress: (count, total) {
        if (onReceiveProgress != null) {
          onReceiveProgress(count, total);
        }
      },
    );
    return response;
  } catch (e) {
    rethrow;
  }
}

/// Performs a delete request to the specified endpoint.
///
/// [endPoint] - The API endpoint to send the POST request to.
/// [data] - The data to include in the request body.
/// [cancelToken] - (Optional) A token that can be used to cancel the request.
Future<Response<T>> delete(
    {required String endPoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken}) async {
  try {
    final response = await DioBuilder().dio.delete<T>(
          endPoint,
          data: data,
          cancelToken: cancelToken,
        );
    return response;
  } catch (e) {
    rethrow;
  }
}

/// Performs a head request to the specified endpoint.
///
/// [endPoint] - The API endpoint to send the POST request to.
/// [data] - The data to include in the request body.
/// [cancelToken] - (Optional) A token that can be used to cancel the request.

Future<Response<T>> head(
    {required String endPoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken}) async {
  try {
    final response = await DioBuilder().dio.head<T>(
          endPoint,
          data: data,
          cancelToken: cancelToken,
        );
    return response;
  } catch (e) {
    rethrow;
  }
}

/// Performs a head request to the specified endpoint.
///
/// [endPoint] - The API endpoint to send the POST request to.
/// [data] - The data to include in the request body.
/// [cancelToken] - (Optional) A token that can be used to cancel the request.
/// [onSendProgress] - (Optional) A callback to track the send progress.
/// [onReceiveProgress] - (Optional) A callback to track the receive progress.
Future<Response<T>> request(
    {required String endPoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    Function(int count, int total)? onSendProgress,
    Function(int count, int total)? onReceiveProgress}) async {
  try {
    final response = await DioBuilder().dio.request<T>(
          endPoint,
          data: data,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
        );
    return response;
  } catch (e) {
    rethrow;
  }
}

/// Performs a put request to the specified endpoint.
///
/// [endPoint] - The API endpoint to send the POST request to.
/// [data] - The data to include in the request body.
/// [cancelToken] - (Optional) A token that can be used to cancel the request.
/// [onSendProgress] - (Optional) A callback to track the send progress.
/// [onReceiveProgress] - (Optional) A callback to track the receive progress.
Future<Response<T>> put(
    {required String endPoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    Function(int count, int total)? onSendProgress,
    Function(int count, int total)? onReceiveProgress}) async {
  try {
    final response = await DioBuilder().dio.put<T>(
          endPoint,
          data: data,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
        );
    return response;
  } catch (e) {
    rethrow;
  }
}

/// Performs a patch request to the specified endpoint.
///
/// [endPoint] - The API endpoint to send the POST request to.
/// [data] - The data to include in the request body.
/// [cancelToken] - (Optional) A token that can be used to cancel the request.
/// [onSendProgress] - (Optional) A callback to track the send progress.
/// [onReceiveProgress] - (Optional) A callback to track the receive progress.
Future<Response<T>> patch(
    {required String endPoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    Function(int count, int total)? onSendProgress,
    Function(int count, int total)? onReceiveProgress}) async {
  try {
    final response = await DioBuilder().dio.patch<T>(
          endPoint,
          data: data,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
        );
    return response;
  } catch (e) {
    rethrow;
  }
}

/// Performs a get request to the specified endpoint.
///
/// [endPoint] - The API endpoint to send the POST request to.
/// [cancelToken] - (Optional) A token that can be used to cancel the request.
/// [onReceiveProgress] - (Optional) A callback to track the receive progress.
Future<Response<T>> get(
    {required String endPoint,
    CancelToken? cancelToken,
    Function(int count, int total)? onReceiveProgress}) async {
  try {
    final response = await DioBuilder().dio.get<T>(
      endPoint,
      cancelToken: cancelToken,
      onReceiveProgress: (count, total) {
        if (onReceiveProgress != null) {
          onReceiveProgress(count, total);
        }
      },
    );
    return response;
  } catch (e) {
    rethrow;
  }
}
