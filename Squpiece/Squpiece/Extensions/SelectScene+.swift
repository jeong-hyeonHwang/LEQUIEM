//
//  SelectScene+.swift
//  Squpiece
//
//  Created by 황정현 on 2022/09/14.
//

import SpriteKit

extension SelectScene {
    func patternPiecePositionSetter(circleRadius: CGFloat, frame: CGRect, patternSprites: [SKShapeNode]) {
        let angleFloat: CGFloat = 60
        let radius = circleRadius * 1.2
        let startAngle : CGFloat = 90
        var radianValue = startAngle.deg2rad()
        for i in 0..<6 {
            patternSprites[i].isHidden = false
            patternSprites[i].position = CGPoint(x: radius * cos(radianValue), y: radius * sin(radianValue))
            radianValue += angleFloat.deg2rad()
        }
    }
}
