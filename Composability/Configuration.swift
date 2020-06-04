//
//  TypeSafeConfiguration.swift
//  Composability
//
//  Created by Riccardo Cipolleschi on 22/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation

public struct StateConfiguration {
  public var stateFactory: () -> SliceState


  public init(
    stateFactory: @escaping () -> SliceState
  ) {
    self.stateFactory = stateFactory
  }

}

public protocol Dependency {
  static var name: String { get }
}

public enum DependencyConfiguration {
  case system(@autoclosure () -> Dependency)
  case external(ExternalDependency.Type)
}

public struct Configuration {
  public var stateConfigurations: [StateConfiguration]
  public var dependenciesConfigurations: [DependencyConfiguration]
  public var onStartDispatchables: [OnStartDispatchable.Type]
  public var dispatchableSubscribers: [String: [DispatchableSubscriber.Type]]


  public init(
    stateConfigurations: [StateConfiguration],
    dependenciesConfigurations: [DependencyConfiguration],
    onStartDispatchables: [OnStartDispatchable.Type] = [],
    dispatchableSubscribers: [String: [DispatchableSubscriber.Type]] = [:]
  ) {
    self.stateConfigurations = stateConfigurations
    self.dependenciesConfigurations = dependenciesConfigurations
    self.onStartDispatchables = onStartDispatchables
    self.dispatchableSubscribers = dispatchableSubscribers
  }
}
