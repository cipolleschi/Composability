//
//  OnboardingNameVC.swift
//  OnBoarding
//
//  Created by Riccardo Cipolleschi on 23/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import UIKit
import Composability

class OnboardingNameVC: ComposableVC {

  var rootView: OnboardingNameView {
    return self.view as! OnboardingNameView
  }

  override func loadView() {
    let v = OnboardingNameView(frame: .zero)
    self.view = v
  }

  override func setupInteractions() {
    self.rootView.userDidTapNext = {
      self.navigationController?.pushViewController(OnboardingAgeVC(store: self.store), animated: true)
    }
  }
  
}

// MARK: - ViewModel

class OnboardingNameVM {
  init(dynamicState: DynamicState) {

  }
}

// MARK: - View

class OnboardingNameView: UIView {
  var model: OnboardingNameVM? {
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
    self.label.text = "Insert Your Name:"
    self.label.textAlignment = .center

    self.button.setTitle("NEXT", for: .normal)
    self.button.setTitleColor(.black, for: .normal)
    self.button.setTitleColor(.gray, for: .highlighted)
  }

  func update(oldModel: OnboardingNameVM?) {

  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.label.frame = CGRect(x: 10, y: 100, width: self.bounds.width - 20, height: 30)
    self.button.frame = CGRect(x: 50, y: 400, width: self.bounds.width - 100, height: 40)
  }
}
