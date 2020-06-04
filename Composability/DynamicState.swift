//
//  DynamicState.swift
//  Composability
//
//  Created by Riccardo Cipolleschi on 20/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation

/// State default protocol
public protocol State {
  init()
}

/// State protocol that must be implemented by the other modules
public protocol SliceState: State {
  static var sliceName: String { get }
}

/// New state structure that will hold all the slices
@dynamicMemberLookup
public struct DynamicState: State {
  var states: [String: SliceState] = [:]

  public init() {}

  public subscript(dynamicMember member: String) -> SliceState? {
    get {
      return self.states[member]
    }
    set {
      self.states[member] = newValue
    }
  }
}

/// Initializer that creates the state from a configuration
extension DynamicState {
  internal init(configurations: [StateConfiguration]){
    self.init()
    configurations.forEach {
        let sliceState = $0.stateFactory()
      self.states[type(of: sliceState).sliceName] = sliceState
    }
  }
}
