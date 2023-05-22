//
//  MosquitoAPI.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/17.
//

import Foundation
import Moya

enum MosquitoAPI {
  case mosquitoStatus(date: Date)
}

extension MosquitoAPI: TargetType {
  
  static let API_KEY = "795876734957616c38394a43424c45"
  
  var baseURL: URL {
    return URL(string: "http://openapi.seoul.go.kr:8088")!
  }

  var path: String {
    switch self {
    case .mosquitoStatus(let date):
      return "\(Self.API_KEY)/json/MosquitoStatus/1/7/\(date.apiDateFormat)"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .mosquitoStatus:
      return .get
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .mosquitoStatus:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    return nil
  }
}

