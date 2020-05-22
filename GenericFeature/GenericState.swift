//
//  GenericState.swift
//  GenericFeature
//
//  Created by Riccardo Cipolleschi on 21/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import Composability

public struct GenericState<T>: SliceState {
  public let sliceName: String = "GenericState"
  public var wrapped: T?
  public init() { }
}

extension DynamicState {
  public func genericState<T>() -> GenericState<T> {
    return self[dynamicMember: "GenericState"] as! GenericState<T>
  }
}
