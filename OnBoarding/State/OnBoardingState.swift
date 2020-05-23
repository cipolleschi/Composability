//
//  OnBoardingState.swift
//  OnBoarding
//
//  Created by Riccardo Cipolleschi on 23/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import Composability

public struct OnBoardingState: SliceState, Codable {

  public init() {}
  public static var sliceName: String = "\(Self.self)"

  var name: String = ""
  var birthDate: Date = Date()
  var plan: Models.Plan = .weightLoss

}

public extension DynamicState {
  internal(set) var onboardingState: OnBoardingState {
    get {
      return self[dynamicMember: OnBoardingState.sliceName] as! OnBoardingState
    }
    set {
      self[dynamicMember: OnBoardingState.sliceName] = newValue
    }
  }
}
