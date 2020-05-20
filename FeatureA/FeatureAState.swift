//
//  FeatureAState.swift
//  FeatureA
//
//  Created by Riccardo Cipolleschi on 20/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import Composability

public struct FeatureAState: SliceState {
  public let sliceName = "FeatureA"

  var userName: String? = nil

  public init() {

  }
}

/// Helper to retrieve the typed slice of state for this module
public extension DynamicState {

  var featureAState: FeatureAState {
    get {
      /// We can fail with a fatalError in case of misconfiguration.
      /// Notice that in the old world, we still would have casted the state to the
      /// `StateWithXXX` protocol.
      return self[dynamicMember: "FeatureA"] as! FeatureAState
    }
    set {
      self[dynamicMember: "FeatureA"] = newValue
    }
  }
}

/// PRovider that initializes the state
public class FeatureAStateProvider: NSObject, StateProvider {
  public var getState: () -> SliceState = {
    return FeatureAState()
  }
}

public struct UpdateUserName: StateUpdater {
  var username: String

  public init(username: String) {
    self.username = username
  }

  public func updateState(state: DynamicState) -> DynamicState {
    var newState = state
    newState.featureAState.userName = username
    return newState
  }
}
