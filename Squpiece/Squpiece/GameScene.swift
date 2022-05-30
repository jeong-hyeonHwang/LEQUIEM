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

func timerBar(center: CGPoint, value: Angle, radius: CGFloat) -> CGPath {
    var path = Path()
    path.addLines([center])
    path.addArc(center: center, radius: radius, startAngle: .degrees(90) - value, endAngle: .degrees(90) + value, clockwise: false)
    path.addLine(to: center)
    return path.cgPath
}

//https://gist.github.com/KanshuYokoo/a78223ffec27319a548d52dc09b660e4
func Arc(center: CGPoint, startAngle: Angle, endAngle: Angle, clockwise: Bool, radius: CGFloat) -> CGPath {
    var path = Path()
    path.addLines([center])
    path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    path.addLine(to: center)
    return path.cgPath
}

func Cir(center: CGPoint, radius: CGFloat) -> CGPath {
    var path = Path()
    path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
    return path.cgPath
}

func Rect(startPosition: CGPoint, xSize: CGFloat, ySize: CGFloat) -> CGPath {
    var path = Path()
    path.addRect(CGRect(x: startPosition.x, y: startPosition.y, width: xSize, height: ySize))
    return path.cgPath
}

class GameScene: SKScene {
    var change = false
    var touched = false
    var incorrect = false
    
    var rotateAngle: CGFloat = 5
    var rotationStop =  false
    var randomStop = false
    
    var waitSec: Double = 1
    var lastIndex = 3
    var degree: Double = 55
    var pieceCount: [Int] = [0, 0, 0, 0]
    var currentTouchedObject: String?
    var currentIndex: Int = 0
    
    var scoreValue: Int = 0
    var highScoreValue: Int = 0
    var comboValue: Int = 0
    var maxComboValue: Int = 0
    
    var shadow = SKShapeNode()
    
    var scoreMark = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var highScoreLabel = SKLabelNode()
    var comboLabel = SKLabelNode()
    var maxComboLabel = SKLabelNode()
    
    var highScoreMark = SKLabelNode()
    var maxComboMark = SKLabelNode()
    
    var timer = SKShapeNode()
    var timerBackground = SKShapeNode()
    
    
    let currentPiece = SKShapeNode()
    var currentPieceSprite = SKSpriteNode()
    
    let pieces : [SKShapeNode] = [SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode()]
    let pieceSprite : [SKSpriteNode] = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
    
    let rotationStopButton = SKShapeNode()
    let randomStopButton = SKShapeNode()
    
    let restartButton = SKSpriteNode()
    
    let colors : [UIColor] = [UIColor(.pieceColor4), UIColor(.pieceColor1), UIColor(.pieceColor2), UIColor(.pieceColor3)]
    //let pieceName: [String] = ["multiply", "plus", "divide", "minus"]
    let pieceName: [String] = ["suit.heart.fill", "suit.club.fill", "suit.spade.fill", "suit.diamond.fill"]
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor(.backgroundColor)
        //https://www.hackingwithswift.com/example-code/games/how-to-write-text-using-sklabelnode
        
        scoreMark.text = String("SCORE")
        scoreMark.horizontalAlignmentMode = .center
        scoreMark.fontSize = CGFloat(frame.maxY * 0.06)
        scoreMark.fontName = "AppleSDGothicNeo-Regular"
        scoreMark.position = CGPoint(x:0, y:frame.maxY - frame.maxY * 0.28)
        addChild(scoreMark)
        
        scoreLabel.text = String(scoreValue)
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.fontSize = CGFloat(frame.maxY * 0.14)
        scoreLabel.fontName = "AppleSDGothicNeo-SemiBold"
        scoreLabel.position = CGPoint(x:0, y:frame.maxY - frame.maxY * 0.4)
        addChild(scoreLabel)
        
        highScoreValue = UserDefaults.standard.integer(forKey: "HighScore")
        highScoreLabel.text = String(highScoreValue)
        highScoreLabel.fontSize = CGFloat(frame.maxY * 0.06)
        highScoreLabel.fontName = "AppleSDGothicNeo-Bold"
        highScoreLabel.position = CGPoint(x: frame.minX + frame.maxY * 0.05, y:frame.maxY - frame.maxY * 0.17)
        highScoreLabel.horizontalAlignmentMode = .left
        addChild(highScoreLabel)
        
        comboLabel.text = ""
        comboLabel.horizontalAlignmentMode = .center
        comboLabel.fontSize = CGFloat(frame.maxY * 0.1)
        comboLabel.fontName = "AppleSDGothicNeo-SemiBold"
        comboLabel.position = CGPoint(x:0, y:frame.maxY - frame.maxY * 0.5)
        addChild(comboLabel)
        
        maxComboValue = UserDefaults.standard.integer(forKey: "MaxCombo")
        maxComboLabel.text = String(maxComboValue)
        maxComboLabel.fontSize = CGFloat(frame.maxY * 0.06)
        maxComboLabel.fontName = "AppleSDGothicNeo-Bold"
        maxComboLabel.position = CGPoint(x: frame.maxX - frame.maxY * 0.05, y:frame.maxY - frame.maxY * 0.17)
        maxComboLabel.horizontalAlignmentMode = .right
        addChild(maxComboLabel)
        
