//
//  AppDelegate.swift
//  ToutiaoSwift
//
//  Created by 宫宜栋 on 2017/10/13.
//  Copyright © 2017年 宫宜栋. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = TSMainViewController()
        window?.makeKeyAndVisible()
        
        loadAppInfo()
        setupNotification()
        setupAdditions()
        
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

extension AppDelegate {
    
    fileprivate func loadAppInfo() {
        DispatchQueue.global().async {
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil)
            let data = NSData(contentsOf: url!)
            let jsonPath = String.ts_appendDocumentDirectory(fileName: "main.json")
            data?.write(toFile: jsonPath!, atomically: true)
        }
    }
    
}

extension AppDelegate {
    
    fileprivate func setupNotification() {
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound, .carPlay]) {
                (success, error) in
                print("授权 \(success ? "成功" : "失败")")
            }
        } else {
            // iOS 10.0以下版本
            let notificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        }
        
    }
    
}

extension AppDelegate {
    
    fileprivate func setupAdditions() {
        // 设置 SVProgressHUD 最小解除时间
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        
        // 设置网络加载指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
    }
    
}









