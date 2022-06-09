//
//  SelectFunction.swift
//  Squpiece
//
//  Created by 황정현 on 2022/06/05.
//

import SpriteKit

func pieceRotation(node: [SKShapeNode]) {
    //let rotateAngle = CGFloat(360/pieceNum)
    let rotateAngle = CGFloat(Double(2) * CGFloat.pi / Double(numberOfPiece))
    var currentAngle: CGFloat = 0
    for i in 0..<numberOfPiece {
        node[i].isHidden = false
        //node[i].angle
        node[i].zRotation = currentAngle
        currentAngle += rotateAngle
    }
    for i in numberOfPiece..<node.count {
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

