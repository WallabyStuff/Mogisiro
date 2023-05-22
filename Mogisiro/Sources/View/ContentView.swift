//
//  ContentView.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/17.
//

import SwiftUI

struct ContentView: View {
  
  // MARK: - Properties
  
  @ObservedObject private var viewModel = MainViewStore()
  
  
  // MARK: - Views
  
  var body: some View {
    VStack {
      Text("BMHANNAPro 폰트")
        .font(.custom("BMHANNAPro", size: 20))
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