        maxComboMark.text = String("MAX COMBO")
        maxComboMark.horizontalAlignmentMode = .right
        maxComboMark.fontSize = CGFloat(frame.maxY * 0.03)
        maxComboMark.fontName = "AppleSDGothicNeo-SemiBold"
        maxComboMark.position =  CGPoint(x: frame.maxX - frame.maxY * 0.05, y:frame.maxY - frame.maxY * 0.12)
        addChild(maxComboMark)
        
        highScoreMark.text = String("HIGHSCORE")
        highScoreMark.horizontalAlignmentMode = .left
        highScoreMark.fontSize = CGFloat(frame.maxY * 0.03)
        highScoreMark.fontName = "AppleSDGothicNeo-SemiBold"
        highScoreMark.position =  CGPoint(x: frame.minX + frame.maxY * 0.05, y:frame.maxY - frame.maxY * 0.12)
        addChild(highScoreMark)
        
        for i in 0...lastIndex {
            pieces[i].path = Arc(center: CGPoint(x: frame.midX, y: frame.midY), startAngle: .degrees(Double(360/(lastIndex+1) * i)), endAngle: .degrees(Double(360/(lastIndex+1) * (i+1))), clockwise: false, radius: frame.maxX * 0.8)
            pieces[i].position = CGPoint(x: frame.midX, y:frame.midY)
            pieces[i].fillColor = colors[i]
            pieces[i].strokeColor = UIColor(.blackColor)
            pieces[i].lineWidth = 3
            pieces[i].name = "p_\(pieceName[i])"
            addChild(pieces[i])
            
            pieceSprite[i].texture = SKTexture(image: UIImage(systemName: pieceName[i])!)
            pieceSprite[i].name = "p_\(pieceName[i])"
                        
            pieceSprite[i].size = CGSize(width: frame.maxX * 0.15, height: frame.maxX * 0.15)
            let divideFor = Double(lastIndex + 1)
            pieceSprite[i].position = CGPoint(x: cos(Double.pi / divideFor * Double(2*i + 1)) * frame.maxX * 0.5, y: sin(Double.pi / divideFor * Double(2*i + 1)) * frame.maxX * 0.5)
            pieces[i].addChild(pieceSprite[i])
            
            rotateAction([pieces[i]])
        }
        
        timerBackground.path = timerBar(center:  CGPoint(x: 0, y: frame.minY + frame.minY * 0.3), value: .degrees(degree), radius: frame.maxY * 0.6)
        timerBackground.fillColor = UIColor(.timerBackgroundColor)
        timerBackground.strokeColor = UIColor(.timerBackgroundColor)
        addChild(timerBackground)
        
        timer.path = timerBar(center:  CGPoint(x: 0, y: frame.minY + frame.minY * 0.3), value: .degrees(degree), radius: frame.maxY * 0.6)
        timer.fillColor = UIColor.white
        timer.strokeColor = UIColor.white
        addChild(timer)
        
        currentPiece.path = Cir(center: CGPoint(x: frame.midX, y: frame.midY), radius: frame.width * 0.1)
        currentPiece.fillColor = UIColor.white
        currentPiece.strokeColor = UIColor(.blackColor)
        currentPiece.lineWidth = 5
        addChild(currentPiece)
        
        currentPieceSprite.texture = SKTexture(image: UIImage(systemName: pieceName[currentIndex])!)
        currentPieceSprite.name = "Xp_\(pieceName[currentIndex])"
        currentPieceSprite.size = CGSize(width: frame.maxX * 0.15, height: frame.maxX * 0.15)
        addChild(currentPieceSprite)
        
        rotationStopButton.path = Cir(center: CGPoint(x: frame.midX - frame.maxX * 0.75, y: frame.minY + frame.maxY * 0.35), radius: frame.width * 0.08)
        rotationStopButton.fillColor = UIColor.black
        rotationStopButton.strokeColor = UIColor.black
        rotationStopButton.lineWidth = 5
        rotationStopButton.name = "XX_RotationSB"
        addChild(rotationStopButton)
        
        randomStopButton.path = Cir(center: CGPoint(x: frame.midX + frame.maxX * 0.75, y: frame.minY + frame.maxY * 0.35), radius: frame.width * 0.08)
        randomStopButton.fillColor = UIColor.white
        randomStopButton.strokeColor = UIColor.white
        randomStopButton.lineWidth = 5
        randomStopButton.name = "XX_RandomSB"
        addChild(randomStopButton)
        
        
        shadow.path = Rect(startPosition: CGPoint(x: frame.minX, y: frame.minY), xSize: frame.width, ySize: frame.height)
        shadow.fillColor = UIColor(.shadowColor)
        shadow.strokeColor = UIColor(.shadowColor)
        addChild(shadow)

        shadowDisappear(shadow)
        
