//
//  GameScene.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/28.
//

//import SwiftUI
import SpriteKit
import GameplayKit
import AVFoundation

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

class GameScene: SKScene {
    
    // Presetting Values
    var circleRadius: CGFloat = 1
    let pieces : [SKShapeNode] = [SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode()]
    let pieceSprite : [SKSpriteNode] = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
    let pieceColor = UIColor(.pieceColor)
    let timerStrokeColor = UIColor(.pieceColor)
    let pieceName: [String] = ["suit.heart.fill", "suit.club.fill", "suit.spade.fill", "suit.diamond.fill", "staroflife.fill", "star.fill"]
    var lastIndex : Int = numberOfPiece - 1
    
    // Current Object Information
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
    var circleTimer = SKShapeNode()
    var timerRadius : CGFloat = 5
    
    // InGame Button
    let rotationStopButton = SKShapeNode()
    let randomStopButton = SKShapeNode()
    
    let pieceBackground = SKShapeNode()
    
    // OutGame Button
    let restartButton = SKSpriteNode()
    //let restartButton = SKLabelNode()
    let returnHomeButton = SKSpriteNode()
    
    let fontColor = UIColor(.fontColor)
    
    let patternColor = UIColor(.fontColor)
    let centerPatternColor = UIColor(.pieceColor)
    let timerBackgroundColor = UIColor(.timerColor)
    
    let background = SKSpriteNode()
    let zen = SKSpriteNode()
    
    var touchCount: Int = 0
    var nodeOpen: Bool = false

    override func didMove(to view: SKView) {
        
        circleRadius = frame.maxX * 0.8
        timerRadius = frame.height * 0.5
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
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 13.5, weight: .semibold, scale: .default)
        let currentSymbolConfig = UIImage.SymbolConfiguration(pointSize: 13.2, weight: .semibold, scale: .default)
        for i in 0...lastIndex {
            //https://developer.apple.com/documentation/spritekit/sknode/getting_started_with_physics_bodies
            pieces[i].path = Donut(center: CGPoint(x: frame.midX, y: frame.midY), startAngle: sAngle , endAngle: eAngle, clockwise: false, radius: circleRadius, width: circleRadius - frame.width * 0.1)
            shapeNodeColorSetting(node: pieces[i], fillColor: UIColor.clear, strokeColor: UIColor(.parchmentColor))
            nodelineWidthSetting(node: pieces[i], width: 3)
            addChild(pieces[i])
            
            //https://stackoverflow.com/questions/59886426/creating-an-skspritenode-from-the-sf-symbols-font-in-a-different-color
            let image = UIImage(systemName: pieceName[i], withConfiguration: symbolConfig)!.withTintColor(patternColor)
            let data = image.pngData()
            let newImage = UIImage(data:data!)
            pieceSprite[i].texture = SKTexture(image: newImage!)
            pieceSprite[i].size = newImage?.size ??  CGSize(width: frame.maxX * 0.25, height: frame.maxX * 0.25)
            pieceSprite[i].position = CGPoint(x: 0, y: circleRadius * 0.65)
            pieces[i].addChild(pieceSprite[i])
            pieceRotation(node: pieces[i], index: i)
            rotateAction([pieces[i]])
        }
        
        // Setting: Current Piece
        currentPiece.path = Cir(center: CGPoint(x: frame.midX, y: frame.midY), radius: frame.width * 0.1)
        shapeNodeColorSetting(node: currentPiece, fillColor: UIColor(.parchmentColor), strokeColor: UIColor(.parchmentColor))
        nodelineWidthSetting(node: currentPiece, width: 5)
        addChild(currentPiece)

        // Setting: Current Piece Sprite
        let patternImg = UIImage(systemName: pieceName[0], withConfiguration: currentSymbolConfig)!.withTintColor(centerPatternColor)
        let patternData = patternImg.pngData()
        let newImg = UIImage(data:patternData!)
        currentPieceSprite.texture = SKTexture(image: newImg!)
        nodeNameSetting(node: currentPieceSprite, name: "Xp_\(pieceName[currentIndex])")
        currentPieceSprite.size = newImg?.size ?? CGSize(width: frame.maxX * 0.18, height: frame.maxX * 0.18)
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
        shapeNodeColorSetting(node: shadow, fillColor: UIColor(.shadowColor.opacity(0.5)), strokeColor: UIColor(.shadowColor.opacity(0.5)))
        shadow.name = "shadow"
        shadow.zPosition = 0
        addChild(shadow)

        //https://stackoverflow.com/questions/60641048/change-a-sf-symbol-size-inside-a-uibutton
        let config1 = UIImage.SymbolConfiguration(pointSize: 14, weight: .semibold, scale: .default)
        let config2 = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold, scale: .default)
        //https://stackoverflow.com/questions/59886426/creating-an-skspritenode-from-the-sf-symbols-font-in-a-different-color
        //Restart Button : VER.SPRITE NODE
        let image = UIImage(systemName: "arrow.clockwise", withConfiguration: config1)!.withTintColor(.white)
        let data = image.pngData()
        let rImage = UIImage(data:data!)
        restartButton.texture = SKTexture(image: rImage!)
        nodeNameSetting(node: restartButton, name: "restartButton")
        restartButton.size = rImage?.size ?? CGSize(width: 45, height: 45)
