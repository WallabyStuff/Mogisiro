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
  
  @Published var forecast: MosquitoForecast?
  @Published var areaType: AreaType = .house {
    didSet {
      setupMosquitoForecast(areaType: areaType)
    }
  }
  
  
  // MARK: - Initializers
  
  init() {
    setup()
  }
  
  
  // MARK: - Setups
  
  private func setup() {
    setupData()
  }
  
  private func setupData() {
    setupMosquitoForecast(areaType: areaType)
  }
  
  private func setupMosquitoForecast(areaType: AreaType) {
    service.requestWeekly(Date(), type: areaType)
      .subscribe(on: DispatchQueue.global(qos: .default))
      .receive(on: DispatchQueue.main)
      .flatMap { weeklyValue in
        return self.service.requestForecastWeekly(weeklyValue)
      }
      .sink { error in
        print(error)
      } receiveValue: { [weak self] forecast in
        self?.forecast = forecast
      }
      .store(in: &cancellableBag)
  }
}
