//
//  SegmentedControl.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/23.
//

import SwiftUI

struct SegmentedControl: View {
  
  // MARK: - Constants
  
  
  // MARK: - Properties
  
  @Binding var selectedIndex: Int
  var options: [String]
  
  
  // MARK: - Views
  
  var body: some View {
    ZStack {
      GeometryReader { proxy in
        let width = proxy.size.width / CGFloat(options.count)
        
        RoundedRectangle(cornerRadius: 10)
          .fill(Color("pink"))
          .padding(2)
          .frame(width: width)
          .offset(x: width * CGFloat(selectedIndex))
      }
      
      HStack(spacing: 0) {
        ForEach(options.indices, id: \.self) { index in
          Button {
            withAnimation(.spring().speed(2)) {
              selectedIndex = index
            }
          } label: {
            Text(options[index])
              .font(.bmPro(size: 16))
              .foregroundColor(selectedIndex == index ? Color("white") : Color("black"))
              .disabled(true)
              .frame(maxWidth: .infinity, maxHeight: .infinity)
          }
        }
      }
    }
    .frame(height: 40)
    .background(Color("gray2"))
    .cornerRadius(10)
  }
}


// MARK - Preview

struct SegmentedControl_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
      
      SegmentedControl(
        selectedIndex: .constant(1),
        options: ["option1", "option2", "option3"])
    }
  }
}
