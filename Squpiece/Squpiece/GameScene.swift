//
//  GameScene.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/28.
//

import SwiftUI
import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    // Presetting Values
    let pieces : [SKShapeNode] = [SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode()]
    let pieceSprite : [SKSpriteNode] = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
    let colors : [UIColor] = [UIColor(.pieceColor4), UIColor(.pieceColor1), UIColor(.pieceColor2), UIColor(.pieceColor3)]
    let pieceName: [String] = ["suit.heart.fill", "suit.club.fill", "suit.spade.fill", "suit.diamond.fill"]
    var lastIndex = 3
    
    // Current Object Information
    var currentTouchedObject: String?
    var currentIndex: Int = 0
    
    // Past Value
    var highScoreValue: Int = 0
    var maxComboValue: Int = 0
    
    // Current Value
    var scoreValue: Int = 0
    var comboValue: Int = 0
    
    // Scene Cover
    var shadow = SKShapeNode()
    
    // Past Information
    var highScoreLabel = SKLabelNode()
    var maxComboLabel = SKLabelNode()
    
    // Current Information
    var scoreLabel = SKLabelNode()
    var comboLabel = SKLabelNode()
    let currentPiece = SKShapeNode()
    var currentPieceSprite = SKSpriteNode()
    
    // Place Holder
    var scoreMark = SKLabelNode()
    var highScoreMark = SKLabelNode()
    var maxComboMark = SKLabelNode()
    
    // About Time
    var timer = SKShapeNode()
    var timerBackground = SKShapeNode()
    
    // InGame Button
    let rotationStopButton = SKShapeNode()
    let randomStopButton = SKShapeNode()
    
    // OutGame Button
    let restartButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor(.backgroundColor)
        
        //Setting: High Score Label
        highScoreValue = UserDefaults.standard.integer(forKey: "HighScore")
        labelSetting(node: highScoreLabel, str: String(highScoreValue), align: .left, fontSize: CGFloat(frame.maxY * 0.06), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: frame.minX + frame.maxY * 0.05, y:frame.maxY - frame.maxY * 0.17))
        addChild(highScoreLabel)
        
        // Setting: Max Combo Label
        maxComboValue = UserDefaults.standard.integer(forKey: "MaxCombo")
        labelSetting(node: maxComboLabel, str: String(maxComboValue), align: .right, fontSize: CGFloat(frame.maxY * 0.06), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: frame.maxX - frame.maxY * 0.05, y:frame.maxY - frame.maxY * 0.17))
        addChild(maxComboLabel)
        
        // Setting: High Score Mark
        labelSetting(node: highScoreMark, str: String("HIGHSCORE"), align: .left, fontSize:  CGFloat(frame.maxY * 0.03), fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.minX + frame.maxY * 0.05, y:frame.maxY - frame.maxY * 0.12))
        addChild(highScoreMark)
        
        // Setting: Max Combo Mark
        labelSetting(node: maxComboMark, str: String("MAX COMBO"), align: .right, fontSize: CGFloat(frame.maxY * 0.03), fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: frame.maxX - frame.maxY * 0.05, y:frame.maxY - frame.maxY * 0.12))
        addChild(maxComboMark)
        
        // Setting: Score Mark
        labelSetting(node: scoreMark, str: String("SCORE"), align: .center, fontSize: CGFloat(frame.maxY * 0.06), fontName: "AppleSDGothicNeo-Regular", pos: CGPoint(x:0, y:frame.maxY - frame.maxY * 0.28))
        addChild(scoreMark)
        
        // Setting: Score Label
        labelSetting(node: scoreLabel, str: String(scoreValue), align: .center, fontSize: CGFloat(frame.maxY * 0.14), fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x:0, y:frame.maxY - frame.maxY * 0.4))
        addChild(scoreLabel)
        
        // Setting: Combo Label
        labelSetting(node: comboLabel, str: "", align: .center, fontSize: CGFloat(frame.maxY * 0.1), fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x:0, y:frame.maxY - frame.maxY * 0.5))
        addChild(comboLabel)
        
        // Setting: Piece & Piece Sprite
        for i in 0...lastIndex {
            pieces[i].path = Arc(center: CGPoint(x: frame.midX, y: frame.midY), startAngle: .degrees(Double(360/(lastIndex+1) * i)), endAngle: .degrees(Double(360/(lastIndex+1) * (i+1))), clockwise: false, radius: frame.maxX * 0.8)
            pieces[i].position = CGPoint(x: frame.midX, y:frame.midY)
            shapeNodeColorSetting(node: pieces[i], fillColor: colors[i], strokeColor: UIColor(.blackColor))
            nodelineWidthSetting(node: pieces[i], width: 3)
            nodeNameSetting(node: pieces[i], name:  "p_\(pieceName[i])")
            addChild(pieces[i])
            
            pieceSprite[i].texture = SKTexture(image: UIImage(systemName: pieceName[i])!)
            nodeNameSetting(node: pieceSprite[i], name: "p_\(pieceName[i])")
                        
            pieceSprite[i].size = CGSize(width: frame.maxX * 0.2, height: frame.maxX * 0.2)
            let divideFor = Double(lastIndex + 1)
            pieceSprite[i].position = CGPoint(x: cos(Double.pi / divideFor * Double(2*i + 1)) * frame.maxX * 0.5, y: sin(Double.pi / divideFor * Double(2*i + 1)) * frame.maxX * 0.5)
            pieces[i].addChild(pieceSprite[i])
            
            rotateAction([pieces[i]])
        }
        
        // Setting: Timer Background
        timerBackground.path = timerBar(center:  CGPoint(x: 0, y: frame.minY + frame.minY * 0.3), value: .degrees(degree), radius: frame.maxY * 0.6)
        shapeNodeColorSetting(node: timerBackground, fillColor: UIColor(.timerBackgroundColor), strokeColor: UIColor(.timerBackgroundColor))
        addChild(timerBackground)
        
        // Setting: Timer
        timer.path = timerBar(center:  CGPoint(x: 0, y: frame.minY + frame.minY * 0.3), value: .degrees(degree), radius: frame.maxY * 0.6)
        shapeNodeColorSetting(node: timer, fillColor: UIColor.white, strokeColor: UIColor.white)
        addChild(timer)
        
        // Setting: Current Piece
        currentPiece.path = Cir(center: CGPoint(x: frame.midX, y: frame.midY), radius: frame.width * 0.1)
        shapeNodeColorSetting(node: currentPiece, fillColor: UIColor.white, strokeColor: UIColor(.blackColor))
        nodelineWidthSetting(node: currentPiece, width: 5)
        addChild(currentPiece)
        
        // Setting: Current Piece Sprite
        currentPieceSprite.texture = SKTexture(image: UIImage(systemName: pieceName[currentIndex])!)
        nodeNameSetting(node: currentPieceSprite, name: "Xp_\(pieceName[currentIndex])")
        currentPieceSprite.size = CGSize(width: frame.maxX * 0.15, height: frame.maxX * 0.15)
        addChild(currentPieceSprite)
        
        // Setting: Rotation Stop Button
        rotationStopButton.path = Cir(center: CGPoint(x: frame.midX - frame.maxX * 0.75, y: frame.minY + frame.maxY * 0.35), radius: frame.width * 0.08)
        shapeNodeColorSetting(node: rotationStopButton, fillColor: UIColor.black, strokeColor: UIColor.black)
        nodelineWidthSetting(node: rotationStopButton, width: 5)
        nodeNameSetting(node: rotationStopButton, name: "XX_RotationSB")
        addChild(rotationStopButton)
        
        // Setting: Random Stop Button
        randomStopButton.path = Cir(center: CGPoint(x: frame.midX + frame.maxX * 0.75, y: frame.minY + frame.maxY * 0.35), radius: frame.width * 0.08)
        shapeNodeColorSetting(node: randomStopButton, fillColor: UIColor.white, strokeColor: UIColor.white)
        nodelineWidthSetting(node: randomStopButton, width: 5)
        nodeNameSetting(node: randomStopButton, name: "XX_RandomSB")
        addChild(randomStopButton)
        
        // Setting: Shadow
        shadow.path = Rect(startPosition: CGPoint(x: frame.minX, y: frame.minY), xSize: frame.width, ySize: frame.height)
        shapeNodeColorSetting(node: shadow, fillColor: UIColor(.shadowColor), strokeColor: UIColor(.shadowColor))
        addChild(shadow)

        // Setting: Restart Button
        restartButton.texture = SKTexture(image: UIImage(systemName: "arrow.clockwise")!)
        nodeNameSetting(node: restartButton, name: "restartButton")
        restartButton.size = CGSize(width: 90, height: 105)
        restartButton.position = CGPoint(x: 0, y: frame.minY + 200)
        restartButton.isHidden = true
        addChild(restartButton)
        
        shadowDisappear(node: shadow, labels: [self.scoreMark, self.scoreLabel, self.highScoreLabel, self.comboLabel, self.maxComboLabel, self.highScoreMark, self.maxComboMark])
        timerAnimation(node: self.timer, shadow: self.shadow)
    }
    
    //https://developer.apple.com/forums/thread/107653
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if ((touchedNode.name?.contains("p_")) != nil && touched == false && !touchedNode.name!.contains("XX")) {
                if(touchedNode.name!.contains("X")) {
                    return
                }
                
                currentTouchedObject = touchedNode.name
                if((currentPieceSprite.name!.contains(currentTouchedObject!))) {
                    scoreValue += 125
                    scoreLabel.text = String(scoreValue)
                    HapticManager.instance.impact(style: .soft)

                    if(scoreValue > highScoreValue) {
                        highScoreValue = scoreValue
                        highScoreLabel.text = String(highScoreValue)
                    }
                    
                    comboValue += 1
                    comboLabel.text = "\(String(comboValue)) COMBO"
                    scaleAction(node: comboLabel)
                    
                    if (comboValue % 50 == 0 && comboValue > 0) {
                        degree += 10 // or 5?
                        HapticManager.instance.impact(style: .medium)
                    }
                    
                    if(comboValue > maxComboValue) {
                        maxComboValue = comboValue
                        maxComboLabel.text = String(maxComboValue)
                    }
                    
                    change = true
                    if(randomStop == false) {
                        currentIndex = Int.random(in: 0...lastIndex)
                    }
                    currentPieceSprite.texture = SKTexture(image: UIImage(systemName: self.pieceName[self.currentIndex])!)
                    currentPieceSprite.name = "Xp_\(self.pieceName[self.self.currentIndex])"
                    scaleAction(node: currentPieceSprite)
                    
                } else {
                    degree -= 5 // or 3?
                    HapticManager.instance.impact(style: .heavy)
                    comboValue = 0
                    comboLabel.text = ""
                }
                touched = true
            }
            
            if (touchedNode.name == "restartButton") {
                UserDefaults.standard.set(highScoreValue, forKey: "HighScore")
                UserDefaults.standard.set(maxComboValue, forKey: "MaxCombo")
                if let view = self.view {
                    if let scene = SKScene(fileNamed: "GameScene") {
                        view.presentScene(scene)
                    }
                }
            } else if (touchedNode.name == "XX_RotationSB" && rotationStop == false) {
                rotationStop = true
                rotationRestartAction(node: touchedNode, rotateNodes: pieces)
                HapticManager.instance.impact(style: .light)
            } else if (touchedNode.name == "XX_RandomSB" && randomStop == false) {
                randomStop = true
                randomRestartAction(node: touchedNode)
                HapticManager.instance.impact(style: .light)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if(touched == true && currentTouchedObject == touchedNode.name) {
                touched = false
            }
        }
    }
    
    func timerAnimation (node: SKShapeNode, shadow: SKNode) {
        let wait = SKAction.wait(forDuration: 0.1)
        let hold = SKAction.run({
            if(change != true) {
                if(degree > 0) {
                    degree -= 0.1
                    }
            } else {
                degree += 0.5
                change = false
            }
            
            if(degree > 0) {
                node.path = timerBar(center:  CGPoint(x: 0, y: self.frame.minY + self.frame.minY * 0.3), value: .degrees(degree), radius: self.frame.maxY * 0.6)
            } else {
                node.isHidden = true
                shadowAppear(node: self.shadow, restartButton: self.restartButton, labels: [self.scoreMark, self.scoreLabel, self.highScoreLabel, self.comboLabel, self.maxComboLabel, self.highScoreMark, self.maxComboMark])
            }
        })
        
        let sequence = SKAction.sequence([wait, hold])
        let repeater = SKAction.repeatForever(sequence)
        let wait2sec = SKAction.wait(forDuration: 2)
        let finalSequence = SKAction.sequence([wait2sec, repeater])
        node.run(finalSequence)
    }

}
