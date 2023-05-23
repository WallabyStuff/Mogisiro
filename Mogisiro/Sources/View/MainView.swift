//
//  MainView.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/17.
//

import SwiftUI

struct MainView: View {
  
  // MARK: - Properties
  
  @Environment(\.redactionReasons) var redactedReasons
  
  @StateObject private var store = MainViewStore()
  @State var index = 0
  @State var isDetailViewShown = false
  
  
  // MARK: - Views
  
  var body: some View {
    if let forecast = store.forecast {
      ZStack {
        ScrollView(showsIndicators: false) {
          VStack(spacing: 24) {
            principleSection(forecast)
            
            AreaTypeSegmentedControl(selectedAreaType: $store.areaType.animation())
            
            VStack(spacing: 16) {
              saturationGraphSection(forecast)
              situationSection(forecast.situations)
              tipSection(forecast.tips)
              weeklyBarChartSection(forecast.weeklyValue)
            }
          }
          .padding(.horizontal , 28)
          .padding(.top, 28)
          .padding(.bottom, 100)
        }
        
        showDetailButton()
      }
      .background(Color("white").ignoresSafeArea())
      .animation(.easeInOut, value: store.forecast)
    } else {
      ProgressView()
    }
  }
  
  private func principleSection(_ forecast: MosquitoForecast) -> some View {
    HStack(spacing: 0) {
      VStack(spacing: 12) {
        Text(forecast.statusDescription)
          .font(.bmPro(size: 40))
          .foregroundColor(Color("black"))
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Text(forecast.comment)
          .font(.bmPro(size: 18))
          .foregroundColor(Color("black"))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      
      Image(forecast.imageSrc)
        .resizable()
        .scaledToFit()
    }
  }
  
  private func saturationGraphSection(_ forecast: MosquitoForecast) -> some View {
    VStack(spacing: 24) {
      VStack(spacing: 8) {
        Text("\(forecast.value.description) - \(forecast.statusDescription)")
          .font(.bmPro(size: 20))
          .foregroundColor(Color("black"))
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Group {
          Text("일 평균 모기 개체수(예측값) : ")
          +
          Text("\(forecast.valueMin) 에서 \(forecast.valueMax)")
        }
        .font(.bmPro(size: 14))
        .foregroundColor(Color("gray7"))
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      
      // saturation graph here
      SaturationGraph(value: forecast.value)
    }
    .modifier(GroupModifier())
  }
  
  private func situationSection(_ situations: [String]) -> some View {
    VStack(spacing: 16) {
      Text("상황")
        .font(.bmPro(size: 20))
        .foregroundColor(Color("black"))
        .frame(maxWidth: .infinity, alignment: .leading)
      
      VStack(spacing: 8) {
        ForEach(situations, id: \.self) { situation in
          Text("- \(situation)")
            .font(.bmPro(size: 14))
            .foregroundColor(Color("gray7"))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
    .modifier(GroupModifier())
  }
  
  private func tipSection(_ tips: [String]) -> some View {
    VStack(spacing: 16) {
      Text("모기 예방법")
        .font(.bmPro(size: 20))
        .foregroundColor(Color("black"))
        .frame(maxWidth: .infinity, alignment: .leading)
      
      VStack(spacing: 8) {
        ForEach(tips, id: \.self) { tip in
          Text("- \(tip)")
            .font(.bmPro(size: 14))
            .foregroundColor(Color("gray7"))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
    .modifier(GroupModifier())
  }
  
  private func weeklyBarChartSection(_ weeklyValue: [MosquitoValue]) -> some View {
    MosquitoChartView(mosquitoValues: weeklyValue)
      .frame(height: 192)
      .modifier(GroupModifier())
  }
  
  private func showDetailButton() -> some View {
    VStack {
      Button {
        isDetailViewShown.toggle()
      } label: {
        ZStack {
          Circle()
            .fill(Color("black"))
          
          Text("?")
            .font(.bmPro(size: 30))
            .foregroundColor(.white)
        }
        .frame(width: 60, height: 60)
      }
      .sheet(isPresented: $isDetailViewShown) {
        DetailGuidelineView()
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    .padding(20)
  }
  
  
  // MARK: - Methods
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
