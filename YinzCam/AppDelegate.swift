//
//  AppDelegate.swift
//  YinzCam
//
//  Created by Saumya Lahera on 8/31/21.
//
/*
Important:
1. Descriptions of UITableView cells
    1. ScheduleOGFinalTableViewCell - It is the cell with autolayout constraints mentioned in the experiment document.
    2. ScheduleFinalTableViewCell - It is the cell with autolayout constraints for smaller iphones.
    3. ScheduleOGRegularTableViewCell - It is the cell with autolayout constraints mentioned in the experiment document.
    4. ScheduleRegularTableViewCell - It is the cell with autolayout constraints for smaller iphones.
    
2. Project Documentation
    1. I have used basic markup for documentation
    
3. I have used Alamofire for
    1. Fetching JSON
    2. Getting images which will also handle local caching
    
   */
    
    


import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

