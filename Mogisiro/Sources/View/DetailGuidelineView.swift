//
//  DetailGuideline.swift
//  Mogisiro
//
//  Created by 이예은 on 2023/05/23.
//

import SwiftUI

struct DetailGuidelineView: View {
  
  // MARK: - Properties
  
  @StateObject private var store = DetailViewStore()
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 0) {
      VStack {
        Text("상세 대처법")
          .font(.bmPro(size: 18))
          .foregroundColor(Color("black"))
          .padding(16)
      }
        
      List(store.guidelines, id: \.self) { guideline in
        section(guideline)
      }
      .listStyle(.sidebar)
      .accentColor(Color("pink"))
    }
  }
    
  private func section(_ guideline: TipLocal) -> some View {
    Section(header: Text(guideline.situation)
      .font(.bmPro(size: 20))
      .frame(maxWidth: .infinity, alignment: .leading)
      .foregroundColor(Color("black"))
    ) {
      subTipsView(guideline.tips)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    .listRowInsets(.init(top: 40, leading: 8, bottom: 20, trailing: 8))
  }
  
  private func subTipsView(_ subTips: [SubTip]) -> some View {
    VStack(spacing: 20) {
      ForEach(Array(subTips.enumerated()), id: \.offset) { index, subTip in
        VStack(spacing: 12) {
          Text("\(index + 1). \(subTip.title)")
            .font(.bmPro(size: 17))
            .foregroundColor(Color("black"))
            .frame(maxWidth: .infinity, alignment: .leading)
          
          VStack {
            ForEach(subTip.subTips, id: \.self) { tip in
              Text("- \(tip)")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color("black"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 4)
            }
          }
          .modifier(GroupModifier())
        }
      }
    }
    .padding(24)
  }
}

struct DetailGuideline_Previews: PreviewProvider {
  static var previews: some View {
    DetailGuidelineView()
  }
}
