//
//  OnboardinDispatchables.swift
//  OnBoarding
//
//  Created by Riccardo Cipolleschi on 24/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import Composability
import Navigator

public struct OnboardingEnd: SideEffect, EndModuleFlow {
  public var moduleName: String { return OnboardingNavigator.name }

  public var data: [String : Any]

  public func sideEffect(context: Context) throws -> Any {
    return ()
  }

  

}
