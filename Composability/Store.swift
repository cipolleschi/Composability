//
//  Store.swift
//  Composability
//
//  Created by Riccardo Cipolleschi on 20/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation

public class Store: Dependency {
  public static var name: String { return "\(Self.self)"}

  public internal(set) var state: DynamicState
  var dependencies: DependenciesContainer
  var subscribers: [StateSubscriber] = []
  var dispatchableSubscribers: [String: [DispatchableSubscriber.Type]]

  public init(configuration: Configuration) {
    self.state = DynamicState(configurations: configuration.stateConfigurations)
    self.dependencies = DependenciesContainer(configurations: configuration.dependenciesConfigurations)
    self.dispatchableSubscribers = configuration.dispatchableSubscribers

    // set the store as Dependency (for simplicity sake)
    self.dependencies.dependencies.insert(self, at: 0)
    self.dependencies.start()
    
    // app started, run onStart Dispatchables
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
    var returned: Any?
    if let se = dispatchable as? SideEffect {
      let context = self.context
      returned = try? se.sideEffect(context: context)
    } else if let su = dispatchable as? StateUpdater {
      let oldState = self.state
      self.state = su.updateState(state: self.state)
      self.subscribers.forEach { $0.stateDidUpdate(oldState: oldState, newState: self.state)}
      returned = ()
    }

    if let toDispatch = self.dispatchableSubscribers[String(reflecting: type(of: dispatchable))] {
      toDispatch.forEach {
        guard let d = $0.init(dispatchable: dispatchable) else {
          return
        }
        _ = try? self.dispatch(d)
      }
    }
    
    return returned
  }
}

public extension DependenciesContainer {
  var store: Store {
    return self[dynamicMember: Store.name] as! Store
  }
}

// MARK: Subscribers

public protocol OnStartDispatchable: Dispatchable {
  init()
}

public protocol StateSubscriber {
  func stateDidUpdate(oldState: DynamicState, newState: DynamicState)
}

public protocol DispatchableSubscriber: Dispatchable {
  init?(dispatchable: Dispatchable)
}
