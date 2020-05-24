//
//  Dispatchable.swift
//  Composability
//
//  Created by Riccardo Cipolleschi on 24/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation


public protocol Dispatchable {}

public protocol StateUpdater: Dispatchable {
  func updateState(state: DynamicState) -> DynamicState
}

public protocol SideEffect: Dispatchable {
  func sideEffect(context: Context) throws -> Any
}

public struct Context {
  public let getState: () -> DynamicState
  public let dependencies: DependenciesContainer
  public let dispatch: (Dispatchable) throws -> Any
}
