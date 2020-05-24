//
//  OnboardingPlanVC.swift
//  OnBoarding
//
//  Created by Riccardo Cipolleschi on 23/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import UIKit
import Composability

class OnboardingPlanVC: ComposableVC {

  var rootView: OnboardingPlanView {
    return self.view as! OnboardingPlanView
  }

  override func loadView() {
    let v = OnboardingPlanView(frame: .zero)
    self.view = v
  }

  override func setupInteractions() {
    self.rootView.userDidTapNext = {
      _ = try? self.store.dispatch(OnboardingEnd(data: [:]))
    }
  }
}

// MARK: - ViewModel

class OnboardingPlanVM {
  init(dynamicState: DynamicState) {

  }
}

// MARK: - View

class OnboardingPlanView: UIView {
  var model: OnboardingPlanVM? {
    didSet {
      self.update(oldModel: oldValue)
    }
  }

  private let label = UILabel()
  private let button = UIButton()

  var userDidTapNext: (() -> ())?

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
    self.style()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setup() {
    self.addSubview(self.label)
    self.addSubview(self.button)

    self.button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
  }

  @objc func buttonTapped(_ control: UIControl) {
    self.userDidTapNext?()
  }

  func style() {
    self.backgroundColor = .white
    self.label.text = "Choose your plan:"
    self.label.textAlignment = .center

    self.button.setTitle("NEXT", for: .normal)
    self.button.setTitleColor(.black, for: .normal)
    self.button.setTitleColor(.gray, for: .highlighted)
  }

  func update(oldModel: OnboardingPlanVM?) {

  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.label.frame = CGRect(x: 10, y: 100, width: self.bounds.width - 20, height: 30)
    self.button.frame = CGRect(x: 50, y: 400, width: self.bounds.width - 100, height: 40)
  }
}
