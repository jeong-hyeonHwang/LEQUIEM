//
//  StartScene.swift
//  Squpiece
//
//  Created by 황정현 on 2022/06/21.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit

class StartScene: SKScene {

    let tapToStartLabel = SKLabelNode()
    let background = SKSpriteNode()
    let backgroundMusic = SKAudioNode(fileNamed: "Lequiem.mp3")
    private var startButtonPressed = false
    
    // MARK: Setting Panel Components
    let settingButton = SKSpriteNode()
    let closeButton = SKSpriteNode()
    let shadow = SKShapeNode()
    let bgmBoolButton = SKShapeNode()
    let sfxBoolButton = SKShapeNode()
    let bgmLabel = SKLabelNode()
    let bgmBoolLabel = SKLabelNode()
    let sfxLabel = SKLabelNode()
    let sfxBoolLabel = SKLabelNode()

    let gameCenterTrigger = SKShapeNode()
    
    override func didMove(to view: SKView) {
        
        GameKitHelper.sharedInstance.authenticateLocalPlayer(view: self.view!)
//        GKAccessPoint.shared.location = .topLeading
//        GKAccessPoint.shared.showHighlights = true
//        GKAccessPoint.shared.isActive = true
        
        let circleRadius = frame.maxX * 0.8
        let radius = frame.width * 0.375
        let img = UIImage(named: "background.jpg")!
        let data = img.pngData()
        let newImage = UIImage(data:data!)
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
        
        let symbolPattern = SKSpriteNode(imageNamed: "TestPattern.png")
        symbolPattern.size = CGSize(width: radius * 2, height: frame.width * 0.75)
        addChild(symbolPattern)
        
        let title = SKLabelNode()
        labelSetting(node: title, str: "LEQUIEM", align: .center, fontSize: frame.maxY * 0.14, fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: 0, y: 0))
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
        
        setSettingButton(settingButton: settingButton, frame: frame)
        addChild(settingButton)


        //https://stackoverflow.com/questions/60641048/change-a-sf-symbol-size-inside-a-uibutton
        let config = UIImage.SymbolConfiguration(pointSize: hasTopNotch == true ? 10 : 14, weight: .semibold, scale: .default)
        let image = UIImage(systemName: "xmark", withConfiguration: config)!.withTintColor(UIColor(.parchmentColor))
        let data_ = image.pngData()
        let rImage = UIImage(data:data_!)
        closeButton.texture = SKTexture(image: rImage!)
        nodeNameSetting(node: closeButton, name: "closeButton")
        closeButton.size = rImage?.size ?? CGSize(width: 10, height: 10)
        closeButton.position = CGPoint(x: frame.maxX - frame.maxX * 0.16, y: hasTopNotch == true ? frame.maxY - frame.maxX * 0.3 : frame.maxY - frame.maxX * 0.24)
        closeButton.zPosition = 6
        shadow.addChild(closeButton)
        
        // Setting: Shadow
        shadow.path = Rect(startPosition: CGPoint(x: frame.minX, y: frame.minY), xSize: frame.width, ySize: frame.height)
        shapeNodeColorSetting(node: shadow, fillColor: UIColor(.shadowColor.opacity(0.8)), strokeColor: UIColor(.shadowColor.opacity(0.8)))
        shadow.name = "shadow"
        shadow.zPosition = 5.5
        addChild(shadow)

        bgmBoolButton.path = Arc(center: CGPoint(x: 0, y: 0), startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false, radius: circleRadius)
        bgmBoolButton.zPosition = 7
        bgmBoolButton.fillTexture = SKTexture(imageNamed: "PieceBackground.png")
        bgmBoolButton.fillColor = .white
        bgmBoolButton.strokeColor = UIColor(.parchmentColor)
        nodelineWidthSetting(node: bgmBoolButton, width: 3)
        nodeNameSetting(node: bgmBoolButton, name: "bgmBoolButton")
//        bgmBoolButton.physicsBody = SKPhysicsBody(polygonFrom: bgmBoolButton.path ?? UIBezierPath(rect: CGRect()).cgPath)
//        bgmBoolButton.physicsBody?.isDynamic = false
        shadow.addChild(bgmBoolButton)

