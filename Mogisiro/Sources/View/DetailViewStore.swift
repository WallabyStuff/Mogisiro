//
//  DetailViewStore.swift
//  Mogisiro
//
//  Created by 이예은 on 2023/05/23.
//

import SwiftUI
import Combine

class DetailViewStore: ObservableObject {
  
  // MARK: - Properties
  
  private var cancellableBag = Set<AnyCancellable>()
  private var service = MosquitoNetworkService()
  @Published var guidelines = [TipLocal]()
  
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
    service.requestTip()
      .sink { error in
        print(error)
      } receiveValue: { tips in
        self.guidelines = tips
      }
      .store(in: &cancellableBag)
  }
}
