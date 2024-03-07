import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart';

import '../common/app_const.dart';
import '../common/utils.dart';
import '../routes/app_route.dart';
import 'ExceptionHandle.dart';

class HttpUtil {
  static late Dio _dio;
  static late DateTime _startTime;
  static late DateTime _endTime;

  static getDio() {
    return _dio;
  }

  static void setToken({required String token}) {
    _dio.options.headers['Authorization'] = 'Bearer ' + token;
  }

  static void init() {
    Get.log('############    NetworkManager');

    _dio = Dio();
  //  _dio.options.headers['User-Agent'] = 'MOBILE';
    //_dio.options.headers['Content-Type'] = 'multipart/form-data';

    // 인증기관 처리 무시 하고 처리

    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };

//    _dio.options.baseUrl = APP_CONST.BASE_URL;
    _dio.options.connectTimeout =
        const Duration(milliseconds: APP_CONST.connectTimeout);
    _dio.options.receiveTimeout =
        const Duration(milliseconds: APP_CONST.receiveTimeout);

    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        _startTime = DateTime.now();
        Get.log('----------Start----------');
        if (options.queryParameters.isEmpty) {
          Get.log('RequestUrl: ${options.baseUrl}${options.path}');
        } else {
          Get.log(
              'RequestUrl: ${options.baseUrl}${options.path}?${Transformer.urlEncodeMap(options.queryParameters)}');
        }

        Get.log('RequestMethod: ${options.method}');
        Get.log('RequestHeaders:${options.headers}');
        Get.log('RequestContentType: ${options.contentType}');
        Get.log('RequestData: ${options.data.toString()}');

        return handler.next(options);
      }, onResponse: (response, handler) {
        _endTime = DateTime.now();
        final duration = _endTime.difference(_startTime).inMilliseconds;
        if (response.statusCode == ExceptionHandle.success) {
          Get.log('ResponseCode: ${response.statusCode}');
        } else {
          Get.log('ResponseCode: ${response.statusCode}');
        }

        //Get.log(response.data.toString());
        Get.log('----------End: $duration milliseconds----------');

        return handler.next(response); // continue
      }, onError: (error, handler) {
        if (DioErrorType.connectionTimeout == error.type) {
          Get.log(''
              'Timeout error #############################');
          Utils.gErrorMessage('서버 응답이 없습니다.');
        }
        if (DioErrorType.unknown == error.type) {
          Get.log('Timeout error #############################');
          Utils.gErrorMessage('인터넷 연결을 확인해주세요. ');
        } else if (DioErrorType.receiveTimeout == error.type) {
          Get.log('Timeout error #############################');
          Utils.gErrorMessage('응답 시간이 지연되었습니다. 다시 시도해 주세요. ');
        }

        Get.log(
            'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
        if (error.response?.statusCode == 401) {
          // 인증 실패 시 401
          Get.log('dio InterceptorsWrapper  onError - 401');
          Utils.gErrorMessage('인증이 만료되었습니다. 다시 로그인하시기 바랍니다.', title: '알림');

          //Get.offNamed(Routes.LOGIN);
        }
        if (error.response?.statusCode == 302) {
          // 로그인 인증 실패 시 403
          Get.log('로그인 인증 실패');
        }
        return handler.next(error); // continue
      }),
    );
  }
}
