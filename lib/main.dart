
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:egu_industry/app/common/global_service.dart';
import 'package:egu_industry/app/pages/home/home_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'app/common/color_schemes.g.dart';
import 'app/common/init_binding.dart';
import 'app/common/local_notification.dart';
import 'app/common/logger_utils.dart';
import 'app/net/http_util.dart';
import 'app/routes/app_route.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  HttpUtil.init();
  LocalNotification.initialize();
  LocalNotification.requestPermission();

  initializeDateFormatting().then((_) => runApp(MyApp()));

}

@pragma('vm:entry-point')
void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class MyApp extends StatefulWidget {
   const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return GetMaterialApp(
      color: Colors.white,
      builder: (context, child) {
        return MediaQuery(
          // 스마트폰 기기 자체 폰트 사이즈 무시하기.
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: child!);
      },
      title: "이구산업",
      debugShowCheckedModeBanner: false,
      logWriterCallback: Logger.write,
      defaultTransition: Transition.fadeIn,
      initialBinding: InitBinding(),
      getPages: AppRoute.routes,
      initialRoute: Routes.SPLASH,
      themeMode: ThemeMode.system,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          fontFamily: 'NotoSansKR'
      ),
      //locale: ui.window.locale,
    );
  }

  ReceivePort? _receivePort;

  Future<void> _requestPermissionForAndroid() async {
    if (!Platform.isAndroid) {
      return;
    }
    if (!await FlutterForegroundTask.canDrawOverlays) {
      await FlutterForegroundTask.openSystemAlertWindowSettings();
    }
    if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
      await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    }
    final NotificationPermission notificationPermissionStatus =
    await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermissionStatus != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }
  }

  void _initForegroundTask() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        id: 500,
        channelId: 'foreground_service',
        channelName: 'Foreground Service Notification',
        channelDescription:
        'This notification appears when the foreground service is running.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        isSticky: false,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
          backgroundColor: Colors.orange,
        ),
        buttons: [

        ],
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 500,
        isOnceEvent: false,
        autoRunOnBoot: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<bool> _startForegroundTask() async {
    // You can save data using the saveData function.
    await FlutterForegroundTask.saveData(key: 'customData', value: 'hello');

    // Register the receivePort before starting the service.
    final ReceivePort? receivePort = FlutterForegroundTask.receivePort;
    final bool isRegistered = _registerReceivePort(receivePort);
    if (!isRegistered) {
      print('Failed to register receivePort!');
      return false;
    }
    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        notificationTitle: 'MES 알림 서비스 실행중',
        notificationText: '클릭 시 앱으로 이동',
        callback: startCallback,
      );
    }
  }

  Future<bool> _stopForegroundTask() {
    return FlutterForegroundTask.stopService();
  }

  bool _registerReceivePort(ReceivePort? newReceivePort) {
    if (newReceivePort == null) {
      return false;
    }
    _closeReceivePort();
    _receivePort = newReceivePort;
    _receivePort?.listen((data) {
      if (data is int) {
        //print('eventCount: $data');
      } else if (data is String) {
        if (data == 'onNotificationPressed') {
          //Navigator.of(context).pushNamed('/resume-route');
        }
      } else if (data is DateTime) {
        print('timestamp: ${data.toString()}');
      }
    });
    return _receivePort != null;
  }

  void _closeReceivePort() {
    _receivePort?.close();
    _receivePort = null;
  }



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _requestPermissionForAndroid();
      _initForegroundTask();

      // You can get the previous ReceivePort without restarting the service.
      if (await FlutterForegroundTask.isRunningService) {
        final newReceivePort = FlutterForegroundTask.receivePort;
        _registerReceivePort(newReceivePort);
      }
      _startForegroundTask();
      log('aaa=> ${Utils.getStorage.read('userId')}');
    });
  }

  @override
  void dispose() {
    _closeReceivePort();
    super.dispose();
  }

}


