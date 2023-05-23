//
//  DetailGuideline.swift
//  Mogisiro
//
//  Created by 이예은 on 2023/05/23.
//

import SwiftUI

struct DetailGuidelineView: View {
  @State private var showModal = false
  var body: some View {
    VStack {
      Button(action: {
        self.showModal = true
      }) {
        Text("물음표 버튼").bold()
      }
      .frame(width: 80,height: 30, alignment: .center)
      .sheet(isPresented: self.$showModal) {
        ModalView()
      }
    }
  }
}

struct DetailGuideline_Previews: PreviewProvider {
    static var previews: some View {
        DetailGuidelineView()
    }
}

struct ModalView: View {
  @ObservedObject private var viewStore = DetailViewStore()
  @Environment(\.presentationMode) var presentation
  
  var body: some View {
    VStack {
      if let information = viewStore.detailLocal {
        Text("상세 대처법")
          .font(.bmPro(size: 24))
          .fontWeight(.bold)
          .padding(.top, 30)
          .padding(.bottom, 30)
        
        List {
          Section(header: Text(information.result[0].action)
            .font(.bmPro(size: 23))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .padding(.top, 20)
            .padding(.bottom, 20))
          {
            
            Text(information.result[0].content[0].title)
              .font(.bmPro(size: 18))
              .fontWeight(.bold)
            GroupBox {
              Text(information.result[0].content[0].description)
                .font(.callout)
                .bold()
                .frame(width: 300)
            }
            .padding()
            
            Text(information.result[0].content[1].title)
              .font(.bmPro(size: 18))
              .fontWeight(.bold)
            GroupBox {
              Text(information.result[0].content[1].description)
                .font(.callout)
                .bold()
                .frame(width: 300)
            }
            .padding()
            
            Text(information.result[0].content[2].title)
              .font(.bmPro(size: 18))
              .fontWeight(.bold)
            GroupBox {
              Text(information.result[0].content[2].description)
                .font(.callout)
                .bold()
                .frame(width: 300)
            }
            .padding()
          }
          
          Divider()
          Section(header: Text(information.result[1].action)
            .font(.bmPro(size: 20))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .padding(.top, 20)
            .padding(.bottom, 20)) {
              
              Text(information.result[1].content[0].title)
                .font(.bmPro(size: 18))
                .fontWeight(.bold)
              GroupBox {
                Text(information.result[1].content[0].description)
                  .font(.callout)
                  .bold()
                  .frame(width: 300)
              }
              .padding()
              
              Text(information.result[1].content[1].title)
                .font(.bmPro(size: 18))
                .fontWeight(.bold)
              GroupBox {
                Text(information.result[1].content[1].description)
                  .font(.callout)
                  .bold()
                  .frame(width: 300)
              }
              .padding()
              
              Text(information.result[1].content[2].title)
                .font(.bmPro(size: 18))
                .fontWeight(.bold)
              GroupBox {
                Text(information.result[1].content[2].description)
                  .font(.callout)
                  .bold()
                  .frame(width: 300)
              }
              .padding()
            }
          
          Divider()
          Section(header: Text(information.result[2].action)
            .font(.bmPro(size: 20))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .padding(.top, 20)
            .padding(.bottom, 20)) {
              Text(information.result[2].content[0].title)
                .font(.bmPro(size: 18))
                .fontWeight(.bold)
              GroupBox {
                Text(information.result[2].content[0].description)
                  .font(.callout)
                  .bold()
                  .frame(width: 300)
              }
              .padding()
              
              Text(information.result[2].content[1].title)
                .font(.bmPro(size: 18))
                .fontWeight(.bold)
              GroupBox {
                Text(information.result[2].content[1].description)
                  .font(.callout)
                  .bold()
                  .frame(width: 300)
              }
              .padding()
              
              Text(information.result[2].content[2].title)
                .font(.bmPro(size: 18))
                .fontWeight(.bold)
              GroupBox {
                Text(information.result[2].content[2].description)
                  .font(.callout)
                  .bold()
                  .frame(width: 300)
              }
              .padding()
              
              Text(information.result[2].content[3].title)
                .font(.bmPro(size: 18))
                .fontWeight(.bold)
              GroupBox {
                Text(information.result[2].content[3].description)
                  .font(.callout)
                  .bold()
                  .frame(width: 300)
              }
              .padding()
            }
        }
        .listStyle(SidebarListStyle())
        .tint(.black)
        .background(Color.white.ignoresSafeArea())
        .scrollContentBackground(.hidden)
      }
    }
  }
}
