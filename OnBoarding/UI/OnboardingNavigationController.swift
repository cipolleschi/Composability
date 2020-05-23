//
//  OnboardingNavigationController.swift
//  OnBoarding
//
//  Created by Riccardo Cipolleschi on 23/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import UIKit
import Composability

public class OnboardingNC: UINavigationController {
  let store: Store

  public init(store: Store) {
    self.store = store
    super.init(nibName: nil, bundle: nil)
    self.viewControllers = [OnboardingNameVC(store: self.store)]
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
