//
//  SelectScene.swift
//  Squpiece
//
//  Created by 황정현 on 2022/06/05.
//

import SpriteKit
import GameplayKit
import AVFoundation

class SelectScene: SKScene {

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
    var pieces: [SKShapeNode] = [SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode()]
    let pieceAngle: Double = 30
    override func didMove(to view: SKView) {
        for i in 0..<pieces.count {
            pieces[i].path = Arc(center: CGPoint(x: frame.midX, y: frame.midY), startAngle: .degrees(90 - pieceAngle/2), endAngle: .degrees(90 + pieceAngle/2), clockwise: false, radius: frame.maxX * 0.8)
            pieces[i].position = CGPoint(x: frame.midX, y:frame.midY)
            shapeNodeColorSetting(node: pieces[i], fillColor: UIColor.blue, strokeColor: UIColor(.parchmentColor))
            nodelineWidthSetting(node: pieces[i], width: 3)
            addChild(pieces[i])
        }
        pieceRotation(node: pieces)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(numberOfPiece != pieces.count) {
            numberOfPiece += 1
        } else {
            numberOfPiece = 2
        }
        pieceRotation(node: pieces)
    }
}

