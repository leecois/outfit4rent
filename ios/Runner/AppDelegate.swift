import Flutter
import UIKit
import FBSDKCoreKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
    _ app: UIApplication, 
    open url: URL, 
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    return ApplicationDelegate.shared.application(app, open: url, options: options) || 
           super.application(app, open: url, options: options)
  }

  override func application(
    _ application: UIApplication, 
    open url: URL, 
    sourceApplication: String?, 
    annotation: Any
  ) -> Bool {
    return ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation) || 
           super.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
  }
}
