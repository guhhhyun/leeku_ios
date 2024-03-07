import 'dart:convert';
import 'dart:developer';

import 'package:egu_industry/app/common/utils.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'network_manager.dart';
import 'package:http/http.dart' as http;

class HomeApi {
  static HomeApi get to => Get.find();

  Future<String?> EXEC(
      String MODE,
      String CODE,
      Map? PARAMS, {
        String? url = null,
        String? service_name = null,
        String? auth = null,
        String ContentType = 'application/json',
      }) async {
    Map<String, dynamic> data = {};
    String result = "";
    Object? exception = null;
    try {
      if (url == null) url = '121.133.99.66:3000';
      //if (url == null) url = '10.0.2.2:3000';
      if (service_name == null) service_name = '/';

      var RequestUri = Uri.http(url, service_name);
      var params;
      if (PARAMS != null) params = json.encode(PARAMS);
      Map<String, dynamic> data = {
        //'SERVICE':'LEEKU_MES',
        'MODE': MODE,
        'CODE': CODE,
        'PARAMS': params,
        'AUTH': auth,
      };
      var response = await http.post(
          RequestUri,
          headers: {'Content-Type': ContentType},
          body: json.encode(data)
      ).timeout(const Duration(seconds: 10));
      result = utf8.decode(response.bodyBytes);
      return result;
    } catch (ex) {
      exception = ex;
     // Utils.gErrorMessage('네트워크 오류');
    } finally {
      log({
        'url': url,
        'service_name': service_name,
        'MODE': MODE,
        'CODE': CODE,
        'PARAMS': PARAMS
      }.toString());
      log({'DATA': data, 'RESULT': result, 'EXCEPTION': exception}.toString());
    }
  }

  Future<String?> EXEC22(
      String MODE,
      String CODE,
      Map? PARAMS, {
        String? url = null,
        String? service_name = null,
        String? auth = null,
        int timeoutSec = 10,
        String ContentType = 'application/json',
        Map<String, dynamic>? OPTION = null,
      }) async {
    Map<String, dynamic> data = {};
    String result = "";
    Object? exception = null;
    try {
      if (url == null) url = 'mes1.leeku.co.kr:7000';
      if (service_name == null) service_name = 'WebAPI/';

      var RequestUri = Uri.http(url, service_name);
      var params;
      if (PARAMS != null) params = json.encode(PARAMS);
      Map<String, dynamic> data = {
        'SERVICE':'LEEKU_IF',
        'MODE': MODE,
        'CODE': CODE,
        'PARAM': params,
        'AUTH' : auth,
      };
      if(OPTION != null){
        data.addAll(OPTION!);
      }
      var response = await http.post(
          RequestUri,
          headers: {'Content-Type': ContentType},
          body: json.encode(data)
      ).timeout(Duration(seconds: timeoutSec));
      result = utf8.decode(response.bodyBytes);
      return result;
    }catch(ex){
      exception = ex;
      Utils.gErrorMessage('네트워크 오류');
    }finally{
      log({'url':url,'service_name':service_name,'MODE':MODE,'CODE':CODE,'PARAMS':PARAMS}.toString());
      log({'DATA':data, 'RESULT':result, 'EXCEPTION':exception}.toString());
    }
  }


  Future<Map> PROC(String procName, Map? PARAMS) async {
    String res = await EXEC2("PROC", procName, PARAMS) ?? "";
    Map data = json.decode(res);
    return data;
  }

  Future<Map> PROC23(String procName, Map? PARAMS) async {
    String res = await EXEC("PROC", procName, PARAMS) ?? "";
    Map data = json.decode(res);
    return data;
  }

  Future<Map> BIZ_DATA(String BizComponentID) async {
    String res = await EXEC2("PROC", 'P_BizComponentQuery_R', {'BizComponentID':BizComponentID}) ?? "";

    Map data = json.decode(res);
    return data;
  }



