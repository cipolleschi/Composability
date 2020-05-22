//
//  AppConfigurations.swift
//  AppExample
//
//  Created by Riccardo Cipolleschi on 22/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import Composability
import FeatureA
import GenericFeature
import ComposableUserDefaults

enum AppConfigurations {
  static var fileConfiguration: Configuration {
    let configuration = Configuration(
    states: [
      StateConfiguration(frameworkName: "FeatureA", stateProviderName: "FeatureAStateProvider")
    ],
    dependencies: [
      DependenciesConfiguration(frameworkName: "FeatureA", dependencyName: "FeatureAManager")
    ])
    return configuration
  }

  static var typeSafeConfiguration: TypeSafeConfiguration {
    return TypeSafeConfiguration(
      stateConfigurations: [
        TypeSafeStateConfiguration(stateFactory: { FeatureAState() }),
        TypeSafeStateConfiguration(stateFactory: { GenericState<Settings>() })
    ],
      dependenciesConfigurations: [
        TypeSafeDependencyConfiguration.system(UserDefaults.standard),
        TypeSafeDependencyConfiguration.external(FeatureAManager.self)
    ])
  }
}
