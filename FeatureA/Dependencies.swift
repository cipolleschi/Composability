//
//  Dependencies.swift
//  FeatureA
//
//  Created by Riccardo Cipolleschi on 20/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import Composability

public class FeatureAManager: NSObject, ExternalDependency {

  public let name: String = "FeatureAManager"

  public override required init() {}

  public func start(dependencies: DependenciesContainer) {}

  func doStuff() {}
}

extension DependenciesContainer {
  var featureAManager: FeatureAManager {
    return self[dynamicMember: "FeatureAManager"] as! FeatureAManager
  }
}

public struct DoStuff: SideEffect {
  public init(){ }
  public func sideEffect(context: Context) throws -> Any {
    context.dependencies.featureAManager.doStuff()
  }
}