  Future<String?> EXEC2(
  String MODE,
  String CODE,
  Map? PARAMS, {
        String? url = null,
        String? service_name = null,
        String? auth = null,
        int timeoutSec = 10,
        String ContentType = 'application/json',
        Map<String, dynamic>? OPTION = null,
      }) async {
    Map<String, dynamic> data = {};
    String result = "";
    Object? exception = null;
    try {
      if (url == null) url = 'mes1.leeku.co.kr:7000';
      if (service_name == null) service_name = 'WebAPI/';

      var RequestUri = Uri.http(url, service_name);
      var params;
      if (PARAMS != null) params = json.encode(PARAMS);
      Map<String, dynamic> data = {
        //'SERVICE':'LEEKU_MES',
        'MODE': MODE,
        'CODE': CODE,
        'PARAM': params,
        'AUTH' : auth,
      };
      if(OPTION != null){
        data.addAll(OPTION!);
      }
      var response = await http.post(
          RequestUri,
          headers: {'Content-Type': ContentType},
          body: json.encode(data)
      ).timeout(Duration(seconds: timeoutSec));
      result = utf8.decode(response.bodyBytes);
      return result;
    }catch(ex){
      exception = ex;
      Utils.gErrorMessage('네트워크 오류');
    }finally{
     log({'url':url,'service_name':service_name,'MODE':MODE,'CODE':CODE,'PARAMS':PARAMS}.toString());
     log({'DATA':data, 'RESULT':result, 'EXCEPTION':exception}.toString());
    }
  }


/*
  Future<List> PROCS(String procName, Map? PARAMS) async {
    String res = await EXEC2("PROC", procName, PARAMS) ?? "";
    Map data = json.decode(res);
    Get.log('aaaaa ${data["RESULT"]}');
    return data["RESULT"]["OUTPUTS"];
  }
*/

  Future<Map> REPORT_MONO_BITMAP(String PrintType, Map? PARAMS, {int DPI = 200}) async {
    String res = await EXEC2("REPORT_MONO_BITMAP", PrintType, PARAMS, OPTION: {"DPI":DPI}) ?? "";
    Map data = json.decode(res);
    Map RESULT = data["RESULT"];
    RESULT["FILE"] = base64Decode(RESULT["FILE"]);
    return RESULT;
  }

  Future<Map> RCV_DATA_PERIOD(String? WorkType, Map? PARAMS) async{
    String res = await EXEC2("RCV_DATA_PERIOD", "PUSH_NOTIFY", PARAMS, timeoutSec: 20*60) ?? "";
    Map data = json.decode(res);
    return data["RESULT"]["DATAS"][0];
  }

  Future<String> FILE_UPLOAD(String PATH, Uint8List FILE) async {
    String res = await EXEC2("UPLOAD_FILE", "", {"PATH":PATH,"FILE": base64Encode(FILE)}) ?? "";
    Map data = json.decode(res);
    String RET_PATH = data["RESULT"]["PATH"];
    return RET_PATH;
  }
  Future<Uint8List> FILE_DOWNLOAD(String PATH) async {
    String res = await EXEC2("DOWNLOAD_FILE", "", {"PATH":PATH,}) ?? "";
    Map data = json.decode(res);
    Map RESULT = data["RESULT"];
    RESULT["FILE"] = base64Decode(RESULT["FILE"]);
    return RESULT["FILE"];
  }

  Future<Map> PROC22(String procName, Map? PARAMS) async {
    String res = await EXEC2("PROC", procName, PARAMS) ?? "";
    Map data = json.decode(res);
    return data;
  }

