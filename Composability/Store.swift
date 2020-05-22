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
  var subscribers: [StateSubscriber] = []

  public init(configuration: Configuration) {
    self.state = DynamicState(configuration: configuration)
    self.dependencies = DependenciesContainer(configuration: configuration)
    self.runOnStartDispatchables(dispatchables: configuration.onStartDispatchables)
  }

  public init(configuration: TypeSafeConfiguration) {
    self.state = DynamicState(configurations: configuration.stateConfigurations)
    self.dependencies = DependenciesContainer(configurations: configuration.dependenciesConfigurations)
    self.runOnStartDispatchables(dispatchables: configuration.onStartDispatchables)
  }

  func runOnStartDispatchables(dispatchables: [OnStartDispatchable.Type]) {
    dispatchables.forEach {
      _ = try? self.dispatch($0.init())
    }
  }

  public func addSubscriber(subs: StateSubscriber) {
    self.subscribers.append(subs)
  }


  var context: Context {
    return Context(getState: { self.state }, dependencies: self.dependencies, dispatch: self.dispatch(_:))
  }

  public func dispatch(_ dispatchable: Dispatchable) throws -> Any? {
    if let se = dispatchable as? SideEffect {
      let context = self.context
      return try? se.sideEffect(context: context)
    } else if let su = dispatchable as? StateUpdater {
      let oldState = self.state
      self.state = su.updateState(state: self.state)
      self.subscribers.forEach { $0.stateDidUpdate(oldState: oldState, newState: self.state)}
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

public protocol OnStartDispatchable: Dispatchable {
  init()
}

public protocol StateSubscriber {
  func stateDidUpdate(oldState: DynamicState, newState: DynamicState)
}
