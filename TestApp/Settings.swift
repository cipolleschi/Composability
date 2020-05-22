//
//  Settings.swift
//  TestApp
//
//  Created by Riccardo Cipolleschi on 22/05/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation

struct Settings: Codable {
  enum CodingKeys: String, CodingKey {
    case testString = "test_string"
    case testNumber = "test_number"
  }

  let testString: String
  let testNumber: Int
}
