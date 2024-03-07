
import 'package:egu_industry/app/pages/alarm/alarm_binding.dart';
import 'package:egu_industry/app/pages/alarm/alarm_page.dart';
import 'package:egu_industry/app/pages/facilitySecond/facility_binding.dart';
import 'package:egu_industry/app/pages/facilitySecond/facility_page.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_binding.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_step1_page.dart';
import 'package:egu_industry/app/pages/facilityMonitoring/facility_monitoring_binding.dart';
import 'package:egu_industry/app/pages/facilityMonitoring/facility_monitoring_page.dart';
import 'package:egu_industry/app/pages/gagongFacility/gagong_facility_binding.dart';
import 'package:egu_industry/app/pages/gagongFacility/gagong_facility_page.dart';
import 'package:egu_industry/app/pages/gongjungCheck/gongjung_check_binding.dart';
import 'package:egu_industry/app/pages/gongjungCheck/gongjung_check_page.dart';
import 'package:egu_industry/app/pages/inventoryCounting/inventory_counting_binding.dart';
import 'package:egu_industry/app/pages/inventoryCounting/inventory_counting_page.dart';
import 'package:egu_industry/app/pages/loginPage/login_binding.dart';
import 'package:egu_industry/app/pages/loginPage/login_page.dart';
import 'package:egu_industry/app/pages/main/main_binding.dart';
import 'package:egu_industry/app/pages/main/main_page.dart';
import 'package:egu_industry/app/pages/inventoryCheck/inventory_check_binding.dart';
import 'package:egu_industry/app/pages/inventoryCheck/inventory_check_page.dart';
import 'package:egu_industry/app/pages/noticePage/notice_binding.dart';
import 'package:egu_industry/app/pages/noticePage/notice_page.dart';
import 'package:egu_industry/app/pages/packagingInspec/packaging_inspec_binding.dart';
import 'package:egu_industry/app/pages/packagingInspec/packaging_inspec_page.dart';
import 'package:egu_industry/app/pages/processCheck/process_check_binding.dart';
import 'package:egu_industry/app/pages/processCheck/process_check_page.dart';
import 'package:egu_industry/app/pages/processTransfer/process_transfer_binding.dart';
import 'package:egu_industry/app/pages/processTransfer/process_transfer_page.dart';
import 'package:egu_industry/app/pages/productLocation/product_location_binding.dart';
import 'package:egu_industry/app/pages/productLocation/product_location_page.dart';
import 'package:egu_industry/app/pages/scrapLabel/scrap_label_binding.dart';
import 'package:egu_industry/app/pages/scrapLabel/scrap_label_page.dart';
import 'package:egu_industry/app/print/bluetooth_printer.dart';

import 'package:get/get.dart';

import '../pages/splash/splash_binding.dart';
import '../pages/splash/splash_page.dart';

abstract class Routes {
  static const PERMISSION = _PathName.PERMISSION;
  static const MAIN = _PathName.MAIN;
  static const SPLASH = _PathName.SPLASH;
  static const FACILITY = _PathName.FACILITY;
  static const FACILITY_FIRST = _PathName.FACILITY_FIRST;
  static const PRODUCT_LOCATION = _PathName.PRODUCT_LOCATION;
  static const INVENTORY_COUNTING = _PathName.INVENTORY_COUNTING;
  static const PROCESS_TRANSFER = _PathName.PROCESS_TRANSFER;
  static const INVENTORY_CHECK= _PathName.INVENTORY_CHECK;
  static const PROCESS_CHECK= _PathName.PROCESS_CHECK;
  static const FACILITY_MONITORING= _PathName.FACILITY_MONITORING;
  static const PACKAGING_INSPEC= _PathName.PACKAGING_INSPEC;
  static const SCRAP_LABEL= _PathName.SCRAP_LABEL;
  static const LOGIN_PAGE= _PathName.LOGIN_PAGE;
  static const ALARM= _PathName.ALARM;
  static const BLUETOOTH_PRINTER = _PathName.BLUETOOTH_PRINTER;
  static const NOTICE = _PathName.NOTICE;
  static const GONGJUNG_CHHECK = _PathName.GONGJUNG_CHHECK;
  static const GAGONG_FACILITY = _PathName.GAGONG_FACILITY;
}

