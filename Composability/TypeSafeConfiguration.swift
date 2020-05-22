//
//  TypeSafeConfiguration.swift
//  Composability
//
//  Created by Riccardo Cipolleschi on 22/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation

public struct TypeSafeStateConfiguration {
  public var stateFactory: () -> SliceState


  public init(
    stateFactory: @escaping () -> SliceState
  ) {
    self.stateFactory = stateFactory
  }

}

public protocol Dependency {
  var name: String { get }
}

public enum TypeSafeDependencyConfiguration {
  case system(@autoclosure () -> Dependency)
  case external(ExternalDependency.Type)
}

public struct TypeSafeConfiguration {
  public var stateConfigurations: [TypeSafeStateConfiguration]
  public var dependenciesConfigurations: [TypeSafeDependencyConfiguration]
  public var onStartDispatchables: [OnStartDispatchable.Type]

  public init(
    stateConfigurations: [TypeSafeStateConfiguration],
    dependenciesConfigurations: [TypeSafeDependencyConfiguration],
    onStartDispatchables: [OnStartDispatchable.Type] = []
  ) {
    self.stateConfigurations = stateConfigurations
    self.dependenciesConfigurations = dependenciesConfigurations
    self.onStartDispatchables = onStartDispatchables
  }
}
