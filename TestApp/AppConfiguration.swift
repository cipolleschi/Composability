//
//  AppConfiguration.swift
//  TestApp
//
//  Created by Riccardo Cipolleschi on 22/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import Composability
import ComposableUserDefaults
import SettingsManager
import OnBoarding
import UIKit
import Tabbar

enum AppConfigurations {
  static var configuration: TypeSafeConfiguration {
    return TypeSafeConfiguration(
      stateConfigurations: [
        TypeSafeStateConfiguration(stateFactory: { return SettingsManager.SettingsState<Settings>() }),
        TypeSafeStateConfiguration(stateFactory: { return OnBoarding.OnBoardingState() })
      ],
      dependenciesConfigurations: [
        .system( { return UIWindow() }()),
        .system(UserDefaults.standard),
        .external(OnboardingNavigator.self),
        .external(Navigator.self),
        .external(TabbarEntryPoint.self)
      ],
      onStartDispatchables: [
        SettingsManager.SettingsLogic.DownloadSettings<Settings>.self
      ],
      dispatchableSubscribers: [
        String(reflecting: OnboardingEnd.self) : [HandleEndFlow.self]
      ]
    )
  }
}

extension UIWindow: Dependency {
  public static var name: String {
    return "\(Self.self)"
  }
}

public extension DependenciesContainer {
  var window: UIWindow {
    return self[dynamicMember: UIWindow.name] as! UIWindow
  }
}
