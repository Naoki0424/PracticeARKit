//
//  MenuView.swift
//  DetectFacialexpressions
//
//  Created by 角田直樹 on 2021/03/07.
//

import SwiftUI

struct MenuView: View {

    var body: some View {
        VStack() {
            List {
                ForEach(MenuItem.allCases, id: \.hashValue) { item in
                    Text(item.rawValue)
                }
            }
            Spacer()
            Text("Menu")
        }
        .opacity(0.8) // なぜか機能しない
        
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
