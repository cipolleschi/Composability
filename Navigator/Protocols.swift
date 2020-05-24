//
//  Protocols.swift
//  Navigator
//
//  Created by Riccardo Cipolleschi on 24/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import Composability
import UIKit

/// Protocol that the UI modules must implement if they provide a RootViewController
public protocol EntryPointBuilder: ExternalDependency {
  func createEntryPoint(store: Store) -> UIViewController
}

/// Protocol that the dispatchables of FlowConcluded should implement to notify the navigator
/// that a new flow must start
public protocol EndModuleFlow: Dispatchable {
  var moduleName: String { get }
  var data: [String: Any] { get }
}

/// Protocol that the app must implement to handle the navigation
public protocol NavigationManager: ExternalDependency {
  func initialVC()

  func nextVC(endFlow: EndModuleFlow)
}