//        restartButton.position = CGPoint(x: frame.midX + frame.maxX * 0.2, y: frame.minY + frame.height * 0.15)
        restartButton.position = CGPoint(x: frame.midX, y: frame.minY + frame.height * 0.12)
        restartButton.zPosition = 2
        restartButton.isHidden = true
        addChild(restartButton)
        
        //Restart Button : VER.LABEL
//        labelSetting(node: restartButton, str: "RESTART", align: .center, fontSize: CGFloat(frame.maxX * 0.2), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: 0, y: frame.minY + frame.height * 0.15))
//        labelNodeColor(node: restartButton, color: UIColor.white)
//        nodeNameSetting(node: restartButton, name: "restartButton")
//        restartButton.zPosition = 2
//        restartButton.isHidden = true
//        addChild(restartButton)

        let houseImg = UIImage(systemName: "house", withConfiguration: config2)!.withTintColor(.white)
        let hData = houseImg.pngData()
        let hImage = UIImage(data:hData!)
        returnHomeButton.texture = SKTexture(image: hImage!)
        nodeNameSetting(node: returnHomeButton, name: "returnHomeButton")
        returnHomeButton.size = hImage?.size ?? CGSize(width: 45, height: 45)
//        returnHomeButton.position = CGPoint(x: frame.midX - frame.maxX * 0.2, y: frame.minY + frame.height * 0.15)
        returnHomeButton.position = CGPoint(x: frame.midX, y: frame.minY + frame.height * 0.22)
        returnHomeButton.zPosition = 2
        returnHomeButton.isHidden = true
        addChild(returnHomeButton)
        
        shadowDisappear(node: shadow, labels: [self.scoreMark, self.scoreLabel, self.highScoreLabel, self.comboLabel, self.maxComboLabel, self.highScoreMark, self.maxComboMark])
        timerAnimation(node: self.circleTimer, shadow: self.shadow)
        
    }
    
    //https://developer.apple.com/forums/thread/107653
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if (touchedNode.name == "restartButton") {
                dataSet(value: highScoreValue, key: highScoreNameList[numberOfPiece - 2])
                dataSet(value: maxComboValue, key: maxComboNameList[numberOfPiece - 2])
                if let scene = SKScene(fileNamed: "GameScene") {
                    let fade = SKTransition.fade(withDuration: 1)
                    for node in children {
                        node.removeAllActions()
                        node.removeAllChildren()
                    }
                    // Present the scene
                    self.view?.presentScene(scene, transition: fade)
                }

            } else if (touchedNode.name == "returnHomeButton") {
                dataSet(value: highScoreValue, key: highScoreNameList[numberOfPiece - 2])
                dataSet(value: maxComboValue, key: maxComboNameList[numberOfPiece - 2])
                if let scene = SKScene(fileNamed: "SelectScene") {
                    let fade = SKTransition.fade(withDuration: 1)
                    for node in children {
                        node.removeAllActions()
                        node.removeAllChildren()
                    }
                    // Present the scene
                    self.view?.presentScene(scene, transition: fade)
                }
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
                
                let currentZR = rad2deg(pieces[currentIndex].zRotation)
                let angle = CGFloat(180/(self.lastIndex+1))
                let sAngle = currentZR - angle + 90
                let eAngle = currentZR + angle + 90
                let temp = Donut(center: CGPoint(x: frame.midX, y: frame.midY), startAngle: sAngle , endAngle: eAngle, clockwise: false, radius: circleRadius, width: circleRadius - frame.width * 0.1)
                if(temp.contains(location)) {
                    print("YES!")
                    scoreValue += 125
                    scoreLabel.text = String(scoreValue)
                    HapticManager.instance.impact(style: .soft)

                    if(scoreValue > highScoreValue) {
                        highScoreValue = scoreValue
                        highScoreLabel.text = String(highScoreValue)
                    }

                    comboValue += 1
                    comboLabel.text = "\(String(comboValue)) COMBO"
                    labelScaleAction(node: comboLabel)

                    if (comboValue % 50 == 0 && comboValue > 0) {
                        degree -= 10 // or 5?
                        timerRadius += frame.maxY * 0.15
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
                    let patternImg = UIImage(systemName: pieceName[currentIndex])!.withTintColor(centerPatternColor)
                    let patternData = patternImg.pngData()
                    let newImg = UIImage(data:patternData!)
                    currentPieceSprite.texture = SKTexture(image: newImg!)
                    currentPieceSprite.name = "Xp_\(self.pieceName[self.self.currentIndex])"
                    scaleAction(node: currentPieceSprite)
                } else {
                    print("NO...")
                    degree += 10 // or 3?
                    timerRadius -= frame.maxY * 0.12
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
                    self.timerRadius -= self.frame.maxY * 0.001
                    }
            } else {
                self.timerRadius += self.frame.maxY * 0.003
                change = false
            }
            
            if(self.timerRadius > self.circleRadius) {
                node.path = Cir(center: CGPoint(x: self.frame.midX, y: self.frame.midY), radius: self.timerRadius)
            } else {
                node.isHidden = true
                self.nodeOpen = false
                shadowAppear(node: self.shadow, hiddenNodes: [self.restartButton, self.returnHomeButton])
            }
        })
        
        let sequence = SKAction.sequence([wait, hold])
        let repeater = SKAction.repeatForever(sequence)
        let waitSec = SKAction.wait(forDuration: waitSec)
        let nodeOpenAction = SKAction.run {
            self.nodeOpen = true
        }
        let finalSequence = SKAction.sequence([waitSec, nodeOpenAction, repeater])
        node.run(finalSequence)
    }
}
