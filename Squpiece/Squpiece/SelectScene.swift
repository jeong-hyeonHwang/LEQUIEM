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
    
    let fontColor = UIColor(.fontColor)
    let centerFontColor = UIColor(.parchmentColor)
    let centerImageColor = UIColor(.pieceColor)
    
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
        
        let backgroundClipping = SKShapeNode()
        backgroundClipping.path = Rect(startPosition: CGPoint(x: frame.minX, y: frame.minY), xSize: frame.width, ySize: frame.height)
        backgroundClipping.fillColor = UIColor.white.withAlphaComponent(0.2)
        background.zPosition = -1.8
        addChild(backgroundClipping)
        
        labelSetting(node: stageNameLabel, str: String(stageNameList[numberOfPiece-2]), align: .center, fontSize: CGFloat(frame.maxX * 0.2), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: 0, y: frame.maxY - frame.maxY * 0.5))
        stageNameLabel.fontColor = UIColor.black
        labelNodeColor(node: stageNameLabel, color: UIColor.black.withAlphaComponent(0.8))
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
        stageImageLine.fillTexture = SKTexture(imageNamed: "PieceBackground.png")
        shapeNodeColorSetting(node: stageImageLine, fillColor: UIColor.white.withAlphaComponent(0.6), strokeColor: UIColor.clear)
        addChild(stageImageLine)
        
        gameCenterImageLine.path = Cir(center: CGPoint(x: frame.midX, y: frame.midY - frame.maxY * 0.25), radius: circleRadius * 0.18)
        shapeNodeColorSetting(node: gameCenterImageLine, fillColor: centerFontColor.withAlphaComponent(0.25), strokeColor: centerFontColor.withAlphaComponent(0.25))
        gameCenterImageLine.lineWidth = 3
        gameCenterImageLine.zPosition = 2
        //addChild(gameCenterImageLine)
        
        let underAreaBack = SKShapeNode()
        underAreaBack.path = Arc2(radius: circleRadius, angle: 74)
        //shapeNodeColorSetting(node: underAreaBack, fillColor: centerFontColor.withAlphaComponent(0.2), strokeColor: UIColor.clear)
        shapeNodeColorSetting(node: underAreaBack, fillColor: .black.withAlphaComponent(0.2), strokeColor: UIColor.clear)
        addChild(underAreaBack)
        
        stageImageUnderArea.path = Arc2(radius: circleRadius, angle: 72)
        shapeNodeColorSetting(node: stageImageUnderArea, fillColor: centerFontColor, strokeColor: UIColor.clear)
        let texture = SKTexture(imageNamed: "SelectUnderPattern_Half.png")
        stageImageUnderArea.blendMode = .add
        stageImageUnderArea.fillTexture = texture
        stageImageUnderArea.lineWidth = 3
        stageImageUnderArea.zPosition = 0
        addChild(stageImageUnderArea)
        
        labelSetting(node: highScoreMark, str: "HIGHSCORE", align: .center, fontSize: frame.maxY * 0.055, fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.minX * 0.55, y: frame.minY * 0.17))
        labelNodeColor(node: highScoreMark, color: centerFontColor)
        addChild(highScoreMark)
        labelSetting(node: maxComboMark, str: "MAXCOMBO", align: .center, fontSize: frame.maxY * 0.055, fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.maxX * 0.55, y: frame.minY * 0.17))
        labelNodeColor(node: maxComboMark, color: centerFontColor)
        maxComboMark.zPosition = 3
        addChild(maxComboMark)
        
        labelSetting(node: highScoreLabel, str: "", align: .center, fontSize: frame.maxY * 0.08, fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.minX * 0.55, y: frame.minY * 0.25))
        labelNodeColor(node: highScoreLabel, color: centerFontColor)
        highScoreLabel.zPosition = 3
        addChild(highScoreLabel)

        labelSetting(node: maxComboLabel, str: "", align: .center, fontSize: frame.maxY * 0.08, fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.maxX * 0.55, y: frame.minY * 0.25))
        labelNodeColor(node: maxComboLabel, color: centerFontColor)
        maxComboLabel.zPosition = 3
        addChild(maxComboLabel)
        
        pastRecord(scoreNode: highScoreLabel, comboNode: maxComboLabel)
        
        labelSetting(node: startButtonLabel, str: "START", align: .center, fontSize: CGFloat(frame.maxX * 0.2), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: 0, y: frame.minY + labelPosition))
        labelNodeColor(node: startButtonLabel, color: UIColor.black.withAlphaComponent(0.8))
        highScoreLabel.zPosition = 3
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

