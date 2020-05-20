//
//  DynamicStateTests.swift
//  DynamicStateTests
//
//  Created by Riccardo Cipolleschi on 20/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import XCTest
@testable import Composability
@testable import FeatureA

class DynamicStateTests: XCTestCase {
  var dynamicState: DynamicState!

  override func setUpWithError() throws {
    self.dynamicState = DynamicState()
  }

  func testFeatureANotNil() throws {
    var faState = FeatureAState()
    faState.userName = "Test"
    dynamicState.states["FeatureA"] = faState
    let dynFAState = dynamicState.featureAState
    XCTAssertNotNil(dynFAState)
    XCTAssertEqual(dynFAState!.userName, "Test")
  }

  func testInitWithConfiguration() {
    self.dynamicState = DynamicState(configuration: Configuration(states: [
      StateConfiguration(frameworkName: "FeatureA", stateProviderName: "FeatureAStateProvider")
    ]))

    let dynFAState = dynamicState.featureAState
    XCTAssertNotNil(dynFAState)
  }
}

struct TestState: SliceState {
  let sliceName: String = "test"
  var a: Int = 10
}
