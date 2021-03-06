//
//  ContentView.swift
//  DetectFacialexpressions
//
//  Created by 角田直樹 on 2021/03/06.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    // offset変数でメニューを表示・非表示するためのオフセットを保持します
    @State private var offset = CGFloat.zero
    @State private var closeOffset = CGFloat.zero
    @State private var openOffset = CGFloat.zero
    
    @EnvironmentObject var menuInfo: MenuInfo
    
    @State var isAnimation = false
    @State var color: Color = getColor()
    
    var body: some View {
        // 画面サイズの取得にGeometoryReaderを利用します
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                // メインコンテンツ
                ARViewContainer(menuInfo: self.menuInfo)
                    .edgesIgnoringSafeArea(.all)
                
                if self.menuInfo.menuItem == .musicNotes {
                    Rectangle().foregroundColor(self.color).opacity(self.isAnimation ? 0 : 0.3)
                        .onAppear() {
                            withAnimation(
                                Animation
                                    .linear(duration: 0.5)
                                    .repeatForever(autoreverses: true)
                            ) {
                                self.color = getColor() // ←なぜか切り替わらない
                                self.isAnimation.toggle()
                            }
                        }
                }
                // スライドメニュー
                MenuView()
                    .background(Color.white)
                    //                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.8)
                    // 最初に画面のオフセットの値をスライドメニュー分マイナスします。
                    .onAppear(perform: {
                        // セーフティエリアの分がちょうどよく画面上部に表示されるので採用
                        self.offset = (geometry.size.height) * -1
                        //                        self.offset = (geometry.size.height + geometry.safeAreaInsets.top) * -1
                        self.closeOffset = self.offset
                        self.openOffset = .zero
                    })
                    .offset(y: self.offset)
                    // スライドのアニメーションを設定します
                    .animation(.default)
                
            }
            // ジェスチャーに関する実装をします
            // スワイプのしきい値を設定してユーザの思わぬメニューの出現を防ぎます
            .gesture(DragGesture(minimumDistance: 5)
                        .onChanged{ value in
                            // メインコンテンツの縦方向のスクロールを妨げないためにstartLocationを使用します
                            // オフセットの値(メニューの位置)をスワイプした距離に応じて狭めていきます
                            if (self.offset != self.openOffset && value.startLocation.y < 30) {
                                self.offset = self.closeOffset + value.translation.height
                            }
                        }
                        .onEnded { value in
                            // スワイプ開始位置よりも終了位置が下だったらメニューを開く
                            if (value.startLocation.y < value.location.y) {
                                if (value.startLocation.y < 30) {
                                    self.offset = self.openOffset
                                }
                            } else {
                                self.offset = self.closeOffset
                            }
                        }
            )

        }
    }
    
    struct ARViewContainer: UIViewRepresentable {
        var menuInfo: MenuInfo
        func makeUIView(context: Context) -> ARDetectFaceView {
            return ARDetectFaceView(frame: .zero, menuInfo)
        }
        func updateUIView(_ uiView: ARDetectFaceView, context: Context) {}
    }

}

func getColor() -> Color {
    let num = Int.random(in: 1...5)
    if num == 1 {
        return .pink
    }else if num == 2 {
        return .yellow
    }else if num == 3 {
        return .red
    }else if num == 4 {
        return .pink
    }else {
        return .blue
    }
}
