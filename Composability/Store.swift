//
//  Store.swift
//  Composability
//
//  Created by Riccardo Cipolleschi on 20/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation

public class Store {
  var state: DynamicState
  var dependencies: DependenciesContainer

  public init(configuration: Configuration) {
    self.state = DynamicState(configuration: configuration)
    self.dependencies = DependenciesContainer(configuration: configuration)
  }

  public init(configuration: TypeSafeConfiguration) {
    self.state = DynamicState(configurations: configuration.stateConfigurations)
    self.dependencies = DependenciesContainer(configurations: configuration.dependenciesConfigurations)
  }

  var context: Context {
    return Context(getState: { self.state }, dependencies: self.dependencies, dispatch: self.dispatch(_:))
  }

  public func dispatch(_ dispatchable: Dispatchable) throws -> Any? {
    if let se = dispatchable as? SideEffect {
      let context = self.context
      return try? se.sideEffect(context: context)
    } else if let su = dispatchable as? StateUpdater {
      self.state = su.updateState(state: self.state)
      return ()
    }
    
    return ()
  }
}

public struct Context {
  public let getState: () -> DynamicState
  public let dependencies: DependenciesContainer
  public let dispatch: (Dispatchable) throws -> Any
}

public protocol Dispatchable {}

public protocol StateUpdater: Dispatchable {
  func updateState(state: DynamicState) -> DynamicState
}

public protocol SideEffect: Dispatchable {
  func sideEffect(context: Context) throws -> Any
}
