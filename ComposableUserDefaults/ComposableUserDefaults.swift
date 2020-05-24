//
//  ComposableUserDefaults.swift
//  ComposableUserDefaults
//
//  Created by Riccardo Cipolleschi on 22/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import Composability

extension UserDefaults: Dependency {
  public static var name: String {
    return "\(Self.self)"
  }
}

public extension DependenciesContainer {
  var userDefaults: UserDefaults {
    return self[dynamicMember: UserDefaults.name] as! UserDefaults
  }
}
