//
//  PieceCircleView.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/26.
//

import SwiftUI

struct PieceCircleView: View {
    let mainPieceWidth = width * 0.2
    let mainCircleWidth = width * 0.4
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.red)
                    .frame(width: mainCircleWidth, height: mainCircleWidth)
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: mainPieceWidth, height: mainPieceWidth, alignment: .center)
            }
        }
    }
}

struct PieceCircleView_Previews: PreviewProvider {
    static var previews: some View {
        PieceCircleView()
    }
}
