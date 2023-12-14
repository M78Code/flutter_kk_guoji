import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:get/get_core/src/get_main.dart';
import 'package:kkguoji/base/logic/gloabal_state_controller.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/utils/app_util.dart';
import 'package:kkguoji/utils/sqlite_util.dart';

import 'cache_key.dart';

class HttpService extends GetxService {

  static HttpService get to => Get.find();
  late final Dio _dio;
  final BaseOptions _baseOptions = BaseOptions(
    baseUrl:HttpConfig.baseURL,
    connectTimeout: HttpConfig.timeout
  );

  @override
  void onInit() {
    super.onInit();

    _dio = Dio(_baseOptions);

    // 拦截器
    _dio.interceptors.add(RequestInterceptors());
    _dio.interceptors.add(DioLogInterceptor());
  }

  Future<T> fetch<T>(String url, {
    String method = "get",
    Map<String, dynamic>? params,
    Interceptor? inter}) async {
    final options = Options(method: method, contentType: "application/x-www-form-urlencoded");

    if (inter != null) {
      _dio.interceptors.add(inter);
    }

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
    return HttpService.to.fetch(url,method: method,params: params,inter: inter);
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
    // print(options.queryParameters);

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
    int? statusCode = err.response?.statusCode;
    int? code = err.response?.data["code"];
    if(statusCode == 401 || code == 1001) {
      SqliteUtil().remove(CacheKey.apiToken);
      Get.find<GlobalStateController>().isLogin.value = false;
      return;
    }else {
      return handler.next(err);
    }
  }
}


class HttpRequest {
  static Future<T> request<T>(String url, {
    String method = "get",
    Map<String, dynamic>? params,
    Interceptor? inter}) async {
    return HttpService.to.fetch(url,method: method,params: params,inter: inter);
  }
}