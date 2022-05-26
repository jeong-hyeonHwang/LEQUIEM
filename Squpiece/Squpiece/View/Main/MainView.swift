//
//  MainView.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/26.
//

import SwiftUI

struct MainView: View {
    @State var currentPieces = Pieces.calculator
    var body: some View {
        VStack {
            TitleView()
            PieceView(currentPieces: $currentPieces)
            StartButtonView()
        }
        .ignoresSafeArea()
        .background(Color.yellow)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
