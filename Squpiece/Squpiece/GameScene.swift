//
//  GameScene.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/28.
//

import GameKit
import SpriteKit

final class GameScene: SKScene {
    
    // Presetting Values
    private var circleRadius: CGFloat = 1
    private let pieces : [SKShapeNode] = [SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode()]
    private let pieceSprite : [SKSpriteNode] = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
    private let pieceColor = UIColor(.pieceColor)
    private let timerStrokeColor = UIColor(.pieceColor)
    private var lastIndex : Int = numberOfPiece - 1
    
    private var returnButtonBackground = SKShapeNode()
    private var restartButtonBackground = SKShapeNode()
    
    // Current Object Information
    private var currentIndex: Int = 0
    
    // Past Value
    private var highScoreValue: Int = 0
    private var maxComboValue: Int = 0
    
    // Current Value
    private var scoreValue: Int = 0
    private var comboValue: Int = 0
    
    // Scene Cover
    private var shadow = SKShapeNode()
    
    // Past Information
    private var highScoreLabel = SKLabelNode()
    private var maxComboLabel = SKLabelNode()
    
    // Current Information
    private var scoreLabel = SKLabelNode()
    private var comboLabel = SKLabelNode()
    private let currentPiece = SKShapeNode()
    private var currentPieceSprite = SKSpriteNode()
    
    // Place Holder
    private var scoreMark = SKLabelNode()
    private var highScoreMark = SKLabelNode()
    private var maxComboMark = SKLabelNode()
    
    // About Time
    private var circleTimer = SKShapeNode()
    private var timerRadius : CGFloat = 5
    
    // InGame Button
    private let rotationStopButton = SKShapeNode()
    private let randomStopButton = SKShapeNode()
    
    private let pieceBackground = SKShapeNode()
    
    // OutGame Button
    //let restartButton = SKSpriteNode()
    private let restartButton = SKLabelNode()
    //let returnHomeButton = SKSpriteNode()
    private let returnHomeButton = SKLabelNode()
    
    private let fontColor = UIColor(.fontColor)
    
    private let patternColor = UIColor(.fontColor)
    private let centerPatternColor = UIColor(.pieceColor)
    private let timerBackgroundColor = UIColor(.timerColor)
    
    private let background = SKSpriteNode()
    private let zen = SKSpriteNode()
    
    private var touchCount: Int = 0
    private var nodeOpen: Bool = false

    private var stageEnd: Bool = false
    private var firstCall: Date?
    
    private var buttonPressed = false
    
    private var backgroundMusic = SKAudioNode(fileNamed: "Cradle.mp3")
    
    override func didMove(to view: SKView) {
        GKAccessPoint.shared.isActive = false
        
        firstCall = Date()
        circleRadius = frame.maxX * 0.8
        timerRadius = circleRadius * 2.3
        
        resetVar()
        self.backgroundColor = bgColor

        //Setting: High Score Label
        highScoreValue = dataGet(key: highScoreNameList[numberOfPiece - 2])
        labelSetting(node: highScoreLabel, str: String(highScoreValue), align: .left, fontSize: CGFloat(frame.maxY * 0.06), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: frame.minX + frame.maxY * 0.05, y:frame.maxY - frame.maxY * 0.21))
        highScoreLabel.fontColor = UIColor.black
        labelNodeColor(node: highScoreLabel, color: fontColor)
        addChild(highScoreLabel)

