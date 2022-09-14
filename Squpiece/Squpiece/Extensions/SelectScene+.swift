//
//  SelectScene+.swift
//  Squpiece
//
//  Created by 황정현 on 2022/09/14.
//

import SpriteKit
import SwiftUI

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
    
    func pastRecord(scoreNode: SKLabelNode, comboNode: SKLabelNode, frame: CGRect) {
        let formal = frame.maxY * 0.08
        let highScoreValue = dataGet(key: highScoreNameList[numberOfPiece - 2])
        let maxComboValue = dataGet(key: maxComboNameList[numberOfPiece - 2])
        
        let sHS = String(highScoreValue)
        let sMC = String(maxComboValue)
        
        if (sHS.count < 7) {
            scoreNode.fontSize = formal
        } else if (sHS.count == 7) {
            scoreNode.fontSize = formal * 0.8
        } else if (sHS.count == 8) {
            scoreNode.fontSize = formal * 0.75
        } else {
            scoreNode.fontSize = formal * 0.7
        }
        
        
        if (sMC.count < 7) {
            scoreNode.fontSize = formal
        } else if (sMC.count == 7) {
            scoreNode.fontSize = formal * 0.8
        } else if (sMC.count == 8) {
            scoreNode.fontSize = formal * 0.75
        } else {
            scoreNode.fontSize = formal * 0.7
        }
        
        if (highScoreValue == 0) {
            scoreNode.text = "---"
            scoreNode.fontSize = formal
        } else {
            scoreNode.text = String(highScoreValue)
        }
        if (maxComboValue == 0) {
            comboNode.text = "---"
            comboNode.fontSize = formal
        } else {
            comboNode.text = String(maxComboValue)
        }
    }
    
    func changeStageName(node: SKLabelNode, nameList: [String]) {
        let hapticSoundPlay = SKAction.run {
            haptic_ChangeStage()
        }
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let labelChange = SKAction.run {
            node.text = String(nameList[numberOfPiece-2])
        }
        let fadeIn = SKAction.fadeIn(withDuration: 0.1)
        let sequence = SKAction.sequence([hapticSoundPlay, fadeOut, labelChange, fadeIn])
        node.run(sequence)
    }

    func changeStageSprite(index: Int, nodes: [SKSpriteNode]) {
        for i in 0..<nodes.count {
            if(i != index) {
                nodes[i].isHidden =  true
            } else {
                nodes[i].isHidden = false
            }
        }
    }

    func selectPieceRotation (_ node: SKNode) {
        let rotate = SKAction.rotate(byAngle: -rotateAngle, duration: 5)
        let sequence = SKAction.sequence([rotate])
        let action = SKAction.repeatForever(sequence)
        node.run(action, withKey: "SelectPieceRotation")
    }

    func patternPiecePositionSetter(width: CGFloat, patternSprites: [SKShapeNode]) {
        let distance = CGFloat(width * 0.16)
        if numberOfPiece % 2 == 0 {
            var xPoint = -distance * CGFloat(numberOfPiece/2 - 1) - distance * 0.5
            for i in 0..<numberOfPiece {
                patternSprites[i].isHidden = false
                patternSprites[i].position = CGPoint(x: xPoint, y: 0)
                xPoint += distance
            }
        } else {
            var xPoint = -distance * CGFloat(numberOfPiece/2)
            for i in 0..<numberOfPiece {
                patternSprites[i].isHidden = false
                patternSprites[i].position = CGPoint(x: xPoint, y: 0)
                xPoint += distance
            }
        }
        for i in numberOfPiece ..< patternSprites.count {
            patternSprites[i].isHidden = true
        }
    }

    func patternPiecePositionSetterAsCircleType(circleRadius: CGFloat, frame: CGRect, patternSprites: [SKShapeNode]) {
    //    let angleFloat: CGFloat = 21
    //    let radius = circleRadius * 1.3
    //    let angleFloat: CGFloat = 18
    //    let radius = circleRadius * 1.4
    //    let angleFloat: CGFloat = 19
    //    let radius = circleRadius * 1.35
        let angleFloat: CGFloat = 18
        let radius = circleRadius * 1.3
        if numberOfPiece % 2 == 0 {
            let value: CGFloat = CGFloat(numberOfPiece/2 - 1) + 0.5
            let startAngle : CGFloat = -90-(angleFloat * value)
            var radianValue = startAngle.deg2rad()
            for i in 0..<numberOfPiece {
                patternSprites[i].isHidden = false
                patternSprites[i].position = CGPoint(x: radius * cos(radianValue), y: radius * sin(radianValue))
                radianValue += angleFloat.deg2rad()
            }
        }
        else {
            let value: CGFloat = CGFloat(numberOfPiece/2)
            let startAngle : CGFloat = -90-(angleFloat * value)
            var radianValue = startAngle.deg2rad()
            for i in 0..<numberOfPiece {
                patternSprites[i].isHidden = false
                patternSprites[i].position = CGPoint(x: radius * cos(radianValue), y: radius * sin(radianValue))
                radianValue += angleFloat.deg2rad()
            }
        }
        for i in numberOfPiece ..< patternSprites.count {
            patternSprites[i].isHidden = true
        }
    }
    
    func Arc2(radius: CGFloat, angle: CGFloat) -> CGPath {
        var path = Path()
        path.addArc(center: CGPoint(x: 0, y: 0), radius: radius, startAngle: .degrees(270 - angle), endAngle: .degrees(270 + angle), clockwise: false)
        path.closeSubpath()
        return path.cgPath
    }
}
