//
//  TipLocal.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/22.
//

import Foundation

struct TipLocal: Decodable, Hashable {
  let situation: String
  let tips: [SubTip]
}

struct SubTip: Decodable, Hashable {
  let title: String
  let subTips: [String]
}
