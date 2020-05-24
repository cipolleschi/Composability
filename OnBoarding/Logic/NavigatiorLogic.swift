//
//  NavigatiorLogic.swift
//  OnBoarding
//
//  Created by Riccardo Cipolleschi on 24/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import Navigator
import UIKit
import Composability

public class OnboardingNavigator: EntryPointBuilder {
  public static var name: String { return "\(Self.self)" }

  required public init() {

  }

  public func start(dependencies: DependenciesContainer) {

  }

  public func createEntryPoint(store: Store) -> UIViewController {
    return OnboardingNC(store: store)
  }
}

public extension DependenciesContainer {
  var onboardingNavigator: OnboardingNavigator {
    return self[dynamicMember: OnboardingNavigator.name] as! OnboardingNavigator
  }
}
