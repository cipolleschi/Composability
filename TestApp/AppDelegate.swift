//
//  AppDelegate.swift
//  TestApp
//
//  Created by Riccardo Cipolleschi on 22/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import UIKit
import Composability
import OnBoarding

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var store: Store!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    self.store = Store(configuration: AppConfigurations.configuration)

    return true
  }


}

