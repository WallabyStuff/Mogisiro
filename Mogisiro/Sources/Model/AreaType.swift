//
//  AreaType.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/23.
//

import Foundation

enum AreaType: Int, CaseIterable {
  case house
  case park
  case water
}

extension AreaType {
  var codingKey: String {
    switch self {
    case .house:
      return "MOSQUITO_VALUE_HOUSE"
    case .park:
      return "MOSQUITO_VALUE_PARK"
    case .water:
      return "MOSQUITO_VALUE_WATER"
    }
  }
}

extension AreaType {
  var localizedString: String {
    switch self {
    case .house:
      return "주거지"
    case .park:
      return "공원"
    case .water:
      return "수변부"
    }
  }
}
