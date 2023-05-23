//
//  MosquitoNetworkService.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/20.
//

import UIKit

import Combine
import SwiftyJSON

struct MosquitoNetworkService {
  
  // MARK: - Constants
  
  static let API_KEY = "795876734957616c38394a43424c45"
  
  
  // MARK: - Properties
  
  enum APIError: Error {
    case invalidData
  }

  private let basePath = "http://openapi.seoul.go.kr:8088"
  private let decoder = JSONDecoder()
  
  
  // MARK: - Methods
  
  func requestDaily(_ date: Date, type: AreaType) -> AnyPublisher<MosquitoValue, Error> {
    let path = "\(basePath)/\(Self.API_KEY)/json/MosquitoStatus/1/7/\(date.apiDateFormat)"
    guard let url = URL(string: path) else {
      return Fail(error: APIError.invalidData).eraseToAnyPublisher()
    }
    
    return URLSession.shared.dataTaskPublisher(for: url)
      .tryMap { data, response -> Data in
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
          throw APIError.invalidData
        }
        
        return data
      }
      .map { data -> MosquitoValue in
        let json = JSON(data)
        let value = json["MosquitoStatus"]["row"][0][type.codingKey].floatValue
        return MosquitoValue(value: value, date: date)
      }
      .eraseToAnyPublisher()
  }
  
  func requestWeekly(_ endDate: Date, type: AreaType) -> AnyPublisher<[MosquitoValue], Error> {
    let endDate = {
      if Date.isMaintainingTime() {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
      } else {
        return Date()
      }
    }()
    
    let startDate = Calendar.current.date(byAdding: .day, value: -6, to: endDate)
    
    return (0...6)
      .publisher
      .map { index -> Date in
        Calendar.current.date(byAdding: .day, value: index, to: startDate ?? Date()) ?? Date()
      }
      .flatMap { date -> AnyPublisher<MosquitoValue, Error> in
        return requestDaily(date, type: type)
      }
      .collect()
      .map { mosquitoValues in
        return mosquitoValues.sorted(by: { $0.date < $1.date })
      }
      .eraseToAnyPublisher()
  }
  
  func requestForecastDaily(_ value: Float) -> AnyPublisher<ForecastLocal, Error> {
    return Just(LocalData.forecast)
      .decode(type: [ForecastLocal].self, decoder: decoder)
      .map { forecastDetail in
        switch value {
        case 0..<25:
          return forecastDetail[0]
        case 25..<50:
          return forecastDetail[1]
        case 50..<75:
          return forecastDetail[2]
        case 75...100:
          return forecastDetail[3]
        default:
          return forecastDetail[0]
        }
      }
      .eraseToAnyPublisher()
  }
  
  func requestForecastWeekly(_ weeklyValue: [MosquitoValue]) -> AnyPublisher<MosquitoForecast, Error> {
    let todayValue = weeklyValue.last!.value
    
    return requestForecastDaily(todayValue)
      .map { forecastLocal -> MosquitoForecast in
        MosquitoForecast(
          statusDescription: forecastLocal.statusDescription,
          value: todayValue,
          valueMin: forecastLocal.mosquitoActivityIndex.min,
          valueMax: forecastLocal.mosquitoActivityIndex.max,
          comment: forecastLocal.comment,
          imageSrc: forecastLocal.imageSrc,
          situations: forecastLocal.situations,
          tips: forecastLocal.tips,
          weeklyValue: weeklyValue)
      }
      .eraseToAnyPublisher()
  }
  
  func requestTip() -> AnyPublisher<[TipLocal], Error> {
    Just(LocalData.tip)
      .decode(type: [TipLocal].self, decoder: decoder)
      .eraseToAnyPublisher()
  }
}

extension Date {
  var apiDateFormat: String {
    let dateFormatter = DateFormatter()
    let format = "yyyy-MM-dd"
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
  
  static func isMaintainingTime() -> Bool {
    let calendar = Calendar.current
    let dateComponents = calendar.dateComponents([.hour], from: Date())
    let hour = dateComponents.hour ?? 0
    
    switch hour {
    case 0...3:
      // 0시 ~ 오전3시
      return true
    default:
      return false
    }
  }
}
