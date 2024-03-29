import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/sqlite_service.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/app_util.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:oktoast/oktoast.dart';

import '../utils/sqlite_util.dart';
import '../widget/show_toast.dart';
import 'cache_key.dart';

class HttpService extends GetxService {
  static HttpService get to => Get.find();
  late final Dio _dio;
  final BaseOptions _baseOptions =
      BaseOptions(baseUrl: HttpConfig.baseURL, connectTimeout: HttpConfig.timeout);

  @override
  void onInit() {
    super.onInit();

    _dio = Dio(_baseOptions);

    // 拦截器
    _dio.interceptors.add(RequestInterceptors());
    _dio.interceptors.add(DioLogInterceptor());
  }

  Future<T> fetch<T>(
    String url, {
    String method = "get",
    Map<String, dynamic>? params,
    FormData? data,
    Interceptor? inter,
    String contentType = "application/x-www-form-urlencoded",
  }) async {
    final options = Options(method: method, contentType: contentType);

    if (inter != null) {
      _dio.interceptors.add(inter);
    }

    // 2.发送网络请求
    try {
      Response response =
          await _dio.request(url, queryParameters: params, data: data, options: options);
      final responseData = response.data;
      if (responseData is Uint8List) {
      } else if (responseData["code"] == 401) {
        ShowToast.showToast(responseData["message"]);
        Get.find<UserService>().logout();
        // SqliteUtil().remove(CacheKey.apiToken);
        // Get.find<UserService>().isLogin = false;
        // Get.find<UserService>().userInfoModel.value = null;
        RouteUtil.pushToView(Routes.loginPage, offAll: true);
        return Future.error("");
        // return Future.error(error);
      }
      return responseData;
    } on DioError catch (e) {
      Response? errResponse = e.response;
      String msg = errResponse?.data["message"] ?? "";
      final code = errResponse?.data["code"];
      if (code == 1001) {
        Get.find<UserService>().logout();
        RouteUtil.pushToView(Routes.loginPage, offAll: true);
      } else {
        if (msg.isNotEmpty) {
          showToast(msg);
        }
      }
      return Future.error(e);
    }
  }

  static Future<T> request<T>(String url,
      {String method = "get", Map<String, dynamic>? params, Interceptor? inter}) async {
    return HttpService.to.fetch(url, method: method, params: params, inter: inter);
  }

  // static Future<Response<T>> uploadImage<T>(
  //   String url,
  //   FormData formData,
  // ) async {
  //   //通过FormData
  //   return HttpService.to._dio.post(
  //     url,
  //     data: formData,
  //     options: Options(contentType: "multipart/form-data"),
  //   );
  // }

  /// 封装form-data数据的方法
  static Future<T> uploadImage<T>(String path, params) async {
    return HttpService.to
        .fetch(path, method: "POST", data: params, contentType: "multipart/form-data");
  }
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
      options.headers["Authorization"] =
          "Bearer ${Get.find<SqliteService>().getString(CacheKey.apiToken)!}";
      options.headers['User-Agent'] = FkUserAgent.userAgent;
    }
    // print(options.queryParameters);

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      final data = response.data!;
      if (data["code"] == "401" || data["code"] == 401) {
        SqliteUtil().remove(CacheKey.apiToken);
        Get.find<UserService>().isLogin = false;
        // RouteUtil.pushToView(Routes.loginPage);
      } else {
        return handler.next(response);
      }
    } catch (e) {
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
    if(err.type == DioErrorType.connectTimeout) {
      ShowToast.showToast("已断开网络连接,请检查您的网络连接是否正常!");
    }if (code == 401 || code == 1001) {
      Get.find<UserService>().logout();
      Get.defaultDialog(
          titlePadding: EdgeInsets.zero,
          title: "",
          backgroundColor: const Color(0xFF171A26),
          content: Container(
            alignment: Alignment.center,
            child: const Text(
              "由于等待时间过长，您的账号已退出，请重新登录。",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          cancel: Container(
            width: 100,
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () {
                Get.back();
                RouteUtil.pushToView(Routes.loginPage, offAll: true);
              },
              child: const Text(
                "确认",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ));
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
    String contentType = "application/x-www-form-urlencoded",
  }) async {
    return HttpService.to.fetch(url,
        method: method, params: params, contentType: contentType, data: data, inter: inter);
  }

// static Future<Response<T>> uploadFile<T>(String url, File file) async {
//   return HttpService.uploadImage(url, file);
// }
}