        // Setting: Max Combo Label
        maxComboValue = dataGet(key: maxComboNameList[numberOfPiece - 2])
        labelSetting(node: maxComboLabel, str: String(maxComboValue), align: .right, fontSize: CGFloat(frame.maxY * 0.06), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: frame.maxX - frame.maxY * 0.05, y:frame.maxY - frame.maxY * 0.21))
        labelNodeColor(node: maxComboLabel, color: fontColor)
        addChild(maxComboLabel)

        // Setting: High Score Mark
        labelSetting(node: highScoreMark, str: String("HIGHSCORE"), align: .left, fontSize:  CGFloat(frame.maxY * 0.03), fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.minX + frame.maxY * 0.05, y:frame.maxY - frame.maxY * 0.15))
        labelNodeColor(node: highScoreMark, color: fontColor)
        addChild(highScoreMark)

        // Setting: Max Combo Mark
        labelSetting(node: maxComboMark, str: String("MAX COMBO"), align: .right, fontSize: CGFloat(frame.maxY * 0.03), fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.maxX - frame.maxY * 0.05, y:frame.maxY - frame.maxY * 0.15))
        labelNodeColor(node: maxComboMark, color: fontColor)
        addChild(maxComboMark)

        // Setting: Score Mark
        labelSetting(node: scoreMark, str: String("SCORE"), align: .center, fontSize: CGFloat(frame.maxY * 0.06), fontName: "AppleSDGothicNeo-Regular", pos: CGPoint(x:0, y:frame.maxY - frame.maxY * 0.28))
        labelNodeColor(node: scoreMark, color: fontColor)
        addChild(scoreMark)

        // Setting: Score Label
        labelSetting(node: scoreLabel, str: String(scoreValue), align: .center, fontSize: CGFloat(frame.maxY * 0.14), fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x:0, y:frame.maxY - frame.maxY * 0.4))
        labelNodeColor(node: scoreLabel, color: fontColor)
        addChild(scoreLabel)

        // Setting: Combo Label
        labelSetting(node: comboLabel, str: "", align: .center, fontSize: CGFloat(frame.maxY * 0.1), fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x:0, y:frame.maxY - frame.maxY * 0.5))
        labelNodeColor(node: comboLabel, color: fontColor)
        addChild(comboLabel)

        // Setting: Circle Timer
        circleTimer.path = Cir(center: CGPoint(x: frame.midX, y: frame.midY), radius: timerRadius)
        shapeNodeColorSetting(node: circleTimer, fillColor: UIColor(.timerColor), strokeColor: UIColor(.timerColor))
        shapeNodeColorSetting(node: circleTimer, fillColor: timerBackgroundColor, strokeColor: timerBackgroundColor)
        circleTimer.zPosition = -1.8
        addChild(circleTimer)

        let img = UIImage(named: "background.jpg")!
        let data_ = img.pngData()
        let newImage_ = UIImage(data:data_!)
        background.texture = SKTexture(image: newImage_!)
        background.size = CGSize(width: frame.width, height: frame.height)
        background.zPosition = -1.5
        background.alpha = 0.5
        addChild(background)

        let img2 = UIImage(named: "zen___.png")!
        let data2 = img2.pngData()
        let newImage2 = UIImage(data:data2!)
        zen.texture = SKTexture(image: newImage2!)
        zen.size = CGSize(width: frame.width, height: frame.height)
        zen.zPosition = -1
        addChild(zen)

        pieceBackground.path = Cir(center: CGPoint(x: frame.midX, y: frame.midY), radius: circleRadius)
        pieceBackground.fillTexture = SKTexture(imageNamed: "PieceBackground.png")
        pieceBackground.fillColor = .white
        pieceBackground.alpha = 0.8
        addChild(pieceBackground)

        let angle = CGFloat(180/(self.lastIndex+1))
        let sAngle: CGFloat = 90 - angle
        let eAngle: CGFloat = 90 + angle
