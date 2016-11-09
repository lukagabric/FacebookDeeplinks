//
//  AppDelegate.swift
//  FBDeferredDeeplinkTest
//

import UIKit
import FBSDKCoreKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        self.navigateToURL(url)
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
        
        FBSDKAppLinkUtility.fetchDeferredAppLink { [weak self] url, error in
            guard let `self` = self else { return }
            
            if let error = error {
                print("Error occured: \(error)")
            }
            else if let url = url {
                self.navigateToURL(url)
                print("Fetched app link: \(url)")
            }
            else {
                print("No app link available")
            }
        }
    }
    
    func navigateToURL(_ url: URL) {
        //performa navigation
    }
    
}
