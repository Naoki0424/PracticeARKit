//
//  MenuView.swift
//  DetectFacialexpressions
//
//  Created by 角田直樹 on 2021/03/07.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var menuInfo: MenuInfo
    var body: some View {
        VStack() {
            List {
                ForEach(MenuItem.allCases, id: \.hashValue) { item in
                    Button(action: {
                        menuInfo.menuItem = item
                     }, label: { Text(item.rawValue)})
                }
            }
            .opacity(0.8) 
            Spacer()
            Text("Menu")
        }
        .opacity(0.8) // なぜか機能しない
        
    }
}

