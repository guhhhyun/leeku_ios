import 'package:flutter/foundation.dart';

class APP_CONST {
  static const bool isProduction = kReleaseMode;

  //static const String BASE_URL = 'https://dev_she.dongkuk.com/'; // 안전신문고 개발 서버
//  static const String BASE_URL = 'https://mshe.dongkuk.com/'; // 운영서버


  static const int connectTimeout = 20000;
  static const int receiveTimeout = 20000;

  // json 테스트
  static const bool LOCAL_JSON_MODE = false;


}

// 한 계정에 하나의 ssh키만 가질수 있다.
// 맥북의
// 근데 내가 로그인 했던건 내 아이디 인데