//        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 13.5, weight: .semibold, scale: .default)
//        let currentSymbolConfig = UIImage.SymbolConfiguration(pointSize: 13.2, weight: .semibold, scale: .default)
        for i in 0...lastIndex {
            //https://developer.apple.com/documentation/spritekit/sknode/getting_started_with_physics_bodies
            pieces[i].path = Donut(center: CGPoint(x: frame.midX, y: frame.midY), startAngle: sAngle , endAngle: eAngle, clockwise: false, radius: circleRadius, width: circleRadius - frame.width * 0.1)
            shapeNodeColorSetting(node: pieces[i], fillColor: UIColor.clear, strokeColor: UIColor(.parchmentColor))
            nodelineWidthSetting(node: pieces[i], width: 3)
            addChild(pieces[i])

            pieceSprite[i].texture = SKTexture(imageNamed: "\(pieceName[i]).png")
            pieceSprite[i].size = CGSize(width: frame.maxX * 0.25, height: frame.maxX * 0.25)
            pieceSprite[i].position = CGPoint(x: 0, y: circleRadius * 0.65)
            pieces[i].addChild(pieceSprite[i])
            pieceRotation(node: pieces[i], index: i)
            rotateAction([pieces[i]])
        }
        
        // Setting: Current Piece
        currentPiece.path = Cir(center: CGPoint(x: frame.midX, y: frame.midY), radius: frame.width * 0.1)
        shapeNodeColorSetting(node: currentPiece, fillColor: UIColor(.parchmentColor), strokeColor: UIColor(.parchmentColor))
        nodelineWidthSetting(node: currentPiece, width: 5)
        nodeNameSetting(node: currentPiece, name: "CurrentPiece")
        addChild(currentPiece)

        // Setting: Current Piece Sprite
        currentPieceSprite.texture = SKTexture(imageNamed: "\(pieceName[0]).png")
        nodeNameSetting(node: currentPieceSprite, name: "Xp_\(pieceName[currentIndex])")
        currentPieceSprite.size = CGSize(width: frame.maxX * 0.18, height: frame.maxX * 0.18)
        nodeNameSetting(node: currentPieceSprite, name: "CurrentPiece")
        addChild(currentPieceSprite)

        // Setting: Rotation Stop Button
        rotationStopButton.path = Cir(center: CGPoint(x: frame.midX - frame.maxX * 0.75, y: frame.minY + frame.maxY * 0.35), radius: frame.width * 0.08)
        shapeNodeColorSetting(node: rotationStopButton, fillColor: UIColor.black, strokeColor: UIColor.black)
        nodelineWidthSetting(node: rotationStopButton, width: 5)
        nodeNameSetting(node: rotationStopButton, name: "XX_RotationSB")
        //addChild(rotationStopButton)

        // Setting: Random Stop Button
        randomStopButton.path = Cir(center: CGPoint(x: frame.midX + frame.maxX * 0.75, y: frame.minY + frame.maxY * 0.35), radius: frame.width * 0.08)
        shapeNodeColorSetting(node: randomStopButton, fillColor: UIColor.white, strokeColor: UIColor.white)
        nodelineWidthSetting(node: randomStopButton, width: 5)
        nodeNameSetting(node: randomStopButton, name: "XX_RandomSB")
        //addChild(randomStopButton)

        // Setting: Shadow
        shadow.path = Rect(startPosition: CGPoint(x: frame.minX, y: frame.minY), xSize: frame.width, ySize: frame.height)
        shapeNodeColorSetting(node: shadow, fillColor: UIColor(.shadowColor.opacity(0.8)), strokeColor: UIColor(.shadowColor.opacity(0.8)))
        shadow.name = "shadow"
        shadow.zPosition = 0
        addChild(shadow)

        
        restartButtonBackground.path = Arc(center: CGPoint(x: 0, y: 0), startAngle: .degrees(0), endAngle: .degrees(-180), clockwise: true, radius: circleRadius)
        restartButtonBackground.zPosition = 1
        restartButtonBackground.fillTexture = SKTexture(imageNamed: "PieceBackground.png")
        restartButtonBackground.fillColor = .white
        restartButtonBackground.strokeColor = UIColor(.parchmentColor)
        nodelineWidthSetting(node: restartButtonBackground, width: 3)
        nodeNameSetting(node: restartButtonBackground, name: "restartButton")
        addChild(restartButtonBackground)
        
        returnButtonBackground.path = Arc(center: CGPoint(x: 0, y: 0), startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false, radius: circleRadius)
        returnButtonBackground.zPosition = 1
        returnButtonBackground.fillTexture = SKTexture(imageNamed: "PieceBackground.png")
        returnButtonBackground.fillColor = .white
        returnButtonBackground.strokeColor = UIColor(.parchmentColor)
        nodelineWidthSetting(node: returnButtonBackground, width: 3)
        nodeNameSetting(node: returnButtonBackground, name: "returnHomeButton")
        addChild(returnButtonBackground)
        
        //Restart Button : VER.LABEL
        labelSetting(node: restartButton, str: "RESTART", align: .center, fontSize: CGFloat(frame.maxX * 0.15), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: frame.midX, y: -circleRadius * 0.45))
        restartButton.verticalAlignmentMode = .center
        labelNodeColor(node: restartButton, color: UIColor.white)
        nodeNameSetting(node: restartButton, name: "restartButton")
        restartButton.zPosition = 2
        addChild(restartButton)
        
        //Return Button : VER.LABEL
        labelSetting(node: returnHomeButton, str: "HOME", align: .center, fontSize: CGFloat(frame.maxX * 0.15), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: frame.midX, y: frame.midY+circleRadius * 0.45))
        returnHomeButton.verticalAlignmentMode = .center
        labelNodeColor(node: returnHomeButton, color: UIColor.white)
        nodeNameSetting(node: returnHomeButton, name: "returnHomeButton")
        returnHomeButton.zPosition = 2
        addChild(returnHomeButton)

        
        shadowDisappear(node: shadow, labels: [self.scoreMark, self.scoreLabel, self.highScoreLabel, self.comboLabel, self.maxComboLabel, self.highScoreMark, self.maxComboMark])
        timerAnimation(node: self.circleTimer, shadow: self.shadow)
        endGameButtonDisable()
        
        CustomizeHaptic.instance.prepareHaptics()
        
        //https://stackoverflow.com/questions/36380327/addchild-after-2-seconds
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run({
                self.addChild(self.backgroundMusic)
        })]))
        soundVolumeOn(node: backgroundMusic, status: bgmBool)
    }
    
    //https://developer.apple.com/forums/thread/107653
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (buttonPressed == true) { return }
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if (touchedNode.name == "restartButton") {
                buttonPressed = true
                sfxPlay(soundFileName: "SFX_GameRestart", scene: self)
                haptic_GoGameScene()
                self.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run({
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
                
            } else if (touchedNode.name == "returnHomeButton") {
                buttonPressed = true
                sfxPlay(soundFileName: "SFX_GoToSelectScene", scene: self)
                haptic_GoSelectScene()
                self.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run({
                    if let scene = SKScene(fileNamed: "SelectScene") {
                        let fade = SKTransition.fade(withDuration: 1)
                        for node in self.children {
                            node.removeAllActions()
                            node.removeAllChildren()
                        }
                        // Present the scene
                        self.view?.presentScene(scene, transition: fade)
                    }
                })]))
            } else if (touchedNode.name == "CurrentPiece") {
                return
            }

            if (nodeOpen == false) {
                return
            }

            if (touchedNode.name == "XX_RotationSB" && rotationStop == false) {
                rotationStop = true
                rotationRestartAction(node: touchedNode, rotateNodes: pieces)
                HapticManager.instance.impact(style: .light)
                return
            } else if (touchedNode.name == "XX_RandomSB" && randomStop == false) {
                randomStop = true
                randomRestartAction(node: touchedNode)
                HapticManager.instance.impact(style: .light)
                return
            }

            if (touched == false && pieceBackground.contains(location)) {
                if(touchCount != 0) {
                    return
                }
                else {
                    touchCount += 1
                }
                
                let currentZR = pieces[currentIndex].zRotation.rad2deg()
                let angle = CGFloat(180/(self.lastIndex+1))
                let sAngle = currentZR - angle + 90
                let eAngle = currentZR + angle + 90
                let temp = Donut(center: CGPoint(x: frame.midX, y: frame.midY), startAngle: sAngle , endAngle: eAngle, clockwise: false, radius: circleRadius, width: circleRadius - frame.width * 0.1)
                if(temp.contains(location)) {
                    scoreValue += 125
                    scoreLabel.text = String(scoreValue)

                    if(scoreValue > highScoreValue) {
                        highScoreValue = scoreValue
                        highScoreLabel.text = String(highScoreValue)
                    }

                    comboValue += 1
                    if(comboValue >= 3) {
                        comboLabel.text = "\(String(comboValue)) COMBO"
                        labelScaleAction(node: comboLabel)
                    } else {
                        comboLabel.text = ""
                    }

                    if (comboValue % 50 == 0 && comboValue > 0) {
                        sfxPlay(soundFileName: "SFX_Combo_", scene: self)
                        timerRadius += circleRadius * 0.15
                        HapticManager.instance.impact(style: .medium)
                    } else {
                        HapticManager.instance.impact(style: .soft)
                    }

                    if(comboValue > maxComboValue) {
                        maxComboValue = comboValue
                        maxComboLabel.text = String(maxComboValue)
                    }

                    change = true
                    if(randomStop == false) {
                        currentIndex = Int.random(in: 0...lastIndex)
                    }
                    currentPieceSprite.texture = SKTexture(imageNamed: "\(pieceName[currentIndex]).png")
                    currentPieceSprite.name = "Xp_\(pieceName[self.currentIndex])"
                    scaleAction(node: currentPieceSprite)
                } else {
                    sfxPlay(soundFileName: "SFX_ComboBreak", scene: self)
                    timerRadius -= circleRadius * 0.32
                    HapticManager.instance.impact(style: .heavy)
                    comboValue = 0
                    comboLabel.text = ""
                }
                
                touched = true
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            if(touched == true && touchCount == 1) {
                touched = false
                touchCount = 0
            }
        }
    }

    func timerAnimation (node: SKShapeNode, shadow: SKNode) {
        let wait = SKAction.wait(forDuration: 0.1)
        let hold = SKAction.run({
            if(change != true) {
                if(self.timerRadius > self.circleRadius) {
                    self.timerRadius -= self.circleRadius * 0.002
                    }
            } else {
                self.timerRadius += self.circleRadius * 0.006
                change = false
            }
            
            if(self.timerRadius > self.circleRadius) {
                
                node.path = Cir(center: CGPoint(x: self.frame.midX, y: self.frame.midY), radius: self.timerRadius)
            } else {
                if (self.stageEnd == false) {
                    self.backgroundMusic.removeFromParent()
                    self.labelBringToFront()
                    dataSet(value: self.highScoreValue, key: highScoreNameList[numberOfPiece - 2])
                    dataSet(value: self.maxComboValue, key: maxComboNameList[numberOfPiece - 2])
                    GameKitHelper.sharedInstance.reportScore(highScoreValue: self.highScoreValue, leaderboardIDs: leaderBoardName[numberOfPiece - 2])
                    sfxPlay(soundFileName: "SFX_GameEnd", scene: self)
                    let haptic = HapticProperty(count: 1, interval: [0.15], intensity: [0.4], sharpness: [0.45])
                    playCustomHaptic(hapticType: Haptic.dynamic, hapticProperty: haptic)
                    self.stageEnd = true
                }
                node.isHidden = true
                self.nodeOpen = false
                self.shadowAppear(node: self.shadow, hiddenNodes: [self.restartButtonBackground, self.returnButtonBackground, self.returnHomeButton, self.restartButton])
            }
        })
        
        let sequence = SKAction.sequence([wait, hold])
        let repeater = SKAction.repeatForever(sequence)
        let waitSec = SKAction.wait(forDuration: waitSec)
        let nodeOpenAction = SKAction.run {
            self.nodeOpen = true
            let haptic = HapticProperty(count: 1, interval: [0], intensity: [0.5], sharpness: [0.35])
            playCustomHaptic(hapticType: Haptic.transient, hapticProperty: haptic)
        }
        let finalSequence = SKAction.sequence([waitSec, nodeOpenAction, repeater])
        node.run(finalSequence)
    }
    
    func endGameButtonDisable() {
        returnButtonBackground.isHidden = true
        restartButtonBackground.isHidden = true
        returnHomeButton.isHidden = true
        restartButton.isHidden = true
    }
    
    func labelBringToFront() {
        self.scoreLabel.zPosition = 6
        self.scoreMark.zPosition = 6
        self.highScoreLabel.zPosition = 6
        self.highScoreMark.zPosition = 6
        self.maxComboLabel.zPosition = 6
        self.maxComboMark.zPosition = 6
    }
}
