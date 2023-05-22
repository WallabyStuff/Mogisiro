//
//  ForecastLocal.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/21.
//

import Foundation

struct ForecastLocal: Decodable {
  let statusDescription: String
  let comment: String
  let imageSrc: String
  let mosquitoActivityIndex: MosquitoActivityIndex
  let situations: [String]
  let tips: [String]
  
  private enum CodingKeys: String, CodingKey {
    case statusDescription, comment, imageSrc, mosquitoActivityIndex, situations, tips
  }
}

struct MosquitoActivityIndex: Decodable {
  let min: Int
  let max: Int
  
  private enum CodingKeys: String, CodingKey {
    case min, max
  }
}
