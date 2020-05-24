//
//  Navigation.swift
//  TestApp
//
//  Created by Riccardo Cipolleschi on 24/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import Navigator
import UIKit
import Composability
import OnBoarding

class Navigator: NavigationManager {

  static var name: String { return  "\(Self.self)" }

  var dependencies: DependenciesContainer!

  public required init() { }

  func start(dependencies: DependenciesContainer) {
    self.dependencies = dependencies
    self.initialVC()
  }

  func initialVC() {
    let window = self.dependencies.window
    window.rootViewController = self.dependencies.onboardingNavigator.createEntryPoint(store: self.dependencies.store)
    self.dependencies.window.makeKeyAndVisible()
  }

  func nextVC(endFlow: EndModuleFlow) {
    // you can reason on the state using the GetState function
    
    if endFlow is OnboardingEnd {
      let window = self.dependencies.window
      window.rootViewController = self.dependencies.tabbarBuilder.createEntryPoint(store: self.dependencies.store)
    }
  }
}

extension DependenciesContainer {
  var navigator: NavigationManager {
    return self[dynamicMember: Navigator.name] as! Navigator
  }
}

// MARK: - Dispatchables

struct HandleEndFlow: SideEffect, DispatchableSubscriber {
  let endModuleFlow: EndModuleFlow

  init?(dispatchable: Dispatchable) {
    guard let endFlow = dispatchable as? EndModuleFlow else {
      return nil
    }
    self.endModuleFlow = endFlow
  }

  func sideEffect(context: Context) throws -> Any {
    context.dependencies.navigator.nextVC(endFlow: self.endModuleFlow)
  }
}