        restartButton.texture = SKTexture(image: UIImage(systemName: "arrow.clockwise")!)
        restartButton.name = "restartButton"
        restartButton.size = CGSize(width: 90, height: 105)
        restartButton.position = CGPoint(x: 0, y: frame.minY + 200)
        restartButton.isHidden = true
        addChild(restartButton)
        
        timerAnimation(node: timer)
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
                    print("incorrect...")
                    incorrect = true
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
    
    func rotationRestartAction(node: SKNode, rotateNodes: [SKNode]) {
        
        for node in rotateNodes {
            node.removeAction(forKey: "Rotation")
        }
        rotateAction(rotateNodes)
        let wait = SKAction.wait(forDuration: 2)
        let action = SKAction.run {
            self.rotationStop = false
        }
        let sequence = SKAction.sequence([wait, action])
        node.run(sequence)
    }
    
    func randomRestartAction(node: SKNode) {
        let wait = SKAction.wait(forDuration: 2)
        let action = SKAction.run {
            self.randomStop = false
        }
        let sequence = SKAction.sequence([wait, action])
        node.run(sequence)
    }
    
    func scaleAction (node: SKNode) {
        let to = SKAction.scale(to: 1.2, duration: 0.1)
        let end = SKAction.scale(to: 1.0, duration: 0.1)
        let sequence = SKAction.sequence([to, end])

        node.run(sequence)
    }
    
    func shadowDisappear(_ node: SKNode) {
        let labels = [self.scoreMark, self.scoreLabel, self.highScoreLabel, self.comboLabel, self.maxComboLabel, self.highScoreMark, self.maxComboMark]
        
        for label in labels {
            label.alpha = 0.0
        }
        let shadowAppear = SKAction.run {
            node.alpha = 1.0
            node.isHidden = false
        }
        let wait = SKAction.wait(forDuration: waitSec - 0.2)
        let fadeOut = SKAction.fadeOut(withDuration: 0.2)
        let shadowDisappear = SKAction.run {
            self.labelAppear()
            node.isHidden = true
            node.alpha = 0.8
        }
        let sequence = SKAction.sequence([shadowAppear, wait, fadeOut, shadowDisappear])
        node.run(sequence)
    }
    
    func shadowAppear(_ node: SKNode) {
        node.alpha = 0.0
        node.isHidden = false
        let fadeIn = SKAction.fadeIn(withDuration: 0.1)
        let shadowAppear = SKAction.run {
            self.labelDisappear()
            self.restartButton.isHidden = false
        }
        let sequence = SKAction.sequence([fadeIn, shadowAppear])
        node.run(sequence)
    }
    
    func labelAppear() {
        let labels = [self.scoreMark, self.scoreLabel, self.highScoreLabel, self.comboLabel, self.maxComboLabel, self.highScoreMark, self.maxComboMark]
        
        for label in labels {
            label.alpha = 0.0
            label.isHidden = false
            
            let fadeIn = SKAction.fadeIn(withDuration: 0.15)
            label.run(fadeIn)
        }
    }
    
    func labelDisappear() {
        let labels = [self.scoreMark, self.scoreLabel, self.highScoreLabel, self.comboLabel, self.maxComboLabel, self.highScoreMark, self.maxComboMark]
        
        for label in labels {
            let fadeOut = SKAction.fadeOut(withDuration: 0.2)
            label.run(fadeOut)
        }
    }
    
    func rotateAction (_ nodes: [SKNode]) {
        for node in nodes {
            let leftRotate = SKAction.rotate(byAngle: -rotateAngle, duration: 5)
            let sequence1 = SKAction.sequence([leftRotate])
            let action1 = SKAction.repeat(sequence1, count: 3)
            let rightRotate = SKAction.rotate(byAngle: rotateAngle, duration: 5)
            let sequence2 = SKAction.sequence([rightRotate])
            let action2 = SKAction.repeat(sequence2, count: 3)
            let re = SKAction.sequence([action1, action2])
            let repeater = SKAction.repeatForever(re)
            let waitASec = SKAction.wait(forDuration: waitSec)
            let finalSequence = SKAction.sequence([waitASec, repeater])
            node.run(finalSequence, withKey: "Rotation")
        }
    }
    
    func timerAnimation (node: SKShapeNode) {
        let wait = SKAction.wait(forDuration: 0.1)
        let hold = SKAction.run({
            if(self.change != true) {
                if(self.degree > 0) {
                    self.degree -= 0.1
                    }
            } else {
                self.degree += 0.5
                self.change = false
            }
            
            if(self.degree > 0) {
                node.path = timerBar(center:  CGPoint(x: 0, y: self.frame.minY + self.frame.minY * 0.3), value: .degrees(self.degree), radius: self.frame.maxY * 0.6)
            } else {
                node.isHidden = true
                self.shadowAppear(self.shadow)
            }
        })
        
        let sequence = SKAction.sequence([wait, hold])
        let repeater = SKAction.repeatForever(sequence)
        let wait2sec = SKAction.wait(forDuration: 2)
        let finalSequence = SKAction.sequence([wait2sec, repeater])
        node.run(finalSequence)
    }
}
