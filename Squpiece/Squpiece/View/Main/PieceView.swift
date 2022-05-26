//
//  PieceView.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/26.
//

import SwiftUI

struct PieceView: View {
    @Binding var currentPieces: Pieces
    var body: some View {
        let pieceWidth = width * 0.12
        //https://developer.apple.com/documentation/swiftui/foreach
        HStack {
            ForEach(currentPieces.pick, id: \.self) { piece in
                Image(systemName: piece)
                    .resizable()
                    .frame(width: pieceWidth, height: pieceWidth)
                    .padding()
            }
        }.frame(width: width, height: height * 0.5, alignment: .center)
            .onTapGesture() {
                changePiece()
            }
    }
    
    func changePiece() {
        if(currentPieces == Pieces.calculator) {
            currentPieces = Pieces.pocker
        } else if (currentPieces == Pieces.pocker) {
            currentPieces = Pieces.direction
        } else {
            currentPieces = Pieces.calculator
        }
    }
}

struct PieceView_Previews: PreviewProvider {
    static var previews: some View {
        PieceView(currentPieces: .constant(Pieces.calculator))
    }
}