abstract class _PathName {
  static const String PERMISSION = '/permission'; // 권한 요청 페이지
  static const String MAIN = '/main'; // MAIN 페이지
  static const String SPLASH = '/splash'; // SPLASH 페이지
  static const String LOGIN_PAGE = '/login'; // 로그인 페이지
  static const String FACILITY = '/facility'; // FACILITY 페이지
  static const String FACILITY_FIRST = '/facility_first'; // FACILITY 페이지
  static const String PRODUCT_LOCATION = '/product_location'; // 제품이동 페이지
  static const String INVENTORY_COUNTING = '/inventoty_counting'; // 재고실사 페이지
  static const String PROCESS_TRANSFER = '/process_transfer'; // 공정이동 페이지
  static const String INVENTORY_CHECK = '/inventory_check'; // 제품재고 조회 페이지
  static const String PROCESS_CHECK = '/process_check'; // 작업조회 페이지
  static const String FACILITY_MONITORING = '/facility_monitoring'; // 설비가동 모니터링 페이지
  static const String PACKAGING_INSPEC = '/packaging_inspec'; // 제품포장 검수 페이지
  static const String SCRAP_LABEL = '/scrap_label'; // 스크랩 라벨발행 페이지
  static const String ALARM = '/alarm'; // 알림 페이지
  static const String BLUETOOTH_PRINTER = '/bluetooth_printer'; // 프린트
  static const String NOTICE = '/notice'; // 프린트
  static const String GONGJUNG_CHHECK = '/gongjung_check'; // 공정조회 페이지
  static const String GAGONG_FACILITY = '/gagong_facility'; // 가공설 페이지
}

class AppRoute {
  static final routes = [
    GetPage(
        name: _PathName.SPLASH,
        page: () => SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: _PathName.MAIN, page: () => MainPage(), binding: MainBinding()),
    GetPage(
        name: _PathName.FACILITY, page: () => FacilityPage(), binding: FacilityBinding()),
    GetPage(
        name: _PathName.FACILITY_FIRST, page: () => FacilityFirstStep1Page(), binding: FacilityFirstBinding()),
    GetPage(
        name: _PathName.PRODUCT_LOCATION, page: () => ProductLocationPage(), binding: ProductLocationBinding()),
    GetPage(
        name: _PathName.INVENTORY_COUNTING, page: () => InventoryCountingPage(), binding: InventoryCountingBinding()),
    GetPage(
        name: _PathName.PROCESS_TRANSFER, page: () => ProcessTransferPage(), binding: ProcessTransferBinding()),
    GetPage(
        name: _PathName.INVENTORY_CHECK, page: () => InventoryCheckPage(), binding: InventoryCheckBinding()),
    GetPage(
        name: _PathName.PROCESS_CHECK, page: () => ProcessCheckPage(), binding: ProcessCheckBinding()),
    GetPage(
        name: _PathName.FACILITY_MONITORING, page: () => FacilityMonitoringPage(), binding: FacilityMonitoringBinding()),
    GetPage(
        name: _PathName.PACKAGING_INSPEC, page: () => PackagingInspecPage(), binding: PackagingInspecBinding()),
    GetPage(
        name: _PathName.SCRAP_LABEL, page: () => ScrapLabelPage(), binding: ScrapLabelBinding()),
    GetPage(
        name: _PathName.LOGIN_PAGE, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
        name: _PathName.ALARM, page: () => AlarmPage(), binding: AlarmBinding()),
   /* GetPage(
        name: _PathName.BLUETOOTH_PRINTER, page: () => BluetoothPrinter(), binding: ScrapLabelBinding()),*/
    GetPage(
        name: _PathName.NOTICE, page: () => NoticePage(), binding: NoticeBinding()),
    GetPage(
        name: _PathName.GONGJUNG_CHHECK, page: () => GongjungCheckPage(), binding:  GongjungCheckBinding()),
    GetPage(
        name: _PathName.GAGONG_FACILITY, page: () => GagongFacilityPage(), binding:  GagongFacilityBinding()),

  ];
}

