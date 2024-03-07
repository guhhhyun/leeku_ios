/*
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
 */
 import UIKit
 import Flutter

 @UIApplicationMain
 @objc class AppDelegate: FlutterAppDelegate {
   override func application(
     _ application: UIApplication,
     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
   ) -> Bool {
     GeneratedPluginRegistrant.register(with: self)

     //<!-- flutter_foreground_task 추가 -->
     SwiftFlutterForegroundTaskPlugin.setPluginRegistrantCallback(registerPlugins)
     if #available(iOS 10.0, *) {
       UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
     }

     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
   }
 }

 //<!-- flutter_foreground_task 추가 -->
 func registerPlugins(registry: FlutterPluginRegistry) {
   GeneratedPluginRegistrant.register(with: registry)
 }



