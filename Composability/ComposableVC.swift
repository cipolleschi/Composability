//
//  ComposableVC.swift
//  Composability
//
//  Created by Riccardo Cipolleschi on 23/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import UIKit

open class ComposableVC: UIViewController, StateSubscriber {

  public let store: Store

  public init(store: Store){
    self.store = store
    super.init(nibName: nil, bundle: nil)

    DispatchQueue.main.async {
      self.store.addSubscriber(subs: self)
    }
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open override func viewDidLoad() {
    super.viewDidLoad()
    self.setupInteractions()
  }

  open func stateDidUpdate(oldState: DynamicState, newState: DynamicState) {
    
  }

  open func setupInteractions() {
    
  }
}
