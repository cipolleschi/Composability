//
//  SettingsLogic.swift
//  SettingsManager
//
//  Created by Riccardo Cipolleschi on 22/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import Composability

public enum SettingsLogic {
  public struct DownloadSettings<T: Codable>: SideEffect, OnStartDispatchable {
    public init() {}

    public func sideEffect(context: Context) throws -> Any {
      DispatchQueue.global().asyncAfter(deadline: .now() + 1) {

        let settings = try! JSONDecoder().decode(T.self, from: settingTestData)
        _ = try! context.dispatch(UpdateSettings(newSettings: settings))
      }
      return ()
    }
  }

  struct UpdateSettings<T: Codable>: StateUpdater {
    var newSettings: T
    func updateState(state: DynamicState) -> DynamicState {
      var newState = state
      var settingsState: SettingsState<T> = state.settingsState()
      settingsState.settings = newSettings
      newState[dynamicMember: settingsState.sliceName] = settingsState
      return state
    }
  }
}

var settingTestData: Data {
  return try! JSONSerialization.data(withJSONObject: ["test_string": "test_value", "test_number": 10], options: [])
}
