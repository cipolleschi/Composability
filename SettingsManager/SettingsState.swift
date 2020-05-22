//
//  SettingsState.swift
//  SettingsManager
//
//  Created by Riccardo Cipolleschi on 22/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import Composability

public struct SettingsState<T: Codable>: SliceState {
  public var sliceName: String = "SettingsState"

  var settings: T?
  public init() {
    self.settings = nil
  }
}

extension DynamicState {
  func settingsState<T>() -> SettingsState<T> {
      return self[dynamicMember: "SettingsState"] as! SettingsState<T>
  }
}
