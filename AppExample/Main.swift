//
//  Main.swift
//  AppExample
//
//  Created by Riccardo Cipolleschi on 20/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import Composability
import FeatureA

class App {
  func main() {
    // The configuration should be read from a file, that's why they are strings.
    // We can think of better ways, like a type swift file where there are all the imports of the app
    let configuration = Configuration(
      states: [
        StateConfiguration(frameworkName: "FeatureA", stateProviderName: "FeatureAStateProvider")
      ],
      dependencies: [
        DependenciesConfiguration(frameworkName: "FeatureA", dependencyName: "FeatureAManager")
      ])

    let store = Store(configuration: configuration)

    try? store.dispatch(FeatureA.UpdateUserName(username: "NewName"))
    _ = try? store.dispatch(FeatureA.DoStuff())
  }
}