        sfxBoolButton.path = Arc(center: CGPoint(x: 0, y: 0), startAngle: .degrees(0), endAngle: .degrees(-180), clockwise: true, radius: circleRadius)
        sfxBoolButton.zPosition = 7
        sfxBoolButton.fillTexture = SKTexture(imageNamed: "PieceBackground.png")
        sfxBoolButton.fillColor = .white
        sfxBoolButton.strokeColor = UIColor(.parchmentColor)
        nodelineWidthSetting(node: sfxBoolButton, width: 3)
        nodeNameSetting(node: sfxBoolButton, name: "sfxBoolButton")
//        sfxBoolButton.physicsBody = SKPhysicsBody(polygonFrom: bgmBoolButton.path ?? UIBezierPath(rect: CGRect()).cgPath)
//        sfxBoolButton.physicsBody?.isDynamic = false
        shadow.addChild(sfxBoolButton)

        labelSetting(node: bgmLabel, str: "BGM", align: .center, fontSize: CGFloat(frame.maxX * 0.15), fontName: "AppleSDGothicNeo-Regular", pos: CGPoint(x: frame.midX - frame.maxX * 0.25, y: frame.midY+circleRadius * 0.45))
        bgmLabel.verticalAlignmentMode = .center
        labelNodeColor(node: bgmLabel, color: UIColor.white)
        nodeNameSetting(node: bgmLabel, name: "bgmBoolButton")
        bgmLabel.zPosition = 7
        shadow.addChild(bgmLabel)

        labelSetting(node: sfxLabel, str: "SFX", align: .center, fontSize: CGFloat(frame.maxX * 0.15), fontName: "AppleSDGothicNeo-Regular", pos: CGPoint(x: frame.midX - frame.maxX * 0.25, y: frame.midY-circleRadius * 0.45))
        sfxLabel.verticalAlignmentMode = .center
        labelNodeColor(node: sfxLabel, color: UIColor.white)
        sfxLabel.zPosition = 7
        nodeNameSetting(node: sfxLabel, name: "sfxBoolButton")
        shadow.addChild(sfxLabel)
        
        labelSetting(node: bgmBoolLabel, str: SoundActiveStatus(status: bgmBool), align: .center, fontSize: CGFloat(frame.maxX * 0.15), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: frame.midX + frame.maxX * 0.25, y: frame.midY+circleRadius * 0.45))
        bgmBoolLabel.verticalAlignmentMode = .center
        labelNodeColor(node: bgmBoolLabel, color: UIColor.white)
        bgmBoolLabel.zPosition = 7
        nodeNameSetting(node: bgmBoolLabel, name: "bgmBoolButton")
        shadow.addChild(bgmBoolLabel)

        labelSetting(node: sfxBoolLabel, str: SoundActiveStatus(status: sfxBool), align: .center, fontSize: CGFloat(frame.maxX * 0.15), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: frame.midX + frame.maxX * 0.25, y: frame.midY-circleRadius * 0.45))
        sfxBoolLabel.verticalAlignmentMode = .center
        labelNodeColor(node: sfxBoolLabel, color: UIColor.white)
        sfxBoolLabel.zPosition = 7
        nodeNameSetting(node: sfxBoolLabel, name: "sfxBoolButton")
        shadow.addChild(sfxBoolLabel)

        settingPanelDisactive(shadow: shadow, status: true)
        
        CustomizeHaptic.instance.prepareHaptics()
        //https://stackoverflow.com/questions/36380327/addchild-after-2-seconds
        self.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run({
                self.addChild(self.backgroundMusic)
        })]))
        soundVolumeOn(node: backgroundMusic, status: bgmBool)

        gameCenterTriggerSetting(node: gameCenterTrigger, frame: frame)
        addChild(gameCenterTrigger)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if (touchedNode.name == "GameCenterTrigger") {
                GKAccessPoint.shared.trigger {}
            }
            else if (touchedNode.name == "settingButton") {
                settingPanelDisactive(shadow: shadow, status: false)
            } else if (touchedNode.name == "closeButton") {
                settingPanelDisactive(shadow: shadow, status: true)
            } else if (shadow.isHidden == true) {
                if(startButtonPressed == false) {
                    startButtonPressed = true
                    waitAndSceneChange()
                }
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
            }
        }
    }

    func waitAndSceneChange() {
//        backgroundMusic.removeFromParent()
        backgroundMusic.run(SKAction.changeVolume(to: 0, duration: 0.4))
        sfxPlay(soundFileName: "SFX_GoToSelectScene", scene: self)
        haptic_GoSelectScene()
        let wait = SKAction.wait(forDuration: 0.5)
        let action = SKAction.run {
            if let scene = SKScene(fileNamed: "SelectScene") {
                let fade = SKTransition.fade(withDuration: 2)
                for node in self.children {
                    node.removeAllActions()
                    node.removeAllChildren()
                }
                
                self.view?.presentScene(scene, transition: fade)
            }
        }
        let sequence = SKAction.sequence([wait, action])
        background.run(sequence)
    }
}


