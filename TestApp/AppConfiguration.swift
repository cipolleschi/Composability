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

enum AppConfigurations {
  static var configuration: TypeSafeConfiguration {
    return TypeSafeConfiguration(
      stateConfigurations: [
        TypeSafeStateConfiguration(stateFactory: { return SettingsManager.SettingsState<Settings>() })
      ],
      dependenciesConfigurations: [
        .system(UserDefaults.standard)
      ],
      onStartDispatchables: [
        SettingsManager.SettingsLogic.DownloadSettings<Settings>.self
      ]
    )
  }
}
