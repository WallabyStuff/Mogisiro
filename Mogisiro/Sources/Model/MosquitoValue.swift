//
//  MosquitoValue.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/23.
//

import Foundation

struct MosquitoValue: Hashable {
  let value: Float
  let date: Date
}

extension MosquitoValue {
  func day() -> String {
    let dateFormatter = DateFormatter()
    let format = "E"
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
  }
}
