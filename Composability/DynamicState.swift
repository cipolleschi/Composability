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
  var sliceName: String { get }
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
  internal init(configuration: Configuration) {
    self.init()
    configuration.states.forEach { stateConfiguration in
      let fullClassName = "\(stateConfiguration.frameworkName).\(stateConfiguration.stateProviderName)"
      guard
        let bundle = Bundle.allFrameworks.first { $0.bundlePath.contains(stateConfiguration.frameworkName) },
        let stateProviderType = bundle.classNamed(fullClassName) as? NSObject.Type,
        let stateProvider = stateProviderType.init() as? StateProvider
      else {
        return
      }

      let featureState = stateProvider.getState()
      self.states[featureState.sliceName] = featureState
    }
  }
}
