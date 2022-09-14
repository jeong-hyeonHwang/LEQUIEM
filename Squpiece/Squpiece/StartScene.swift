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

final class StartScene: SKScene {

    private let tapToStartLabel = SKLabelNode()
    private let background = SKSpriteNode()
    private let backgroundMusic = SKAudioNode(fileNamed: "Lequiem.mp3")
    private var startButtonPressed = false
    
    // MARK: Setting Panel Components
    private let settingButton = SKSpriteNode()
    private let closeButton = SKSpriteNode()
    private let shadow = SKShapeNode()
    private let bgmBoolButton = SKShapeNode()
    private let sfxBoolButton = SKShapeNode()
    private let bgmLabel = SKLabelNode()
    private let bgmBoolLabel = SKLabelNode()
    private let sfxLabel = SKLabelNode()
    private let sfxBoolLabel = SKLabelNode()

    private let gameCenterTrigger = SKSpriteNode()
    
    private var buttonEnabled = false
    
    override func didMove(to view: SKView) {
        
        GameKitHelper.sharedInstance.authenticateLocalPlayer(view: self.view!)
        
        let circleRadius = frame.maxX * 0.8
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
        
        let symbolPattern = SKSpriteNode(imageNamed: "Pattern_.png")
        symbolPattern.size = CGSize(width: frame.width * 0.9, height: frame.width * 0.9)
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
        
        setSettingButton(settingButton: settingButton, frame: frame)
        addChild(settingButton)


        //https://stackoverflow.com/questions/60641048/change-a-sf-symbol-size-inside-a-uibutton
        let config = UIImage.SymbolConfiguration(pointSize: 10, weight: .semibold, scale: .default)
        let image = UIImage(systemName: "xmark", withConfiguration: config)!.withTintColor(UIColor(.parchmentColor))
        let data_ = image.pngData()
        let rImage = UIImage(data:data_!)
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

        settingPanelDisactive(shadow: shadow, status: true)
        
        CustomizeHaptic.instance.prepareHaptics()
        //https://stackoverflow.com/questions/36380327/addchild-after-2-seconds
        self.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run({
                self.addChild(self.backgroundMusic)
            soundVolumeOn(node: self.backgroundMusic, status: bgmBool)
        })]))

        gameCenterTriggerSetting(node: gameCenterTrigger, frame: frame)
        addChild(gameCenterTrigger)
        
        appear(startButton: tapToStartLabel)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if (touchedNode.name == "GameCenterTrigger") {
                if GKLocalPlayer.local.isAuthenticated {
                    GKAccessPoint.shared.trigger {}
                }
            }
            else if (touchedNode.name == "settingButton") {
                settingPanelDisactive(shadow: shadow, status: false)
            } else if (touchedNode.name == "closeButton") {
                settingPanelDisactive(shadow: shadow, status: true)
            } else if (shadow.isHidden == true && buttonEnabled == true) {
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
    
    private func appear(startButton: SKLabelNode) {
        startButton.alpha = 0
        let wait = SKAction.wait(forDuration: 1.3)
        let fadeIn = SKAction.fadeIn(withDuration: 0.3)
        let blinkAction = SKAction.run { [self] in
            buttonEnabled = true
            blinkEffect(node: startButton, duration: 0.8)
        }
        let sequence = SKAction.sequence([wait, fadeIn, blinkAction])
        startButton.run(sequence)
    }
}

extension StartScene {
    private func waitAndSceneChange() {
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


