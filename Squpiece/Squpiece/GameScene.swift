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

class GameScene: SKScene {
    
    // Presetting Values
    let pieces : [SKShapeNode] = [SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode()]
    let pieceSprite : [SKSpriteNode] = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
    //let colors : [UIColor] = [UIColor(.pieceColor4), UIColor(.pieceColor1), UIColor(.pieceColor2), UIColor(.pieceColor3)]
    //let colors : [UIColor] = [UIColor(.pieceColor1), UIColor(.pieceColor1), UIColor(.pieceColor1), UIColor(.pieceColor1)]
    let colors : [UIColor] = [UIColor(.pieceColor2), UIColor(.pieceColor2), UIColor(.pieceColor2), UIColor(.pieceColor2)]
    //let colors : [UIColor] = [UIColor(.pieceColor3), UIColor(.pieceColor3), UIColor(.pieceColor3), UIColor(.pieceColor3)]
    //let colors : [UIColor] = [UIColor(.pieceColor4), UIColor(.pieceColor4), UIColor(.pieceColor4), UIColor(.pieceColor4)]
    let timerStrokeColor = UIColor(.pieceColor2)
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
    var circleTimer = SKShapeNode()
    var timerRadius : CGFloat = 5
    
    // InGame Button
    let rotationStopButton = SKShapeNode()
    let randomStopButton = SKShapeNode()
    
    // OutGame Button
    let restartButton = SKSpriteNode()
    let fontColor = UIColor(.fontColor)
    
    let patternColor = UIColor(.patternColor2)
    let centerPatternColor = UIColor(.pieceColor2)
    let timerBackgroundColor = UIColor(.timerColor)
    
    let background = SKSpriteNode()
    let zen = SKSpriteNode()
    
    override func didMove(to view: SKView) {

        timerRadius = frame.height * 0.5
        resetVar()
        self.backgroundColor = UIColor(.bgColor)
        
        //Setting: High Score Label
        highScoreValue = UserDefaults.standard.integer(forKey: "HighScore")
        labelSetting(node: highScoreLabel, str: String(highScoreValue), align: .left, fontSize: CGFloat(frame.maxY * 0.06), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: frame.minX + frame.maxY * 0.05, y:frame.maxY - frame.maxY * 0.21))
        highScoreLabel.fontColor = UIColor.black
        labelNodeColor(node: highScoreLabel, color: fontColor)
        addChild(highScoreLabel)
        
        // Setting: Max Combo Label
        maxComboValue = UserDefaults.standard.integer(forKey: "MaxCombo")
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
        //shapeNodeColorSetting(node: circleTimer, fillColor: UIColor(.timerColor), strokeColor: UIColor(.timerColor))
        shapeNodeColorSetting(node: circleTimer, fillColor: timerBackgroundColor, strokeColor: timerBackgroundColor)
        circleTimer.zPosition = -1
        addChild(circleTimer)
        
//        let img = UIImage(named: "background.jpg")!
//        let data_ = img.pngData()
//        let newImage_ = UIImage(data:data_!)
//        background.texture = SKTexture(image: newImage_!)
//        background.size = CGSize(width: frame.width, height: frame.height)
//        background.zPosition = -1.5
//        addChild(background)
//
//        let img2 = UIImage(named: "yellowZen.png")!
//        let data2 = img2.pngData()
//        let newImage2 = UIImage(data:data2!)
//        zen.texture = SKTexture(image: newImage2!)
//        zen.size = CGSize(width: frame.width, height: frame.height)
//        zen.zPosition = -1
//        addChild(zen)
        
