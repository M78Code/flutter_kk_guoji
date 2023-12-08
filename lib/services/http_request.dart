import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/utils/app_util.dart';
import 'package:kkguoji/utils/sqlite_util.dart';

import 'cache_key.dart';

class HttpRequest {

  static HttpRequest? _instance;

  HttpRequest._internal();

  static HttpRequest get instance {
    _instance ??= HttpRequest._internal();
    return _instance!;
  }

  final BaseOptions _baseOptions = BaseOptions(
    baseUrl:HttpConfig.baseURL,
    connectTimeout: HttpConfig.timeout
  );
  late final Dio _dio = Dio(_baseOptions);

  Future<T> fetch<T>(String url, {
    String method = "get",
    Map<String, dynamic>? params,
    Interceptor? inter}) async {
    final options = Options(method: method, contentType: "application/x-www-form-urlencoded");

    List<Interceptor> inters = [RequestInterceptors()];

    if (inter != null) {
      inters.add(inter);
    }

    _dio.interceptors.addAll(inters);
    // 2.发送网络请求
    try {
      Response response = await _dio.request(url, queryParameters: params, options: options);
      return response.data;
    } on DioError catch(e) {
      return Future.error(e);
    }
  }

  static Future<T> request<T>(String url, {
    String method = "get",
    Map<String, dynamic>? params,
    Interceptor? inter}) async {
    return HttpRequest.instance.fetch(url,method: method,params: params,inter: inter);
  }
}

class RequestInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if(options.path == HttpConfig.getCode) {
      options.responseType = ResponseType.bytes;
    }
    options.queryParameters["source"] = "APP";
    if(APPUtil().getAppVersion() != null) {
      options.queryParameters["app_version"] = APPUtil().getAppVersion()!;
    }
    if(SqliteUtil().getString(CacheKey.apiToken) != null) {
      options.headers["Authorization"] = "Bearer ${SqliteUtil().getString(CacheKey.apiToken)!}";
    }
    print(options.queryParameters);

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(
      DioError err,
      ErrorInterceptorHandler handler,
      ) {
    return handler.next(err);
  }
}