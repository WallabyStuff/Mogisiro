//
//  MainView.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/17.
//

import SwiftUI

struct MainView: View {
  
  // MARK: - Properties
  
  @StateObject private var store = MainViewStore()
  @State var index = 0
  @State var isDetailViewShown = false
  
  
  // MARK: - Views
  
  var body: some View {
    ZStack {
      ScrollView {
        VStack(spacing: 24) {
          principleSection()
          
          AreaTypeSegmentedControl(selectedAreaType: $store.areaType.animation())
          
          VStack(spacing: 16) {
            saturationGraphSection()
            situationSection()
            tipSection()
            weeklyBarChartSection()
          }
        }
        .padding(.horizontal , 28)
        .padding(.bottom, 100)
      }
      
      showDetailButton()
    }
    .background(Color("white").ignoresSafeArea())
  }
  
  private func principleSection() -> some View {
    HStack(spacing: 0) {
      VStack(spacing: 12) {
        Text(store.forecast?.statusDescription ?? "")
          .font(.bmPro(size: 40))
          .foregroundColor(Color("black"))
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Text(store.forecast?.comment ?? "")
          .font(.bmPro(size: 18))
          .foregroundColor(Color("black"))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      
      Image(store.forecast?.imageSrc ?? "")
        .resizable()
        .scaledToFit()
    }
  }
  
  private func saturationGraphSection() -> some View {
    VStack(spacing: 24) {
      VStack(spacing: 8) {
        Text("\(store.forecast?.value.description ?? "0") - \(store.forecast?.statusDescription ?? "")")
          .font(.bmPro(size: 20))
          .foregroundColor(Color("black"))
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Group {
          Text("일 평균 모기 개체수(예측값) : ")
          +
          Text("\(store.forecast?.valueMin ?? 0) 에서 \(store.forecast?.valueMax ?? 0)")
        }
        .font(.bmPro(size: 14))
        .foregroundColor(Color("gray7"))
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      
      // saturation graph here
      SaturationGraph(value: store.forecast?.value ?? 0)
    }
    .modifier(GroupModifier())
  }
  
  private func situationSection() -> some View {
    VStack(spacing: 16) {
      Text("상황")
        .font(.bmPro(size: 20))
        .foregroundColor(Color("black"))
        .frame(maxWidth: .infinity, alignment: .leading)
      
      VStack(spacing: 8) {
        ForEach(store.forecast?.situations ?? [], id: \.self) { situation in
          Text("- \(situation)")
            .font(.bmPro(size: 14))
            .foregroundColor(Color("gray7"))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
    .modifier(GroupModifier())
  }
  
  private func tipSection() -> some View {
    VStack(spacing: 16) {
      Text("모기 예방법")
        .font(.bmPro(size: 20))
        .foregroundColor(Color("black"))
        .frame(maxWidth: .infinity, alignment: .leading)
      
      VStack(spacing: 8) {
        ForEach(store.forecast?.tips ?? [], id: \.self) { situation in
          Text("- \(situation)")
            .font(.bmPro(size: 14))
            .foregroundColor(Color("gray7"))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
    .modifier(GroupModifier())
  }
  
  private func weeklyBarChartSection() -> some View {
    MosquitoChartView(mosquitoValues: store.forecast?.weeklyValue ?? [])
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
        Text("DetailView")
          .font(.bmPro(size: 24))
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
