//
//  DynamicDependencies.swift
//  Composability
//
//  Created by Riccardo Cipolleschi on 20/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation

public protocol ExternalDependency: AnyObject {
  var name: String { get }
  func start(dependencies: DependenciesContainer)
}

@dynamicMemberLookup
public class DependenciesContainer {
  /// this is used only to initialize the dependencies in the right order
  /// and to compute the dictDependencies, used after the initialization
  var dependencies: [ExternalDependency] = []

  lazy var dictDependencies: [String: ExternalDependency] = {
    let sequence = self.dependencies.map { return ($0.name, $0)}
    return [String: ExternalDependency].init(uniqueKeysWithValues: sequence)
  }()

  init(){

  }

  public subscript(dynamicMember member: String) -> ExternalDependency? {
    return self.dictDependencies[member]
  }
}

/// Initializer that creates the state from a configuration
extension DependenciesContainer {
  internal convenience init(configuration: Configuration) {
    self.init()
    configuration.dependencies.forEach { depConfiguration in
      let fullClassName = "\(depConfiguration.frameworkName).\(depConfiguration.dependencyName)"
      guard
        let bundle = Bundle.allFrameworks.first { $0.bundlePath.contains(depConfiguration.frameworkName) },
        let dependencyType = bundle.classNamed(fullClassName) as? NSObject.Type,
        let dependency = dependencyType.init() as? ExternalDependency
      else {
        return
      }
      self.dependencies.append(dependency)
    }

    DispatchQueue.global().async {
      self.dependencies.forEach { $0.start(dependencies: self) }
    }

  }
}
