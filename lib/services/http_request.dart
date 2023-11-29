import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/utils/app_util.dart';

class HttpRequest {
  static final BaseOptions baseOptions = BaseOptions(
    baseUrl:HttpConfig.baseURL,
    connectTimeout: HttpConfig.timeout
  );

  static Future<T> request<T>(String url, {
    String method = "get",
    Map<String, dynamic>? params,
    Interceptor? inter}) async {
    final Dio dio = Dio(baseOptions);
    final options = Options(method: method, contentType: "application/x-www-form-urlencoded");

    Interceptor dInter = InterceptorsWrapper(onRequest: (options, handler) {
      if(url == HttpConfig.getCode) {
        options.responseType = ResponseType.bytes;
      }
      options.queryParameters["source"] = "APP";
      if(APPUtil().getAppVersion() != null) {
        options.queryParameters["app_version"] = APPUtil().getAppVersion()!;
      }
      print(options.queryParameters);

      return handler.next(options);
    }, onResponse: (res, handler) {
      return handler.next(res);
    }, onError: (err, handler) {
      return handler.next(err);
    });

    List<Interceptor> inters = [dInter];

    if (inter != null) {
      inters.add(inter);
    }
    
    dio.interceptors.addAll(inters);
    // 2.发送网络请求
    try {
      Response response = await dio.request(url, queryParameters: params, options: options);
      return response.data;
    } on DioError catch(e) {
      return Future.error(e);
    }
  }

}
