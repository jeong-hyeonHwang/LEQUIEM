//
//  Piece.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/26.
//

import Foundation

enum Pieces {
    case calculator
    case pocker
    case direction
    
    var pick: [String] {
        switch self {
        case .calculator:
            return pieces1
        case .pocker:
            return pieces2
        case .direction:
            return pieces3
        }
    }
}
