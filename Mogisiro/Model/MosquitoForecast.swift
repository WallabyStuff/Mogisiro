//
//  MosquitoForecast.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/21.
//

import Foundation

struct MosquitoForecast {
  var statusDescription: String
  var value: Float
  var valueMin: Int
  var valueMax: Int
  var comment: String
  var imageSrc: String
  var situations: [String]
  var tips: [String]
  var weeklyValue: [Float]
}
