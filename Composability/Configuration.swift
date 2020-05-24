//
//  Configuration.swift
//  Composability
//
//  Created by Riccardo Cipolleschi on 20/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation

/// How to configure the State
public struct Configuration {
  public var states: [StateConfiguration]
  public var dependencies: [DependenciesConfiguration]
  public var onStartDispatchables: [OnStartDispatchable.Type]
  public var dispatchableSubscribers: [String: [DispatchableSubscriber.Type]]

  public init(
    states: [StateConfiguration],
    dependencies: [DependenciesConfiguration],
    onStartDispatchables: [OnStartDispatchable.Type] = [],
    dispatchableSubscribers: [String: [DispatchableSubscriber.Type]] = [:]
  ) {
    self.states = states
    self.dependencies = dependencies
    self.onStartDispatchables = onStartDispatchables
    self.dispatchableSubscribers = dispatchableSubscribers
  }
}

public struct StateConfiguration {
  public var frameworkName: String
  public var stateProviderName: String

  public init(frameworkName: String, stateProviderName: String) {
    self.frameworkName = frameworkName
    self.stateProviderName = stateProviderName
  }

}

public struct DependenciesConfiguration {
  public var frameworkName: String
  public var dependencyName: String

  public init(frameworkName: String, dependencyName: String) {
    self.frameworkName = frameworkName
    self.dependencyName = dependencyName
  }
}


/// Protocol that must be implemented by the other modules to configure the state
public protocol StateProvider: AnyObject {
  var getState: () -> SliceState { get }
}