  Future<String> LOGIN_MOB(String USER_ID, String PWD) async {
    String res = await EXEC2("LOGIN_MOB", "", {"USER_ID":USER_ID,"PWD":PWD}) ?? "";
    Map data = json.decode(res);
    String STATUS = data["STATUS"];
    return STATUS;
  }





/*


  /// 로그인....`
  Future<bool> reqLogin(var params) async {
    var userModel = UserModel();

    try {
      final response =
      await HttpUtil.getDio().post('shem/login.sm', data: params);

      if (response.data['rtnCd'] == "00") {
        userModel = UserModel.fromJson(response.data['rtnData']['userInfo']);

        GlobalService.to.authToken = userModel.tokn;

        HttpUtil.setToken(token: userModel.tokn);
        await Utils.getStorage.write('userId', params['userId']);
        await Utils.getStorage.write('userPw', params['userPw']);
        await Utils.getStorage.write('authToken', userModel.tokn);
        GlobalService.to.setLoginInfo(userModel: userModel);
        return true;
      } else {
        Utils.gErrorMessage('${response.data['rtnMsg']}', title: '로그인 실패');
      }
    } on DioError catch (e) {
      Get.log('reqTest - login error');
      //commonError(e);
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 신고유형 불러오기
  Future<List<dynamic>> reqReportType() async {
    List<dynamic> typeModelList = [];

    var params = {
      'cdGrp': "PRPS_TYPE_CD",
    };

    try {
      final response = await HttpUtil.getDio()
          .post('cmon/code/searchCmonCdList.sm', data: params);

      if (response.data['rtnCd'] == "00") {
        for (int i = 0; i < response.data['rtnData']['result'].length; i++) {
          typeModelList.add(response.data['rtnData']['result'][i]);
        }

        return typeModelList;
      } else {
        Utils.gErrorMessage('Data Load Fail!', title: '신고유형 불러오기 실패');
      }
    } on DioError catch (e) {
      Get.log('reqTest - type error');
      //commonError(e);
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return typeModelList;
  }

  /// 신고장소 불러오기
  Future<List<dynamic>> reqReportPlace() async {
    List<dynamic> placeModelList = [];

    var params = {
      'cdGrp': "PLACE1_CD",
    };

    try {
      final response = await HttpUtil.getDio()
          .post('cmon/code/searchCmonCdList.sm', data: params);

      if (response.data['rtnCd'] == "00") {
        for (int i = 0; i < response.data['rtnData']['result'].length; i++) {
          placeModelList.add(response.data['rtnData']['result'][i]);
        }

        return placeModelList;
      } else {
        Utils.gErrorMessage('Data Load Fail!', title: '신고유형 불러오기 실패');
      }
    } on DioError catch (e) {
      Get.log('reqTest - place error');
      //commonError(e);
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return placeModelList;
  }

  /// 신고라인 불러오기
  Future<List<dynamic>> reqReportLine() async {
    List<dynamic> lineModelList = [];

    var params = {
      'cdGrp': "PLACE2_CD",
    };

    try {
      final response = await HttpUtil.getDio()
          .post('cmon/code/searchCmonCdList.sm', data: params);

      if (response.data['rtnCd'] == "00") {
        for (int i = 0; i < response.data['rtnData']['result'].length; i++) {
          lineModelList.add(response.data['rtnData']['result'][i]);
        }

        return lineModelList;
      } else {
        Utils.gErrorMessage('Data Load Fail!', title: '신고유형 불러오기 실패');
      }
    } on DioError catch (e) {
      Get.log('reqTest - line error');
      //commonError(e);
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return lineModelList;
  }

  /// 조직트리 불러오기.
  Future<OrganizationTreeModel> reqOrganizationTree() async {
    var organizationTreeModel = OrganizationTreeModel();

    Get.log('organizationTreeModelList');

    try {
      if (APP_CONST.LOCAL_JSON_MODE) {
        Get.log('로컬모드 제이슨없어 ㅠ');
        // var urlPath = 'assets/json/login.json';
        // final jsonResponse = await localJsonPaser(urlPath);
        // loginModel = LoginModel.fromJson(jsonResponse);
      } else {
        Get.log('서버모드');
        final response = await HttpUtil.getDio()
            .get('ses/cmon/searchOrgTree.sm' //, queryParameters: params
        );
        organizationTreeModel = OrganizationTreeModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      Get.log('reqTest - tree error');
      //commonError(e);
    } catch (err) {
      Get.log('reqOrganizationTree = ${err.toString()}');
    }
    return organizationTreeModel;
  }

  /// 조직도 불러오기.
  Future<OrganizationModel> reqOrganization() async {
    var organizationModel = OrganizationModel();

    Get.log('organizationModelList');

    try {
      if (APP_CONST.LOCAL_JSON_MODE) {
        Get.log('로컬모드 제이슨없어 ㅠ');
        // var urlPath = 'assets/json/login.json';
        // final jsonResponse = await localJsonPaser(urlPath);
        // loginModel = LoginModel.fromJson(jsonResponse);
      } else {
        Get.log('서버모드');

        final response = await HttpUtil.getDio()
            .get('ses/cmon/searchOrgPersonTree.sm' //, queryParameters: params
        );
        organizationModel = OrganizationModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      Get.log('reqTest - tree map error');
      //commonError(e);
    } catch (err) {
      Get.log('reqOrganization = ${err.toString()}');
    }
    return organizationModel;
  }

  /// 안전신문고 제보하기.
  Future<bool> reqReport({required var formData}) async {
    try {
      Dio _dio = await HttpUtil.getDio();
      _dio.options.headers['Content-Type'] = 'multipart/form-data';

      final response =
      await _dio.post('sps/api/proposal/register.sp', data: formData);

      if (response.data['rtnCd'] == "00") {
        _dio.options.headers['Content-Type'] = 'application/json;charset=UTF-8';
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '신고하기 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - report error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 신고 내역 불러오기.
  Future<List<dynamic>> reqReportList(params) async {
    List<dynamic> reportList = [];
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/getList.sp', data: params);


      if (response.data['rtnCd'] == "00") {
        for (int i = 0;
        i < response.data['rtnData']['resultList'].length;
        i++) {
          if (params['stepCd'] == '10') {
            if (response.data['rtnData']['resultList'][i]['statusCd'] ==
                '0200') {
              reportList.add(response.data['rtnData']['resultList'][i]);
            }
          } else if (params['stepCd'] == '20') {
            if (response.data['rtnData']['resultList'][i]['statusCd'] ==
                '0300') {
              reportList.add(response.data['rtnData']['resultList'][i]);
            }
          } else if (params['stepCd'] == '30') {
            if (response.data['rtnData']['resultList'][i]
            ['statusCd'] ==
                '0400' ||
                response.data['rtnData']['resultList'][i]['statusCd'] ==
                    '0500' ||
                response.data['rtnData']['resultList'][i]['statusCd'] ==
                    '0600') {
              reportList.add(response.data['rtnData']['resultList'][i]);
            }
          } else {
            if (response.data['rtnData']['resultList'][i]['statusCd'] ==
                '0700') {
              reportList.add(response.data['rtnData']['resultList'][i]);
            }
          }
        }

        return reportList;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '신고하기 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - reportlist error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return reportList;
  }

  /// 신고 상세목록 가져오기.
  Future<dynamic> reqReportDetail(params) async {
    dynamic reportData = null;
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/getDetail.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        reportData = response.data['rtnData']['detail'];

        return reportData;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '신고하기 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - detail error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return reportData;
  }

  /// 신고 진행 통계 가져오기.
  Future<dynamic> reqMyBoard(params) async {
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/getStepStatus.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        Map map = Map<String, dynamic>.from(response.data['rtnData']);
        Get.log(map.toString());
        return map;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '신고하기 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - step error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return;
  }

  /// 조치 부서 배정.
  Future<bool> reqAssignTeam(params) async {
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/updateActionOrg.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '담당팀 배정 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - action team error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 조치 인원 배정.
  Future<bool> reqAssignPeople(params) async {
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/updateActionUser.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '담당팀 배정 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - action people error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 안전신문고 조치 등록/수정 하기.
  Future<bool> reqAction({required var formData}) async {
    try {
      Dio _dio = await HttpUtil.getDio();
      _dio.options.headers['Content-Type'] = 'multipart/form-data';

      final response = await _dio.post('sps/api/proposal/updateActionDetail.sp',
          data: formData);

      if (response.data['rtnCd'] == "00") {
        _dio.options.headers['Content-Type'] = 'application/json;charset=UTF-8';
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '신고하기 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - action error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 조치 부서 팀장 승인 - 0600으로 이동
  Future<bool> teamLeaderAssign(params) async {
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/updateActionOrgApproved.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '담당팀 배정 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - teamleader assign error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 안전직원 승인 - 0700으로 이동
  Future<bool> safetyEmpAssign(params) async {
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/updateToComplete.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '담당팀 배정 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - safety emp error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 안전직원 신고 미승인
  Future<bool> notAssign(params) async {
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/refuse.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '미승인 처리 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - safety emp error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 작성자 신고 철회
  Future<bool> reportDrop(params) async {
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/withdraw.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '신고 철회 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - safety emp error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  Future<VersionModel> reqMobileVersion() async {
    var versionModel = VersionModel();

    try {
      final response = await HttpUtil.getDio().post(
        'api/public/v1/getAppInfo.sp',
      );

      if (response.data['rtnCd'] == "00") {
        versionModel = VersionModel.fromJson(response.data);

        return versionModel;
      } else {
        Utils.gErrorMessage('${response.data['rtnMsg']}', title: '버전 로드 실패');
      }
    } on DioError catch (e) {
      Get.log('reqVersion - version load error');
      //commonError(e);
    } catch (err) {
      Get.log('reqVersion = ${err.toString()}');
    }

    return versionModel;
  }

   */
}
