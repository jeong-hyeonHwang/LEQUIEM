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
    
    var pieceNumberLabel = SKLabelNode()
    var stageNameLabel = SKLabelNode()
    var startButtonLabel = SKLabelNode()
    
    var pieces: [SKShapeNode] = [SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode()]
   
    let stageNameList: [String] = ["Incarnation", "Agony", "Enlightenment", "Fallen", "Transcendence"]
   
    let stageImageLine = SKShapeNode()
    let stageImageUnderArea = SKShapeNode()
    let highScoreMark = SKLabelNode()
    let maxComboMark = SKLabelNode()
    var highScoreLabel = SKLabelNode()
    var maxComboLabel = SKLabelNode()
    let gameCenterImageLine = SKShapeNode()
    
    let pieceAngle: Double = 30
    override func didMove(to view: SKView) {
        
        let circleRadius = frame.maxX * 0.8
        let labelPosition = frame.maxY * 0.25
        self.backgroundColor = bgColor
        
        let img = UIImage(named: "background.jpg")!
        let data_ = img.pngData()
        let newImage_ = UIImage(data:data_!)
        background.texture = SKTexture(image: newImage_!)
        background.size = CGSize(width: frame.width, height: frame.height)
        background.zPosition = -1.5
        background.alpha = 0.8
        addChild(background)
        
        labelSetting(node: stageNameLabel, str: String(stageNameList[numberOfPiece-2]), align: .center, fontSize: CGFloat(frame.maxX * 0.2), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: 0, y: frame.maxY - frame.maxY * 0.5))
        stageNameLabel.fontColor = UIColor.black
        labelNodeColor(node: stageNameLabel, color: UIColor.black)
        addChild(stageNameLabel)
        
//        labelSetting(node: pieceNumberLabel, str: "2", align: .center, fontSize: CGFloat(frame.maxX * 0.3), fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.midX, y:frame.maxY - frame.maxY * 0.3))
//        pieceNumberLabel.zPosition = 1
//        pieceNumberLabel.fontColor = UIColor.black
//        addChild(pieceNumberLabel)
        
        for i in 0..<pieces.count {
            pieces[i].path = Arc(center: CGPoint(x: frame.midX, y: frame.midY), startAngle: .degrees(90 - pieceAngle/2), endAngle: .degrees(90 + pieceAngle/2), clockwise: false, radius: frame.maxX * 0.2)
            pieces[i].position = CGPoint(x: frame.midX, y:frame.maxY - labelPosition)
            pieces[i].alpha = 0.5
            shapeNodeColorSetting(node: pieces[i], fillColor: UIColor(.parchmentColor), strokeColor: UIColor(.parchmentColor))
            nodelineWidthSetting(node: pieces[i], width: 3)
            addChild(pieces[i])
        }
        pieceRotation(node: pieces)
        
        stageImageLine.path = Cir(center: CGPoint(x: frame.midX, y: frame.midY), radius: circleRadius)
        shapeNodeColorSetting(node: stageImageLine, fillColor: UIColor.clear, strokeColor: UIColor(.parchmentColor))
        stageImageLine.lineWidth = 3
        addChild(stageImageLine)
        
        gameCenterImageLine.path = Cir(center: CGPoint(x: frame.midX, y: frame.midY - frame.maxY * 0.25), radius: circleRadius * 0.18)
        gameCenterImageLine.strokeColor = UIColor(.parchmentColor)
        gameCenterImageLine.lineWidth = 3
        addChild(gameCenterImageLine)
        
        stageImageUnderArea.path = Arc2(radius: circleRadius, angle: 72)
        shapeNodeColorSetting(node: stageImageUnderArea, fillColor: UIColor(.parchmentColor).withAlphaComponent(0.4), strokeColor: UIColor(.parchmentColor))
        stageImageUnderArea.lineWidth = 3
        stageImageUnderArea.zPosition = -1
        addChild(stageImageUnderArea)
        
        labelSetting(node: highScoreMark, str: "HIGHSCORE", align: .center, fontSize: frame.maxY * 0.05, fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.minX * 0.55, y: frame.minY * 0.18))
        addChild(highScoreMark)
        labelSetting(node: maxComboMark, str: "MAXCOMBO", align: .center, fontSize: frame.maxY * 0.05, fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.maxX * 0.55, y: frame.minY * 0.18))
        addChild(maxComboMark)
        
        labelSetting(node: highScoreLabel, str: "", align: .center, fontSize: frame.maxY * 0.08, fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.minX * 0.55, y: frame.minY * 0.25))
        labelNodeColor(node: highScoreLabel, color: UIColor(.parchmentColor))
        addChild(highScoreLabel)

        labelSetting(node: maxComboLabel, str: "", align: .center, fontSize: frame.maxY * 0.08, fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.maxX * 0.55, y: frame.minY * 0.25))
        labelNodeColor(node: maxComboLabel, color: UIColor(.parchmentColor))
        addChild(maxComboLabel)
        
        pastRecord(scoreNode: highScoreLabel, comboNode: maxComboLabel)
        
        labelSetting(node: startButtonLabel, str: "START", align: .center, fontSize: CGFloat(frame.maxX * 0.2), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: 0, y: frame.minY + labelPosition))
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
        pastRecord(scoreNode: highScoreLabel, comboNode: maxComboLabel)
    }
}

