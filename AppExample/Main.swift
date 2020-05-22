//
//  Main.swift
//  AppExample
//
//  Created by Riccardo Cipolleschi on 20/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import Composability

class App {
  var store: Store!
  func main() {
    // The configuration should be read from a file, that's why they are strings.
    // We can think of better ways, like a type swift file where there are all the imports of the app

    let configuration = AppConfigurations.typeSafeConfiguration

    self.store = Store(configuration: configuration)
  }
}

struct Settings {
  var testSetting: String
}

