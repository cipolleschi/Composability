//
//  DynamicDependencies.swift
//  Composability
//
//  Created by Riccardo Cipolleschi on 20/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation

public protocol ExternalDependency: AnyObject, Dependency {
  init()
  func start(dependencies: DependenciesContainer)
}

@dynamicMemberLookup
public class DependenciesContainer {
  /// this is used only to initialize the dependencies in the right order
  /// and to compute the dictDependencies, used after the initialization
  var dependencies: [Dependency] = []

  lazy var dictDependencies: [String: Dependency] = {
    let sequence = self.dependencies.map { return ($0.name, $0)}
    return [String: Dependency].init(uniqueKeysWithValues: sequence)
  }()

  init(){

  }

  public subscript(dynamicMember member: String) -> Dependency? {
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
        let bundle = Bundle.allFrameworks.first(where: { $0.bundlePath.contains(depConfiguration.frameworkName) }),
        let dependencyType = bundle.classNamed(fullClassName) as? NSObject.Type,
        let dependency = dependencyType.init() as? ExternalDependency
      else {
        return
      }
      self.dependencies.append(dependency)
    }

    DispatchQueue.global().async {
      self.dependencies.forEach { ($0 as? ExternalDependency)?.start(dependencies: self) }
    }

  }

  internal convenience init(configurations: [TypeSafeDependencyConfiguration]) {
    self.init()
    configurations.forEach { dependency in
      switch dependency {
      case .system(let system):
        self.dependencies.append(system())
      case .external(let external):
        self.dependencies.append(external.init())
      }
    }

    DispatchQueue.global().async {
      self.dependencies.forEach { ($0 as? ExternalDependency)?.start(dependencies: self) }
    }
  }
}
