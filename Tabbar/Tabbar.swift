//
//  Tabbar.swift
//  Tabbar
//
//  Created by Riccardo Cipolleschi on 24/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import UIKit
import Composability
import Navigator

class TabbarVC: UITabBarController {
  let store: Store!

  init(store: Store) {
    self.store = store
    super.init(nibName: nil, bundle: nil)
    let vc1 = UIViewController()
    vc1.view.backgroundColor = .red

    let vc2 = UIViewController()
    vc2.view.backgroundColor = .green

    let vc3 = UIViewController()
    vc3.view.backgroundColor = .blue

    self.viewControllers = [vc1, vc2, vc3]

    vc1.tabBarItem.title = "One"
    vc2.tabBarItem.title = "Two"
    vc3.tabBarItem.title = "Three"

  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

public class TabbarEntryPoint: EntryPointBuilder {
  public static var name: String { return "\(Self.self)"}
  public required init() {}
  public func start(dependencies: DependenciesContainer) {}

  public func createEntryPoint(store: Store) -> UIViewController {
    return TabbarVC(store: store)
  }
}

public extension DependenciesContainer {
  var tabbarBuilder: EntryPointBuilder {
    return self[dynamicMember: TabbarEntryPoint.name] as! EntryPointBuilder
  }
}
