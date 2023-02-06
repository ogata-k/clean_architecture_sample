import 'package:dio/dio.dart' as dio;

typedef HttpClientOptions = dio.BaseOptions;
typedef HttpRequestOptions = dio.Options;
typedef RequestCancelToken = dio.CancelToken;
typedef ProgressCallback = dio.ProgressCallback;

class HttpResponse<T> {
  final dio.Response<T> _response;

  const HttpResponse(this._response);

  int? get statusCode => _response.statusCode;

  T? get data => _response.data;
}

class HttpClient {
  final dio.Dio _client;

  const HttpClient._(this._client);

  factory HttpClient.create() => HttpClient._(dio.Dio());

  factory HttpClient.createFrom(HttpClientOptions options) =>
      HttpClient._(dio.Dio(options));

  Future<HttpResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    HttpRequestOptions? options,
    RequestCancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) =>
      _client
          .get<T>(path,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onReceiveProgress: onReceiveProgress)
          .then((response) => HttpResponse(response));

  Future<HttpResponse<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    HttpRequestOptions? options,
    RequestCancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      _client
          .post<T>(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onReceiveProgress: onReceiveProgress)
          .then((response) => HttpResponse(response));

  Future<HttpResponse<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    HttpRequestOptions? options,
    RequestCancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      _client
          .put<T>(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress)
          .then((response) => HttpResponse(response));

  Future<HttpResponse<T>> head<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    HttpRequestOptions? options,
    RequestCancelToken? cancelToken,
  }) =>
      _client
          .head<T>(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken)
          .then((response) => HttpResponse(response));

  Future<HttpResponse<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    HttpRequestOptions? options,
    RequestCancelToken? cancelToken,
  }) =>
      _client
          .delete<T>(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken)
          .then((response) => HttpResponse(response));

  Future<HttpResponse<T>> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    HttpRequestOptions? options,
    RequestCancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      _client
          .patch<T>(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress)
          .then((response) => HttpResponse(response));
}
