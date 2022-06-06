//
//  TestScene.swift
//  Squpiece
//
//  Created by 황정현 on 2022/06/06.
//

import SwiftUI
import SpriteKit
import CoreGraphics

extension CGPath {
    static func arcWithWidth(center: CGPoint, start:CGFloat, end:CGFloat, radius:CGFloat, clockwise:Bool) -> UIBezierPath {
        // The radius parameter specifies the middle of the arc; adjust this as needed

        // Note the arc is upside down because CGPath uses UIKit coordinates
        let path = UIBezierPath()
        // Add inner ring.
        path.addArc(withCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        path.addLine(to: center)
        path.close()

        return path
    }
}

class TestScene: SKScene {
    override func didMove(to view: SKView) {
        let angle: CGFloat = CGFloat(120)
        // Setting: Piece & Piece Sprite
//        piece.path = Arc(center: CGPoint(x: frame.midX, y: frame.midY), startAngle: .degrees(90-angle), endAngle: .degrees(90+angle), clockwise: true, radius: frame.maxX * 0.8)
//        piece.position = CGPoint(x: frame.midX, y:frame.midY)
//        shapeNodeColorSetting(node: piece, fillColor: UIColor.clear, strokeColor: UIColor(.parchmentColor))
//        nodelineWidthSetting(node: piece, width: 3)
//        piece.physicsBody = SKPhysicsBody(polygonFrom: piece.path!)
//        piece.physicsBody!.affectedByGravity = false
        
        let center = CGPoint(x: frame.midX, y: frame.midY)
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = Double.pi / 4
        let radius = frame.maxX * 0.8
        let testPath = UIBezierPath()
        //testPath.addLine(to:center)
        //testPath.addLine(to:CGPoint(x: radius, y: 0))
        testPath.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        testPath.addLine(to: center)
        testPath.close()
        let path = CGPath.arcWithWidth(center: center, start: startAngle, end: endAngle, radius: radius, clockwise: false)
//        piece.path = testPath.cgPath
        let piece : SKShapeNode = SKShapeNode(path: path.cgPath)
        piece.position = CGPoint(x:0, y:250)
        piece.zPosition = 5
        piece.lineWidth = 5
        piece.strokeColor = (UIColor.black)
        piece.physicsBody = SKPhysicsBody(polygonFrom: path.cgPath
        )
        piece.physicsBody?.affectedByGravity = false
        piece.name = "test"
        addChild(piece)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if(touchedNode.name == "test") {
                print("HIII")
            }
        }
    }
}
