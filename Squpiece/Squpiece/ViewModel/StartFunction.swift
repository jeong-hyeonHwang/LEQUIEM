//
//  StartFunction.swift
//  Squpiece
//
//  Created by 황정현 on 2022/06/21.
//

import Foundation
import SpriteKit
import SwiftUI

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

func blinkEffect(node: SKNode, duration: CGFloat) {
    let fadeOut = SKAction.fadeOut(withDuration: duration)
    let wait = SKAction.wait(forDuration: duration * 0.25)
    let fadeIn = SKAction.fadeIn(withDuration: duration)
    let sequence = SKAction.sequence([fadeOut, wait, fadeIn])
    let repeatSeq = SKAction.repeatForever(sequence)
    node.run(repeatSeq)
}

