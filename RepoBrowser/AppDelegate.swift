//
//  AppDelegate.swift
//  RepoBrowser
//
//  Created by malakoipechyva on 7/16/20.
//  Copyright © 2020 malakoipechyva. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    let rootViewController = window!.rootViewController as! UINavigationController
    let repoListViewController = rootViewController.topViewController as! RepoBrowserViewController
    repoListViewController.reposStore = ReposStore()
    return true
  }


}

