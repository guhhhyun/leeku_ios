import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String?> EXEC(
    String MODE,
    String CODE,
    Map? PARAMS, {
      String? url = null,
      String? service_name = null,
      String? auth = null,
      int timeoutSec = 10,
      String ContentType = 'application/json',
    }) async {
  Map<String, dynamic> data = {};
  String result = "";
  Object? exception = null;
  try {
    //if (url == null) url = '121.133.99.66:3000';
    //if (url == null) url = '10.0.2.2:3000';
    //if (url == null) url = '10.0.2.2:8090';
    if (url == null) url = 'mes1.leeku.co.kr';
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
    var response = await http.post(
        RequestUri,
        headers: {'Content-Type': ContentType},
        body: json.encode(data)
    ).timeout(Duration(seconds: timeoutSec));
    result = utf8.decode(response.bodyBytes);
    return result;
  }catch(ex){
    exception = ex;
  }finally{
    //log({'url':url,'service_name':service_name,'MODE':MODE,'CODE':CODE,'PARAMS':PARAMS}.toString());
    //log({'DATA':data, 'RESULT':result, 'EXCEPTION':exception}.toString());
  }
}

Future<Map> PROC(String procName, Map? PARAMS) async {
  String res = await EXEC("PROC", procName, PARAMS) ?? "";
  Map data = json.decode(res);
  return data["RESULT"]["DATAS"][0];
}
Future<List> PROCS(String procName, Map? PARAMS) async {
  String res = await EXEC("PROC", procName, PARAMS) ?? "";
  Map data = json.decode(res);
  return data["RESULT"]["DATAS"];
}

Future<List> BIZ_DATA(String BizComponentID) async {
  String res = await EXEC("PROC", 'P_BizComponentQuery_R', {'BizComponentID':BizComponentID}) ?? "";
  Map data = json.decode(res);
  return data["RESULT"]["DATAS"][0]["DATAS"];
}

Future<Map> RCV_DATA_PERIOD(String? WorkType, Map? PARAMS) async{
  String res = await EXEC("RCV_DATA_PERIOD", "PUSH_NOTIFY", PARAMS, timeoutSec: 20) ?? "";
  Map data = json.decode(res);
  return data["RESULT"]["DATAS"][0];
}

Future<String> IP_GET() async {
  var response = await http.get(Uri.parse('https://api.ipify.org'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    return "Failed to get IP";
  }
}
Future<Map> REPORT_PDF(String PrintType, Map? PARAMS) async {
  String res = await EXEC("REPORT_PDF", PrintType, PARAMS) ?? "";
  Map data = json.decode(res);
  Map RESULT = data["RESULT"];
  RESULT["FILE"] = base64Decode(RESULT["FILE"]);
  return RESULT;
}
