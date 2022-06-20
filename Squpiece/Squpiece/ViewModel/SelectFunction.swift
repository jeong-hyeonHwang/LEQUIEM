//
//  SelectFunction.swift
//  Squpiece
//
//  Created by 황정현 on 2022/06/05.
//

import SpriteKit
import SwiftUI

func pieceRotation(node: [SKShapeNode], num: Int) {
    //let rotateAngle = CGFloat(360/pieceNum)
    let rotateAngle = CGFloat(Double(2) * CGFloat.pi / Double(num))
    var currentAngle: CGFloat = 0
    for i in 0..<num {
        node[i].isHidden = false
        //node[i].angle
        node[i].zRotation = currentAngle
        currentAngle += rotateAngle
    }
    for i in num..<node.count {
        node[i].isHidden = true
    }
}

func changeStageName(node: SKLabelNode, nameList: [String]) {
    let fadeOut = SKAction.fadeOut(withDuration: 0.1)
    let labelChange = SKAction.run {
        node.text = String(nameList[numberOfPiece-2])
    }
    let fadeIn = SKAction.fadeIn(withDuration: 0.1)
    let sequence = SKAction.sequence([fadeOut, labelChange, fadeIn])
    node.run(sequence)
}

func pastRecord(scoreNode: SKLabelNode, comboNode: SKLabelNode) {
    let highScoreValue = dataGet(key: highScoreNameList[numberOfPiece - 2])
    let maxComboValue = dataGet(key: maxComboNameList[numberOfPiece - 2])
    scoreNode.text = String(highScoreValue)
    comboNode.text = String(maxComboValue)
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
    let angleFloat: CGFloat = 21
    let radius = circleRadius * 1.3
    if numberOfPiece % 2 == 0 {
        let value: CGFloat = CGFloat(numberOfPiece/2 - 1) + 0.5
        let startAngle : CGFloat = -90-(angleFloat * value)
        var radianValue = deg2rad(startAngle)
        for i in 0..<numberOfPiece {
            patternSprites[i].isHidden = false
            patternSprites[i].position = CGPoint(x: radius * cos(radianValue), y: radius * sin(radianValue))
            radianValue += deg2rad(angleFloat)
        }
    }
    else {
        let value: CGFloat = CGFloat(numberOfPiece/2)
        let startAngle : CGFloat = -90-(angleFloat * value)
        var radianValue = deg2rad(startAngle)
        for i in 0..<numberOfPiece {
            patternSprites[i].isHidden = false
            patternSprites[i].position = CGPoint(x: radius * cos(radianValue), y: radius * sin(radianValue))
            radianValue += deg2rad(angleFloat)
        }
    }
    for i in numberOfPiece ..< patternSprites.count {
        patternSprites[i].isHidden = true
    }
}

