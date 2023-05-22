//
//  LocalData.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/21.
//

import Foundation

enum LocalData {
  static let forecast: Data = {
    let url = Bundle.main.url(forResource: "forecast_local", withExtension: "json")!
    return try! Data(contentsOf: url)
  }()
  
  static let tip: Data = {
    let url = Bundle.main.url(forResource: "tips_local", withExtension: "json")!
    return try! Data(contentsOf: url)
  }()
}
