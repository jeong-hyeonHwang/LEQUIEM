//
//  SelectScene.swift
//  Squpiece
//
//  Created by 황정현 on 2022/06/05.
//

import GameKit
import SpriteKit


final class SelectScene: SKScene {

    private let shadow = SKShapeNode()
    private let stageInactiveNoticer = SKLabelNode()
    private let background = SKSpriteNode()
    
    private var stageNameLabel = SKLabelNode()
    
    private var startButton = SKShapeNode()
    private var startButtonLabel = SKLabelNode()
    
    private var pieces: [SKShapeNode] = [SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode()]
    
    private var pieceSprites: [SKSpriteNode] = [SKSpriteNode(imageNamed: "Incar_0.png"), SKSpriteNode(imageNamed: "Incar_1.png"), SKSpriteNode(imageNamed: "Incar_2.png"), SKSpriteNode(imageNamed: "Incar_3.png"), SKSpriteNode(imageNamed: "Incar_4.png")]
    private var pieceSpriteLine = SKShapeNode()
    private var pieceSpriteLineBackground = SKShapeNode()
   
    private var patternSprites: [SKShapeNode] = [SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(),  SKShapeNode()]
    
    private let stageNameList: [String] = ["Incarnation", "Tranquility", "Agony", "Enlightenment", "Transcendence"]
   
    private let stageImageLine = SKShapeNode()
    private let stageImageUnderArea = SKShapeNode()
    private let highScoreMark = SKLabelNode()
    private let maxComboMark = SKLabelNode()
    private var highScoreLabel = SKLabelNode()
    private var maxComboLabel = SKLabelNode()
    private let gameCenterImageLine = SKShapeNode()
    
    private let pieceAngle: Double = 30
    
    private let fontColor = UIColor(.fontColor)
    private let centerFontColor = UIColor(.parchmentColor)
    private let centerImageColor = UIColor(.pieceColor)
    private var circleRadius: CGFloat = 0
    
    private var backgroundMusic = SKAudioNode(fileNamed: "Dream.mp3")
    private var startButtonPressed = false
    
    // MARK: Setting Panel Components
    private let settingButton = SKSpriteNode()
    private let closeButton = SKSpriteNode()
    private let bgmBoolButton = SKShapeNode()
    private let sfxBoolButton = SKShapeNode()
    private let bgmLabel = SKLabelNode()
    private let bgmBoolLabel = SKLabelNode()
    private let sfxLabel = SKLabelNode()
    private let sfxBoolLabel = SKLabelNode()
    
    private let gameCenterTrigger = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        GKAccessPoint.shared.isActive = false
        
        circleRadius = frame.maxX * 0.8
        let labelPosition = hasTopNotch == true ? frame.maxY * 0.25 : frame.maxY * 0.17
        let piecePosition = hasTopNotch == true ? frame.maxY * 0.25 : frame.maxY * 0.23
        let markYPosition = hasTopNotch == true ? frame.minY * 0.17 : frame.minY * 0.2
        let scoreYPosition = hasTopNotch == true ? frame.minY * 0.25 : frame.minY * 0.28
        self.backgroundColor = bgColor
        
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
        labelNodeColor(node: stageNameLabel, color:
                        UIColor(.parchmentColor))
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
        labelNodeColor(node: startButtonLabel, color:
                        UIColor(.parchmentColor))
        nodeNameSetting(node: startButtonLabel, name: "startButton")
        startButton.addChild(startButtonLabel)
        
        setSettingButton(settingButton: settingButton, frame: frame)
        addChild(settingButton)
        
        let config = UIImage.SymbolConfiguration(pointSize: 10, weight: .semibold, scale: .default)
        let image = UIImage(systemName: "xmark", withConfiguration: config)!.withTintColor(UIColor(.parchmentColor))
        let data = image.pngData()
        let rImage = UIImage(data:data!)
        closeButton.texture = SKTexture(image: rImage!)
        nodeNameSetting(node: closeButton, name: "closeButton")
        closeButton.size = rImage?.size ?? CGSize(width: 10, height: 10)
        closeButton.position = CGPoint(x: frame.maxX - frame.maxX * 0.16, y: hasTopNotch == true ? frame.maxY - frame.maxX * 0.35 : frame.maxY - frame.maxX * 0.24)
        closeButton.zPosition = 6
        shadow.addChild(closeButton)
        
