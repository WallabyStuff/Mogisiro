//
//  AreaTypeSegmentedControl.swift
//  Mogisiro
//
//  Created by 이승기 on 2023/05/23.
//

import SwiftUI

struct AreaTypeSegmentedControl: View {
  
  @Binding var selectedAreaType: AreaType
  
  var body: some View {
    SegmentedControl(
      selectedIndex: Binding<Int>.init(
        get: {
          return selectedAreaType.rawValue
      }, set: { index in
        selectedAreaType = AreaType(rawValue: index) ?? .house
      }),
      options: AreaType.allCases.map { $0.localizedString })
  }
}

struct TargetAreaSegmentedControl_Preview: PreviewProvider {
  static var previews: some View {
    AreaTypeSegmentedControl(selectedAreaType: .constant(.house))
  }
}
