//
//  GameView.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/26.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            VStack(spacing: 0) {
                GameTopView()
                    .frame(height: height * 0.1)
                PieceCircleView()
                    .frame(height: height * 0.35)
                TouchableAreaView()
                    .frame(height: height * 0.55)
            }.frame(width: width, height: height)
            
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
