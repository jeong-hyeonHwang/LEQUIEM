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

    let shadow = SKShapeNode()
    let stageInactiveNoticer = SKLabelNode()
    let background = SKSpriteNode()
    
    var pieceNumberLabel = SKLabelNode()
    var stageNameLabel = SKLabelNode()
    
    var startButton = SKShapeNode()
    var startButtonLabel = SKLabelNode()
    
    var pieces: [SKShapeNode] = [SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode()]
    
    var pieceSprites: [SKSpriteNode] = [SKSpriteNode(imageNamed: "Incar_0.png"), SKSpriteNode(imageNamed: "Incar_1.png"), SKSpriteNode(imageNamed: "Incar_2.png"), SKSpriteNode(imageNamed: "Incar_3.png"), SKSpriteNode(imageNamed: "Incar_4.png")]
    var pieceSpriteLine = SKShapeNode()
    var pieceSpriteLineBackground = SKShapeNode()
   
    var patternSprites: [SKShapeNode] = [SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(),  SKShapeNode()]
    
    let stageNameList: [String] = ["Incarnation", "Tranquility", "Agony", "Enlightenment", "Transcendence"]
   
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
    var circleRadius: CGFloat = 0
    
    //https://stackoverflow.com/questions/52402477/ios-detect-if-the-device-is-iphone-x-family-frameless
    var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    override func didMove(to view: SKView) {
        
        circleRadius = frame.maxX * 0.8
        let labelPosition = hasTopNotch == true ? frame.maxY * 0.25 : frame.maxY * 0.17
        let piecePosition = hasTopNotch == true ? frame.maxY * 0.25 : frame.maxY * 0.23
        let markYPosition = hasTopNotch == true ? frame.minY * 0.17 : frame.minY * 0.2
        let scoreYPosition = hasTopNotch == true ? frame.minY * 0.25 : frame.minY * 0.28
        self.backgroundColor = bgColor
        
        shadow.path = Rect(startPosition: CGPoint(x: frame.minX, y: frame.minY), xSize: frame.width, ySize: frame.height)
        shapeNodeColorSetting(node: shadow, fillColor: UIColor.black, strokeColor: UIColor.black)
        shadow.alpha = 0.5
        shadow.zPosition = 5
        addChild(shadow)
        
        labelSetting(node: stageInactiveNoticer, str: "LOCKED STAGE", align: .center, fontSize: frame.maxY * 0.1, fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: 0, y: 0))
        stageInactiveNoticer.zPosition = 6
        addChild(stageInactiveNoticer)
        
        stageUnlock()
        
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
        labelNodeColor(node: stageNameLabel, color: UIColor.black.withAlphaComponent(0.8))
        addChild(stageNameLabel)

        for i in 0..<pieces.count {
            pieces[i].path = Arc(center: CGPoint(x: frame.midX, y: frame.midY), startAngle: .degrees(90 - pieceAngle/2), endAngle: .degrees(90 + pieceAngle/2), clockwise: false, radius: frame.maxX * 0.2)
            pieces[i].position = CGPoint(x: frame.midX, y:frame.maxY - piecePosition)
            pieces[i].alpha = 0.5
            shapeNodeColorSetting(node: pieces[i], fillColor: UIColor(.parchmentColor), strokeColor: UIColor(.parchmentColor))
            pieces[i].blendMode = .add
            nodelineWidthSetting(node: pieces[i], width: 3)
            addChild(pieces[i])
        }
        pieceRotation(node: pieces, num: numberOfPiece)
        
        for i in 0..<pieceSprites.count {
            pieceSprites[i].position = CGPoint(x: frame.midX, y:frame.midY)
            pieceSprites[i].size = CGSize(width: frame.maxX * 0.8, height: frame.maxX * 0.8)
            pieceSprites[i].zPosition = 0.5
            addChild(pieceSprites[i])
        }
        changeStageSprite(index: numberOfPiece-2, nodes: pieceSprites)
        
        pieceSpriteLine.path = Cir(center: CGPoint(x: frame.midX, y: frame.midY), radius: circleRadius)
        pieceSpriteLine.fillTexture = SKTexture(imageNamed: "PieceSpriteDecoline_.png")
        pieceSpriteLine.zPosition = 0.3
        pieceSpriteLine.blendMode = .add
        shapeNodeColorSetting(node: pieceSpriteLine, fillColor: UIColor.white.withAlphaComponent(0.6), strokeColor: UIColor.clear)
        addChild(pieceSpriteLine)
        
        pieceSpriteLineBackground.path = Cir(center: CGPoint(x: frame.midX, y: frame.midY), radius: circleRadius)
        pieceSpriteLineBackground.zPosition = 0.3
        shapeNodeColorSetting(node: pieceSpriteLineBackground, fillColor: UIColor.clear, strokeColor: UIColor(.selectLineColor))
        pieceSpriteLineBackground.lineWidth = 5
        pieceSpriteLineBackground.zPosition = 0.4
        addChild(pieceSpriteLineBackground)

        
        stageImageLine.path = Cir(center: CGPoint(x: frame.midX, y: frame.midY), radius: circleRadius)
        stageImageLine.fillTexture = SKTexture(imageNamed: "PieceBackground.png")
        shapeNodeColorSetting(node: stageImageLine, fillColor: UIColor.white.withAlphaComponent(0.6), strokeColor: UIColor.clear)
        addChild(stageImageLine)
        
        gameCenterImageLine.path = Cir(center: CGPoint(x: frame.midX, y: frame.midY - frame.maxY * 0.25), radius: circleRadius * 0.18)
        shapeNodeColorSetting(node: gameCenterImageLine, fillColor: centerFontColor.withAlphaComponent(0.25), strokeColor: centerFontColor.withAlphaComponent(0.25))
        gameCenterImageLine.lineWidth = 3
        gameCenterImageLine.zPosition = 2
        //addChild(gameCenterImageLine)
        
        
        for i in 0..<patternSprites.count {
            patternSprites[i].path = Cir(center: CGPoint(x: frame.midX, y: frame.midY), radius: circleRadius * 0.13)
            shapeNodeColorSetting(node: patternSprites[i], fillColor: UIColor(.selectLineColor).withAlphaComponent(0.8), strokeColor: UIColor(.selectLineColor)) 
            patternSprites[i].lineWidth = 2
            patternSprites[i].zPosition = 1
            let tempSize = circleRadius * 0.08
            let temp = SKShapeNode(path: Rect(startPosition: CGPoint(x: frame.midX - tempSize, y: frame.midY - tempSize), xSize: tempSize * 2, ySize: tempSize * 2))
            temp.fillTexture = SKTexture(imageNamed: "\(pieceName[i]).png")
            shapeNodeColorSetting(node: temp, fillColor: UIColor.white, strokeColor: UIColor.clear)
            patternSprites[i].addChild(temp)
            addChild(patternSprites[i])
        }
        patternPiecePositionSetterAsCircleType(circleRadius: circleRadius, frame: frame, patternSprites: patternSprites)

        let underAreaBack = SKShapeNode()
        underAreaBack.path = Arc2(radius: circleRadius, angle: 74)
        shapeNodeColorSetting(node: underAreaBack, fillColor: .black.withAlphaComponent(0.2), strokeColor: UIColor.clear)
        addChild(underAreaBack)
        
        stageImageUnderArea.path = Arc2(radius: circleRadius, angle: 72)
        shapeNodeColorSetting(node: stageImageUnderArea, fillColor: UIColor.white, strokeColor: UIColor.clear)
        let texture = SKTexture(imageNamed: "SelectUnderPattern.png")
        //stageImageUnderArea.blendMode = .add
        stageImageUnderArea.fillTexture = texture
        stageImageUnderArea.lineWidth = 3
        stageImageUnderArea.zPosition = 0
        addChild(stageImageUnderArea)
        
        labelSetting(node: highScoreMark, str: "HIGHSCORE", align: .center, fontSize: frame.maxY * 0.055, fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.minX * 0.55, y: markYPosition))
        labelNodeColor(node: highScoreMark, color: centerFontColor)
        highScoreMark.zPosition = 3
        addChild(highScoreMark)
        labelSetting(node: maxComboMark, str: "MAXCOMBO", align: .center, fontSize: frame.maxY * 0.055, fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.maxX * 0.55, y: markYPosition))
        labelNodeColor(node: maxComboMark, color: centerFontColor)
        maxComboMark.zPosition = 3
        addChild(maxComboMark)
        
        labelSetting(node: highScoreLabel, str: "", align: .center, fontSize: frame.maxY * 0.08, fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.minX * 0.55, y: scoreYPosition))
        labelNodeColor(node: highScoreLabel, color: centerFontColor)
        highScoreLabel.zPosition = 3
        addChild(highScoreLabel)

        labelSetting(node: maxComboLabel, str: "", align: .center, fontSize: frame.maxY * 0.08, fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.maxX * 0.55, y: scoreYPosition))
        labelNodeColor(node: maxComboLabel, color: centerFontColor)
        maxComboLabel.zPosition = 3
        addChild(maxComboLabel)
        
        pastRecord(scoreNode: highScoreLabel, comboNode: maxComboLabel, frame: frame)
        
        let buttonWidth = frame.width * 0.6
        let buttonHeight = frame.height * 0.1
        startButton.path = UIBezierPath(roundedRect: CGRect(x: frame.midX - buttonWidth * 0.5, y: frame.minY + labelPosition - buttonHeight * 0.3, width: buttonWidth, height: buttonHeight), cornerRadius: 10).cgPath
        startButton.strokeColor = UIColor.clear
        startButton.name = "startButton"
        addChild(startButton)
        labelSetting(node: startButtonLabel, str: "START", align: .center, fontSize: CGFloat(frame.maxX * 0.2), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: 0, y: frame.minY + labelPosition))
        labelNodeColor(node: startButtonLabel, color: UIColor.black.withAlphaComponent(0.8))
        nodeNameSetting(node: startButtonLabel, name: "startButton")
        startButton.addChild(startButtonLabel)
        
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
            if(numberOfPiece != pieces.count) {
                numberOfPiece += 1
            } else {
                numberOfPiece = 2
            }
        }
        pieceRotation(node: pieces, num: numberOfPiece)
        changeStageName(node: stageNameLabel, nameList: stageNameList)
        pastRecord(scoreNode: highScoreLabel, comboNode: maxComboLabel, frame: frame)
        changeStageSprite(index: numberOfPiece-2, nodes: pieceSprites)
        patternPiecePositionSetterAsCircleType(circleRadius: self.circleRadius, frame: frame, patternSprites: patternSprites)
    }
    
    func stageUnlock() {
        shadow.isHidden = true
        stageInactiveNoticer.isHidden = true
    }
    
    func stageLock() {
        shadow.isHidden = false
        stageInactiveNoticer.isHidden = false
    }
}