        // Setting: Piece & Piece Sprite
        for i in 0...lastIndex {
            pieces[i].path = Arc(center: CGPoint(x: frame.midX, y: frame.midY), startAngle: .degrees(Double(360/(lastIndex+1) * i)), endAngle: .degrees(Double(360/(lastIndex+1) * (i+1))), clockwise: false, radius: frame.maxX * 0.8)
            pieces[i].position = CGPoint(x: frame.midX, y:frame.midY)
            shapeNodeColorSetting(node: pieces[i], fillColor: colors[i], strokeColor: UIColor(.parchmentColor))
            nodelineWidthSetting(node: pieces[i], width: 3)
            nodeNameSetting(node: pieces[i], name:  "p_\(pieceName[i])")
            addChild(pieces[i])
            
            //https://stackoverflow.com/questions/59886426/creating-an-skspritenode-from-the-sf-symbols-font-in-a-different-color
            let image = UIImage(systemName: pieceName[i])!.withTintColor(patternColor)
            let data = image.pngData()
            let newImage = UIImage(data:data!)
            pieceSprite[i].texture = SKTexture(image: newImage!)
            
            //pieceSprite[i].texture = SKTexture(image: UIImage(systemName: pieceName[i])!)
            nodeNameSetting(node: pieceSprite[i], name: "p_\(pieceName[i])")
                        
            pieceSprite[i].size = CGSize(width: frame.maxX * 0.25, height: frame.maxX * 0.25)
            let divideFor = Double(lastIndex + 1)
            pieceSprite[i].position = CGPoint(x: cos(Double.pi / divideFor * Double(2*i + 1)) * frame.maxX * 0.5, y: sin(Double.pi / divideFor * Double(2*i + 1)) * frame.maxX * 0.5)
            pieces[i].addChild(pieceSprite[i])
            
            rotateAction([pieces[i]])
        }
        
        // Setting: Current Piece
        currentPiece.path = Cir(center: CGPoint(x: frame.midX, y: frame.midY), radius: frame.width * 0.1)
        shapeNodeColorSetting(node: currentPiece, fillColor: UIColor(.parchmentColor), strokeColor: timerStrokeColor)
        nodelineWidthSetting(node: currentPiece, width: 5)
        addChild(currentPiece)
        
        // Setting: Current Piece Sprite
        let patternImg = UIImage(systemName: pieceName[0])!.withTintColor(centerPatternColor)
        let patternData = patternImg.pngData()
        let newImg = UIImage(data:patternData!)
        currentPieceSprite.texture = SKTexture(image: newImg!)
        nodeNameSetting(node: currentPieceSprite, name: "Xp_\(pieceName[currentIndex])")
        currentPieceSprite.size = CGSize(width: frame.maxX * 0.18, height: frame.maxX * 0.18)
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
        shapeNodeColorSetting(node: shadow, fillColor: UIColor(.shadowColor), strokeColor: UIColor(.shadowColor))
        addChild(shadow)

        //https://stackoverflow.com/questions/59886426/creating-an-skspritenode-from-the-sf-symbols-font-in-a-different-color
        let image = UIImage(systemName: "arrow.clockwise")!.withTintColor(.white)
        let data = image.pngData()
        let newImage = UIImage(data:data!)
        restartButton.texture = SKTexture(image: newImage!)
        nodeNameSetting(node: restartButton, name: "restartButton")
        restartButton.size = CGSize(width: 45, height: 52.5)
        restartButton.position = CGPoint(x: 0, y: frame.minY + 200)
        restartButton.isHidden = true
        addChild(restartButton)
        
        shadowDisappear(node: shadow, labels: [self.scoreMark, self.scoreLabel, self.highScoreLabel, self.comboLabel, self.maxComboLabel, self.highScoreMark, self.maxComboMark])
        timerAnimation(node: self.circleTimer, shadow: self.shadow)
    }
    
    //https://developer.apple.com/forums/thread/107653
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if (touchedNode.name == "restartButton") {
                UserDefaults.standard.set(highScoreValue, forKey: "HighScore")
                UserDefaults.standard.set(maxComboValue, forKey: "MaxCombo")
                self.view?.isPaused = true
                for node in children {
                    node.removeAllActions()
                    node.removeAllChildren()
                }
                if let scene = SKScene(fileNamed: "GameScene") {
                    // Present the scene
                    self.view?.presentScene(scene)
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
            
            if ((touchedNode.name?.contains("p_")) != nil && touched == false && !touchedNode.name!.contains("XX")) {
                if(touchedNode.name!.contains("X") || ((abs(location.x) > frame.maxX*0.8) || (abs(location.y) > frame.maxX*0.8))) {
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
    
    override func update(_ currentTime: TimeInterval) {
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
                if(self.timerRadius > self.frame.maxX * 0.8) {
                    self.timerRadius -= self.frame.maxY * 0.001
                    }
            } else {
                self.timerRadius += self.frame.maxY * 0.003
                change = false
            }
            
            if(self.timerRadius > self.frame.maxX * 0.8) {
                node.path = Cir(center: CGPoint(x: self.frame.midX, y: self.frame.midY), radius: self.timerRadius)
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