        // Setting: Shadow
        shadow.path = Rect(startPosition: CGPoint(x: frame.minX, y: frame.minY), xSize: frame.width, ySize: frame.height)
        shapeNodeColorSetting(node: shadow, fillColor: UIColor(.shadowColor.opacity(0.8)), strokeColor: UIColor(.shadowColor.opacity(0.8)))
        shadow.name = "shadow"
        shadow.zPosition = 5.5
        addChild(shadow)
        
        setSoundButton(bgmBoolButton: bgmBoolButton, sfxBoolButton: sfxBoolButton, circleRadius: circleRadius)
        setSoundLabel(bgmLabel: bgmLabel, sfxLabel: sfxLabel, circleRadius: circleRadius, frame: frame)
        setSoundBoolLabel(bgmBoolLabel: bgmBoolLabel, sfxBoolLabel: sfxBoolLabel, circleRadius: circleRadius, frame: frame)
        
        shadow.addChild(bgmBoolButton)
        shadow.addChild(sfxBoolButton)
        shadow.addChild(bgmLabel)
        shadow.addChild(sfxLabel)
        shadow.addChild(bgmBoolLabel)
        shadow.addChild(sfxBoolLabel)
        
        CustomizeHaptic.instance.prepareHaptics()
        
        //https://stackoverflow.com/questions/36380327/addchild-after-2-seconds
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run({
                self.addChild(self.backgroundMusic)
        })]))
        soundVolumeOn(node: backgroundMusic, status: bgmBool)
        gameCenterTriggerSetting(node: gameCenterTrigger, frame: frame)
        addChild(gameCenterTrigger)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(startButtonPressed == true) { return }
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if (touchedNode.name == "GameCenterTrigger") {

                //https://stackoverflow.com/questions/21827783/how-to-reference-the-current-viewcontroller-from-a-sprite-kit-scene
                GameKitHelper.sharedInstance.showSpecificLeaderBoard(lbName: leaderBoardName[numberOfPiece-2], view: self.view!.window!.rootViewController as! GameViewController, scene: self)
                return
            } else if (touchedNode.name == "startButton") {
                startButtonPressed = true
                backgroundMusic.run(SKAction.changeVolume(to: 0, duration: 0))
                sfxPlay(soundFileName: "SFX_GoToGameScene", scene: self)
                haptic_GoGameScene()
                            self.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run({
                    if let scene = SKScene(fileNamed: "GameScene") {
                        let fade = SKTransition.fade(withDuration: 1)
                        for node in self.children {
                            node.removeAllActions()
                            node.removeAllChildren()
                        }
                        // Present the scene
                        self.view?.presentScene(scene, transition: fade)
                    }
                })]))
                return
            } else if (touchedNode.name == "settingButton") {
                settingPanelDisactive(shadow: shadow, status: false)
                return
            } else if (touchedNode.name == "closeButton") {
                settingPanelDisactive(shadow: shadow, status: true)
                return
            } else if (shadow.isHidden == false) {
                if (touchedNode.name == "bgmBoolButton" && bgmBoolButton.contains(location)) {
                    bgmBool = !bgmBool
                    dataSetB(value: bgmBool, key: "bgmBool")
                    soundVolumeOn(node: backgroundMusic, status: bgmBool)
                    boolButtonStatusChangeTo(node: bgmBoolLabel, status: bgmBool)
                } else if (touchedNode.name == "sfxBoolButton" && sfxBoolButton.contains(location)) {
                    sfxBool = !sfxBool
                    dataSetB(value: sfxBool, key: "sfxBool")
                    boolButtonStatusChangeTo(node: sfxBoolLabel, status: sfxBool)
                }
                return
            }
        }
        
        sfxPlay(soundFileName: "SFX_StageChange", scene: self)
        
        if(numberOfPiece != pieces.count) {
            numberOfPiece += 1
        } else {
            numberOfPiece = 2
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