class MyTaskHandler extends TaskHandler {
  SendPort? _sendPort;
  int _eventCount = 0;
  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {
    _sendPort = sendPort;
    final customData =
    await FlutterForegroundTask.getData<String>(key: 'customData');
    print('customData: $customData');
  }
  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    doPn();
  }
  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) async {
    print('onDestroy');
  }
  @override
  void onNotificationButtonPressed(String id) {
    print('onNotificationButtonPressed >> $id');
  }
  @override
  void onNotificationPressed() {
    FlutterForegroundTask.launchApp("/");
    _sendPort?.send('onNotificationPressed');
  }

  bool isWorkPn = false;
  Map? PN_DATA = null;
  Future<void> doPn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(isWorkPn == true) return;
    isWorkPn = true;
    try {
      String? RCV_USER = prefs.getString('userId');
      if(RCV_USER == null || RCV_USER!.isEmpty || (PN_DATA != null && PN_DATA!["RCV_USER"] != RCV_USER)){
        PN_DATA = null;
        throw Exception("User Dismiss");
      }
      if(PN_DATA == null)
        PN_DATA = {"ACT_DTM" : null, "RCV_USER" : RCV_USER};
      Map? nData = await RCV_DATA_PERIOD("PUSH_NOTIFY", PN_DATA);
      if(nData!.isNotEmpty) {
        if(nData.containsKey("TYPE") && nData["TYPE"] == "ERROR")
          const Duration(milliseconds: 1000);
        await workPn(nData);
        log(nData.toString());
      }
      PN_DATA = {
        "ACT_DTM": nData!["ACT_DTM"],
        "ID": nData!["ID"],
        "RCV_USER": RCV_USER,
      };


    }catch(ex){
      log(time:DateTime.now(), '['+DateTime.now().toString()+']LocalNotification Exception : ' + ex.toString());
      log(time:DateTime.now(), '['+DateTime.now().toString()+']LocalNotification Exception : ' + ex.toString());
      sleep(const Duration(milliseconds: 20*1000));
    }finally {
      isWorkPn = false;
    }
  }
  Future<Map?> workPn(dynamic value) async {
    Map? map = null;
    map = value as Map;
    Object ID = map.containsKey("ID") ? map["ID"] : "";
    String TYPE = map.containsKey("TYPE") ? (map["TYPE"]??"") : "";
    String SUBJECT = map.containsKey("SUBJECT") ? (map["SUBJECT"]??"") : "";
    String CONTENTS = map.containsKey("CONTENTS") ? (map["CONTENTS"]??"") : "";
    Object ACT_DTM = (map.containsKey("ACT_DTM") ? (map["ACT_DTM"]??"") : "")??"";
    Object RCV_USER = (map.containsKey("RCV_USER") ? (map["RCV_USER"]??"") : "")??"";
    Object OPTIONS = (map.containsKey("OPTIONS") ? (map["OPTIONS"]??"") : "")??"";
    switch(TYPE){
      case "PUSH_NOTIFY": {
        if(SUBJECT.isNotEmpty || CONTENTS.isNotEmpty)
          LocalNotification.notify(SUBJECT, CONTENTS);
        Platform.isIOS ?  Fluttertoast.showToast(
            msg: "${SUBJECT}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        ) : null;
      } break;
    }
    await RCV_DATA_PERIOD("PUSH_NOTIFY", { 'RCV_USER':RCV_USER, 'EXC_YN':'Y', 'ID':ID });
    sleep(const Duration(milliseconds: 1000));
    return map;
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

  Future<Map?> RCV_DATA_PERIOD(String? WorkType, Map? PARAMS) async{
    String res = await EXEC2("RCV_DATA_PERIOD", "PUSH_NOTIFY", PARAMS, timeoutSec: 20*60) ?? "";
    Map data = json.decode(res);
    return data["RESULT"] == null || data["RESULT"]["DATAS"] == null ? null : data["RESULT"]["DATAS"][0];
  }
}




