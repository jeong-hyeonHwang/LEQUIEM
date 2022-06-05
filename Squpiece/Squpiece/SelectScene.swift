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

    let background = SKSpriteNode()
    
    var stageNameLabel = SKLabelNode()
    var startButtonLabel = SKLabelNode()
    
    var pieces: [SKShapeNode] = [SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode()]
   
    let stageNameList: [String] = ["Incarnation", "Agony", "Enlightenment", "Fallen", "Transcendence"]
    
    let pieceAngle: Double = 30
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = bgColor
        
        let img = UIImage(named: "background.jpg")!
        let data_ = img.pngData()
        let newImage_ = UIImage(data:data_!)
        background.texture = SKTexture(image: newImage_!)
        background.size = CGSize(width: frame.width, height: frame.height)
        background.zPosition = -1.5
        background.alpha = 0.8
        addChild(background)
        
        labelSetting(node: stageNameLabel, str: String(stageNameList[numberOfPiece-2]), align: .center, fontSize: CGFloat(frame.maxX * 0.2), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: 0, y: frame.maxY - frame.maxY * 0.35))
        stageNameLabel.fontColor = UIColor.black
        labelNodeColor(node: stageNameLabel, color: UIColor.black)
        addChild(stageNameLabel)
        for i in 0..<pieces.count {
            pieces[i].path = Arc(center: CGPoint(x: frame.midX, y: frame.midY), startAngle: .degrees(90 - pieceAngle/2), endAngle: .degrees(90 + pieceAngle/2), clockwise: false, radius: frame.maxX * 0.8)
            pieces[i].position = CGPoint(x: frame.midX, y:frame.midY)
            shapeNodeColorSetting(node: pieces[i], fillColor: UIColor(.parchmentColor), strokeColor: UIColor(.parchmentColor))
            nodelineWidthSetting(node: pieces[i], width: 3)
            addChild(pieces[i])
        }
        pieceRotation(node: pieces)
        
        labelSetting(node: startButtonLabel, str: "START", align: .center, fontSize: CGFloat(frame.maxX * 0.2), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: 0, y: frame.minY + frame.maxY * 0.25))
        startButtonLabel.fontColor = UIColor.black
        labelNodeColor(node: startButtonLabel, color: UIColor.black)
        nodeNameSetting(node: startButtonLabel, name: "startButton")
        addChild(startButtonLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if (touchedNode.name == "startButton") {
                if let scene = SKScene(fileNamed: "GameScene") {
                    let fade = SKTransition.fade(withDuration: 1)
                    for node in children {
                        node.removeAllActions()
                        node.removeAllChildren()
                    }
                    // Present the scene
                    self.view?.presentScene(scene, transition: fade)
                }
                return
            }
        }
        if(numberOfPiece != pieces.count) {
            numberOfPiece += 1
        } else {
            numberOfPiece = 2
        }
        pieceRotation(node: pieces)
        changeStageName(node: stageNameLabel, nameList: stageNameList)
    }
}

