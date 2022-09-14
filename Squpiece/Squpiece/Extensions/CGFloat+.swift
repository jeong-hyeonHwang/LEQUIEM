//
//  CGFloat+.swift
//  Squpiece
//
//  Created by 황정현 on 2022/09/14.
//

import Foundation

extension CGFloat {
    //https://www.hackingwithswift.com/example-code/language/how-to-convert-radians-to-degrees
    func rad2deg() -> Double {
        return self * 180 / Double.pi
    }

    //https://www.hackingwithswift.com/example-code/language/how-to-convert-degrees-to-radians
    func deg2rad() -> Double {
        return self * Double.pi / 180
    }
}
