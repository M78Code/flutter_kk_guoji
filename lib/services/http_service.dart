import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/sqlite_service.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/app_util.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/widget/show_toast.dart';

import '../utils/sqlite_util.dart';
import 'cache_key.dart';

class HttpService extends GetxService {
  static HttpService get to => Get.find();
  late final Dio _dio;
  final BaseOptions _baseOptions = BaseOptions(baseUrl: HttpConfig.baseURL, connectTimeout: HttpConfig.timeout);

  @override
  void onInit() {
    super.onInit();

    _dio = Dio(_baseOptions);

    // 拦截器
    _dio.interceptors.add(RequestInterceptors());
    _dio.interceptors.add(DioLogInterceptor());
  }

  Future<T> fetch<T>(String url, {String method = "get", Map<String, dynamic>? params, FormData? data, Interceptor? inter}) async {
    final options = Options(method: method, contentType: "application/x-www-form-urlencoded");

    if (inter != null) {
      _dio.interceptors.add(inter);
    }

    // 2.发送网络请求
    try {
      Response response = await _dio.request(url, queryParameters: params, data: data, options: options);
      return response.data;
    } on DioError catch (e) {
      Response errResponse = e.response!;
      final msg = errResponse.data["message"];
      final code = errResponse.data["code"];
      if (code == 1001) {
        RouteUtil.pushToView(Routes.loginPage, offAll: true);
      } else {
        ShowToast.showToast(msg);
      }
      return Future.error(e);
    }
  }

  static Future<T> request<T>(String url, {String method = "get", Map<String, dynamic>? params, Interceptor? inter}) async {
    return HttpService.to.fetch(url, method: method, params: params, inter: inter);
  }

// static Future<T> uploadImage<T>(String url, {String method = "post", Map<String, dynamic>? params, Interceptor? inter}) async {
//   return  Dio().post(url, data: params);
// }
}

class RequestInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path == HttpConfig.getCode) {
      options.responseType = ResponseType.bytes;
    }
    options.queryParameters["source"] = "APP";
    if (APPUtil().getAppVersion() != null) {
      options.queryParameters["app_version"] = APPUtil().getAppVersion()!;
    }
    if (Get.find<SqliteService>().getString(CacheKey.apiToken) != null) {
      options.headers["Authorization"] = "Bearer ${Get.find<SqliteService>().getString(CacheKey.apiToken)!}";
    }
    // print(options.queryParameters);

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data!;
    if (data["code"] == 401) {
      SqliteUtil().remove(CacheKey.apiToken);
      Get.find<UserService>().isLogin = false;
      // RouteUtil.pushToView(Routes.loginPage);
    } else {
      return handler.next(response);
    }
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    int? code = err.response?.statusCode;
    print("code = $code");
    // int? statusCode = err.response?.statusCode;
    // int? code = err.response?.data["code"];
    if (code == 401 || code == 1001) {
      SqliteUtil().remove(CacheKey.apiToken);
      Get.find<UserService>().isLogin = false;
      RouteUtil.pushToView(Routes.loginPage, offAll: true);
    } else {
      return handler.next(err);
    }
  }
}

class HttpRequest {
  static Future<T> request<T>(
    String url, {
    String method = "get",
    Map<String, dynamic>? params,
    FormData? data,
    Interceptor? inter,
  }) async {
    return HttpService.to.fetch(url, method: method, params: params, data: data, inter: inter);
  }
}
