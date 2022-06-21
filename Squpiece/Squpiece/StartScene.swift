//
//  StartScene.swift
//  Squpiece
//
//  Created by 황정현 on 2022/06/21.
//

import SpriteKit
import GameplayKit
import AVFoundation

class StartScene: SKScene {

    let tapToStartLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        let circleRadius = frame.maxX * 0.8
        let radius = frame.width * 0.375
        let img = UIImage(named: "background.jpg")!
        let data = img.pngData()
        let newImage = UIImage(data:data!)
        let background = SKSpriteNode()
        background.texture = SKTexture(image: newImage!)
        background.size = CGSize(width: frame.width, height: frame.height)
        background.zPosition = -1.5
        addChild(background)
        
        let topDecoPattern = SKSpriteNode(imageNamed: "SelectUnderPattern.png")
        topDecoPattern.size = CGSize(width: frame.width, height: frame.width * 0.5)
        topDecoPattern.position = CGPoint(x: 0, y: frame.maxY - frame.width * 0.25)
        topDecoPattern.zRotation = .pi
        addChild(topDecoPattern)
        
        let bottomDecoPattern = SKSpriteNode(imageNamed: "SelectUnderPattern.png")
        bottomDecoPattern.size = CGSize(width: frame.width, height: frame.width * 0.5)
        bottomDecoPattern.position = CGPoint(x: 0, y: frame.minY + frame.width * 0.25)
        addChild(bottomDecoPattern)
        
        let symbolBackground = SKShapeNode()
        symbolBackground.path = Cir(center: CGPoint(x: frame.midX, y: frame.midY), radius: circleRadius)
        shapeNodeColorSetting(node: symbolBackground, fillColor: UIColor.clear, strokeColor: UIColor(.parchmentColor))
        nodelineWidthSetting(node: symbolBackground, width: 3)
        addChild(symbolBackground)
        
        let symbolPattern = SKSpriteNode(imageNamed: "Pattern.png")
        symbolPattern.size = CGSize(width: radius * 2, height: frame.width * 0.75)
        addChild(symbolPattern)
        
        let title = SKLabelNode()
        labelSetting(node: title, str: "LULLABY", align: .center, fontSize: frame.maxY * 0.14, fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: 0, y: 0))
        title.verticalAlignmentMode = .center
        addChild(title)
        let subTitle = SKLabelNode()
        labelSetting(node: subTitle, str: "-Overture-", align: .center, fontSize: frame.maxY * 0.08, fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: 0, y: frame.midY - frame.maxY * 0.1))
        subTitle.verticalAlignmentMode = .center
        title.addChild(subTitle)
        title.position = CGPoint(x: 0, y: frame.maxY * 0.7)
        
        labelSetting(node: tapToStartLabel, str: "TAP TO START", align: .center, fontSize: frame.maxY * 0.065, fontName: "AppleSDGothicNeo-SemiBold", pos: CGPoint(x: 0, y: frame.minY * 0.7))
        tapToStartLabel.verticalAlignmentMode = .center
        addChild(tapToStartLabel)
        blinkEffect(node: tapToStartLabel, duration: 0.8)
//        let patternSprites: [SKShapeNode] = [SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(), SKShapeNode(),  SKShapeNode()]
//        for i in 0..<patternSprites.count {
//            patternSprites[i].path = Cir(center: CGPoint(x: frame.midX, y: frame.midY), radius: radius * 0.12)
//            shapeNodeColorSetting(node: patternSprites[i], fillColor: UIColor(.selectLineColor).withAlphaComponent(0.8), strokeColor: UIColor(.selectLineColor))
//            patternSprites[i].lineWidth = 2
//            patternSprites[i].zPosition = 1
//            let tempSize = radius * 0.08
//            let temp = SKShapeNode(path: Rect(startPosition: CGPoint(x: frame.midX - tempSize, y: frame.midY - tempSize), xSize: tempSize * 2, ySize: tempSize * 2))
//            temp.fillTexture = SKTexture(imageNamed: "\(pieceName[i]).png")
//            shapeNodeColorSetting(node: temp, fillColor: UIColor.white, strokeColor: UIColor.clear)
//            patternSprites[i].addChild(temp)
//            addChild(patternSprites[i])
//        }
//        patternPiecePositionSetter(circleRadius: radius, frame: frame, patternSprites: patternSprites)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let scene = SKScene(fileNamed: "SelectScene") {
            for node in children {
                node.removeAllActions()
                node.removeAllChildren()
            }
            //let fade = SKTransition.fade(withDuration: 1)
            let fade = SKTransition.doorsOpenHorizontal(withDuration: 1)
            self.view?.presentScene(scene, transition: fade)
        }
    }
}


