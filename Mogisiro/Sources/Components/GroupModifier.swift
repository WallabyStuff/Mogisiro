//
//  GroupModifier.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/23.
//

import SwiftUI

struct GroupModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 12)
      .padding(.vertical, 20)
      .background(Color("gray1"))
      .cornerRadius(20)
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .strokeBorder(Color("gray3"), lineWidth: 1)
      )
  }
}
