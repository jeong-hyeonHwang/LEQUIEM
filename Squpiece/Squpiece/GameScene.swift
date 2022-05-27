//
//  GameScene.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/28.
//

import SwiftUI
import SpriteKit
import GameplayKit

//https://gist.github.com/KanshuYokoo/a78223ffec27319a548d52dc09b660e4
func Arc(center: CGPoint, startAngle: Angle, endAngle: Angle, clockwise: Bool, radius: CGFloat) -> CGPath {
    var path = Path()
    path.addLines([center])
    path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
    path.addLine(to: center)
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
    var count: Int = 0
    var currentTouchedObject: String?
    var currentIndex: Int = Int.random(in: 0...3)
    var scoreValue: Int = 0
    var highScoreValue: Int = 0
    var shadow = SKShapeNode()
    
    var scoreLabel = SKLabelNode()
    var highScoreLabel = SKLabelNode()
    
    let currentPiece = SKShapeNode()
    let pieces : [SKShapeNode] = [SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode()]
    let pieceSprite : [SKSpriteNode] = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
    let restartButton = SKSpriteNode()
    
    let colors : [UIColor] = [UIColor.systemYellow, UIColor.systemRed, UIColor.systemBlue, UIColor.white]
    
    var currentPieceSprite = SKSpriteNode()
    let pieceName: [String] = ["multiply", "plus", "divide", "minus"]
    
    
    override func didMove(to view: SKView) {
        
        //https://www.hackingwithswift.com/example-code/games/how-to-write-text-using-sklabelnode
        scoreLabel.text = String(scoreValue)
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.fontSize = CGFloat(frame.maxY * 0.14)
        scoreLabel.position = CGPoint(x:0, y:frame.maxY - frame.maxY * 0.35)
        addChild(scoreLabel)
        
        highScoreValue = UserDefaults.standard.integer(forKey: "HighScore")
        highScoreLabel.text = String(highScoreValue)
        highScoreLabel.fontSize = CGFloat(frame.maxY * 0.06)
        highScoreLabel.position = CGPoint(x: frame.minX + frame.maxY * 0.1, y:frame.maxY - frame.maxY * 0.12)
        highScoreLabel.horizontalAlignmentMode = .left
        addChild(highScoreLabel)
        
        for i in 0...3 {
            pieces[i].path = Arc(center: CGPoint(x: frame.midX, y: frame.midY), startAngle: .degrees(Double(90 * i)), endAngle: .degrees(Double(90 * (i+1))), clockwise: false, radius: frame.maxX * 0.8)
            pieces[i].position = CGPoint(x: frame.midX, y:frame.midY)
            pieces[i].fillColor = colors[i]
            pieces[i].strokeColor = colors[i]
            pieces[i].name = "p_\(pieceName[i])"
            addChild(pieces[i])
            
            pieceSprite[i].texture = SKTexture(image: UIImage(systemName: pieceName[i])!)
            pieceSprite[i].name = "p_\(pieceName[i])"
                        
            pieceSprite[i].size = CGSize(width: frame.maxX * 0.15, height: frame.maxX * 0.15)
            pieceSprite[i].position = CGPoint(x: cos(Double.pi / 4 * Double(2*i + 1)) * frame.maxX * 0.5, y: sin(Double.pi / 4 * Double(2*i + 1)) * frame.maxX * 0.5)
            pieces[i].addChild(pieceSprite[i])
        }
        
        currentPiece.path = Arc(center: CGPoint(x: frame.midX, y: frame.midY), startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false, radius: frame.width * 0.1)
        currentPiece.fillColor = UIColor.lightGray
        currentPiece.strokeColor = UIColor.lightGray
        addChild(currentPiece)
        
        currentPieceSprite.texture = SKTexture(image: UIImage(systemName: pieceName[currentIndex])!)
        currentPieceSprite.name = "Xp_\(pieceName[currentIndex])"
        currentPieceSprite.size = CGSize(width: frame.maxX * 0.12, height: frame.maxX * 0.12)
        addChild(currentPieceSprite)
        
        shadow.path = Rect(startPosition: CGPoint(x: frame.minX, y: frame.minY), xSize: frame.width, ySize: frame.height)
        shadow.fillColor = UIColor.black
        shadow.strokeColor = UIColor.black
        shadow.alpha = 0.6
        shadow.isHidden = true
        addChild(shadow)

        restartButton.texture = SKTexture(image: UIImage(systemName: "arrow.clockwise")!)
        restartButton.name = "restartButton"
        restartButton.size = CGSize(width: 90, height: 105)
        restartButton.position = CGPoint(x: 0, y: frame.minY + 200)
        restartButton.isHidden = true
        addChild(restartButton)
        
    }
    
    //https://developer.apple.com/forums/thread/107653
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if ((touchedNode.name?.contains("p_")) != nil && touched == false) {
                if(touchedNode.name!.contains("X")) {
                    return
                }
                
                currentTouchedObject = touchedNode.name
                if((currentPieceSprite.name!.contains(currentTouchedObject!))) {
                    scoreValue += 125
                    scoreLabel.text = String(scoreValue)
                    if(scoreValue > highScoreValue)
                    {
                        highScoreValue = scoreValue
                        highScoreLabel.text = String(highScoreValue)
                    }
                    change = true
                } else {
                    print("incorrect...")
                    restartButton.isHidden = false
                    shadow.isHidden = false
                }
                touched = true
            } else if (touchedNode.name == "restartButton") {
                UserDefaults.standard.set(highScoreValue, forKey: "HighScore")
                if let view = self.view {
                    if let scene = SKScene(fileNamed: "GameScene") {
                        view.presentScene(scene)
                    }
                }
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
    
    override func update(_ currentTime: TimeInterval) {
        if(change == true) {
            currentIndex = Int.random(in: 0...3)
            currentPieceSprite.texture = SKTexture(image: UIImage(systemName: pieceName[currentIndex])!)
            currentPieceSprite.name = "Xp_\(pieceName[currentIndex])"
            change = false
            count += 1
        }
    }
}
