//
//  ViewController.swift
//  TestApp
//
//  Created by Riccardo Cipolleschi on 22/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import UIKit
import Composability

class ViewController: UIViewController, StateSubscriber {


  let store: Store

  init(store: Store){
    self.store = store
    super.init(nibName: nil, bundle: nil)

    DispatchQueue.main.async {
      self.store.addSubscriber(subs: self)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.view.backgroundColor = .yellow
  }

  func stateDidUpdate(oldState: DynamicState, newState: DynamicState) {
    DispatchQueue.main.sync {
      self.view.backgroundColor = .green
    }
  }
}

