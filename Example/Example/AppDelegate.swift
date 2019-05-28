//
//  AppDelegate.swift
//  Example
//
//  Created by Scott Moon on 28/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow()
    window?.rootViewController = ViewController()
    window?.makeKeyAndVisible()

    return true
  }

}
