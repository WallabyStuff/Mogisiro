//
//  Mogisiro+ApiKey.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/30.
//

import Foundation

extension Bundle {
  var apiKey: String {
    if let path = path(forResource: "MogisiroNetworkInfo", ofType: "plist"),
       let resource = NSDictionary(contentsOfFile: path),
       let key = resource["API_KEY"] as? String {
      return key
    } else {
      // Fail to find key
      return ""
    }
  }
}
