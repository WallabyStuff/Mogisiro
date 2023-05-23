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
  var detailLocal: DetailLocal? = nil
  
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
    service.requestDetail()
      .sink { error in
        print(error)
      } receiveValue: { detail in
        self.detailLocal = detail
      }
  }
}
