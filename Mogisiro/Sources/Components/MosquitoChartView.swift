//
//  MosquitoChartView.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/23.
//

import SwiftUI

struct MosquitoChartView: View {
  
  let mosquitoValues: [MosquitoValue]
  
  var body: some View {
    HStack {
      VStack(spacing: 4) {
        barRows()
        dateRow()
      }
      
      indexColumn()
    }
  }
  
  private func dateRow() -> some View {
    HStack {
      ForEach(mosquitoValues, id: \.self) { mosquitoValue in
        Spacer()
        Text(mosquitoValue.day())
          .foregroundColor(Color("gray5"))
          .font(.system(size: 13, weight: .medium))
        
        Spacer()
      }
    }
  }
  
  private func barRows() -> some View {
    GeometryReader { proxy in
      HStack(alignment: .bottom) {
        ForEach(mosquitoValues, id: \.self) { mosquitoValue in
          Spacer()
          
          VStack {
            let barHeight = proxy.size.height * (CGFloat(mosquitoValue.value) / 100)
            
            Spacer()
              .frame(height: proxy.size.height - barHeight)
            
            RoundedRectangle(cornerRadius: 4)
              .fill(Color("teal"))
              .frame(width: 16, height: barHeight)
          }
          
          Spacer()
        }
      }
    }
  }
  
  private func indexColumn() -> some View {
    VStack(alignment: .trailing) {
      Text("100")
      Spacer()
      Text("75")
      Spacer()
      Text("50")
      Spacer()
      Text("25")
      Spacer()
      Text("0")
    }
    .font(.system(size: 13, weight: .medium))
    .foregroundColor(Color("gray5"))
    .padding(.bottom, 16)
  }
}

struct MosquitoChartView_Previews: PreviewProvider {
  static var previews: some View {
    MosquitoChartView(mosquitoValues: [
      .init(value: 48, date: Date()),
      .init(value: 23, date: Date()),
      .init(value: 40, date: Date()),
      .init(value: 60, date: Date()),
      .init(value: 90, date: Date()),
      .init(value: 100, date: Date()),
      .init(value: 76, date: Date()),
    ])
      .frame(height: 200)
      .previewLayout(.sizeThatFits)
  }
}
