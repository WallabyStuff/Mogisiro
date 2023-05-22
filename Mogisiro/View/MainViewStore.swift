//
//  MainViewStore.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/20.
//

import SwiftUI
import Combine

class MainViewStore: ObservableObject {
  
  // MARK: - Properties
  
  private var cancellableBag = Set<AnyCancellable>()
  private var service = MosquitoNetworkService()
  
  
  // MARK: - Initializers
  
  init() {
    setup()
  }
  
  
  // MARK: - Setups
  
  private func setup() {
    setupData()
  }
  
  private func setupData() {
    setupMosquitoForecast()
  }
  
  private func setupMosquitoForecast() {
    service.requestWeekly(Date(), type: .house)
      .flatMap { weeklyValue in
        return self.service.requestForecastWeekly(weeklyValue)
      }
      .sink { error in
        print(error)
      } receiveValue: { forecast in
        print(forecast)
      }
      .store(in: &cancellableBag)
    
    service.requestTip()
      .sink { error in
        print(error)
      } receiveValue: { tips in
        print(tips)
      }
      .store(in: &cancellableBag)
  }
}
