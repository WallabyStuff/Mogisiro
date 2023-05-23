//
//  SaturationGraph.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/23.
//

import SwiftUI

struct SaturationGraph: View {
  
  // MARK: - Properties
  
  var value: Float
  
  
  // MARK: - Views
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 4)
        .fill(
          LinearGradient(
            colors: [Color("blue"), Color("pink")],
            startPoint: .leading,
            endPoint: .trailing)
        )
      
      GeometryReader { proxy in
        Circle()
          .stroke(Color("gray3"), lineWidth: 0.3)
          .background(Circle().foregroundColor(Color("white")))
          .offset(.init(width: (proxy.size.width - 12) * (CGFloat(value) / 100), height: 0))
      }
      .frame(maxWidth: .infinity)
    }
    .frame(height: 12)
  }
}


// MARK: - Preview

struct SaturationGraph_Previews: PreviewProvider {
  static var previews: some View {
    SaturationGraph(value: 25)
  }
}
