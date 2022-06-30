//
//  ButtonSettingFunction.swift
//  Squpiece
//
//  Created by 황정현 on 2022/06/23.
//

import Foundation
import SpriteKit

func setSettingButton(settingButton: SKSpriteNode, frame: CGRect) {
    //https://stackoverflow.com/questions/60641048/change-a-sf-symbol-size-inside-a-uibutton
    let config = UIImage.SymbolConfiguration(pointSize: hasTopNotch == true ? 10 : 14, weight: .semibold, scale: .default)
    let image = UIImage(systemName: "gearshape.fill", withConfiguration: config)!.withTintColor(UIColor(.parchmentColor))
    let data_ = image.pngData()
    let rImage = UIImage(data:data_!)
    settingButton.texture = SKTexture(image: rImage!)
    nodeNameSetting(node: settingButton, name: "settingButton")
    settingButton.size = rImage?.size ?? CGSize(width: 10, height: 10)
    settingButton.position = CGPoint(x: frame.maxX - frame.maxX * 0.16, y: hasTopNotch == true ? frame.maxY - frame.maxX * 0.35 : frame.maxY - frame.maxX * 0.24)
    settingButton.zPosition = 5
}

func setSoundButton(bgmBoolButton: SKShapeNode, sfxBoolButton: SKShapeNode, circleRadius: CGFloat) {
    bgmBoolButton.path = Arc(center: CGPoint(x: 0, y: 0), startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false, radius: circleRadius)
    bgmBoolButton.zPosition = 7
    bgmBoolButton.fillTexture = SKTexture(imageNamed: "PieceBackground.png")
    bgmBoolButton.fillColor = .white
    bgmBoolButton.strokeColor = UIColor(.parchmentColor)
    nodelineWidthSetting(node: bgmBoolButton, width: 3)
    nodeNameSetting(node: bgmBoolButton, name: "bgmBoolButton")

    sfxBoolButton.path = Arc(center: CGPoint(x: 0, y: 0), startAngle: .degrees(0), endAngle: .degrees(-180), clockwise: true, radius: circleRadius)
    sfxBoolButton.zPosition = 7
    sfxBoolButton.fillTexture = SKTexture(imageNamed: "PieceBackground.png")
    sfxBoolButton.fillColor = .white
    sfxBoolButton.strokeColor = UIColor(.parchmentColor)
    nodelineWidthSetting(node: sfxBoolButton, width: 3)
    nodeNameSetting(node: sfxBoolButton, name: "sfxBoolButton")
}

func setSoundLabel(bgmLabel: SKLabelNode, sfxLabel: SKLabelNode, circleRadius: CGFloat, frame: CGRect) {
    labelSetting(node: bgmLabel, str: "BGM", align: .center, fontSize: CGFloat(frame.maxX * 0.15), fontName: "AppleSDGothicNeo-Regular", pos: CGPoint(x: frame.midX - frame.maxX * 0.25, y: frame.midY+circleRadius * 0.45))
    bgmLabel.verticalAlignmentMode = .center
    labelNodeColor(node: bgmLabel, color: UIColor.white)
    nodeNameSetting(node: bgmLabel, name: "bgmBoolButton")
    bgmLabel.zPosition = 7

    labelSetting(node: sfxLabel, str: "SFX", align: .center, fontSize: CGFloat(frame.maxX * 0.15), fontName: "AppleSDGothicNeo-Regular", pos: CGPoint(x: frame.midX - frame.maxX * 0.25, y: frame.midY-circleRadius * 0.45))
    sfxLabel.verticalAlignmentMode = .center
    labelNodeColor(node: sfxLabel, color: UIColor.white)
    sfxLabel.zPosition = 7
    nodeNameSetting(node: sfxLabel, name: "sfxBoolButton")
}

func setSoundBoolLabel(bgmBoolLabel: SKLabelNode, sfxBoolLabel: SKLabelNode, circleRadius: CGFloat, frame: CGRect) {
    labelSetting(node: bgmBoolLabel, str: SoundActiveStatus(status: bgmBool), align: .center, fontSize: CGFloat(frame.maxX * 0.15), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: frame.midX + frame.maxX * 0.25, y: frame.midY+circleRadius * 0.45))
    bgmBoolLabel.verticalAlignmentMode = .center
    labelNodeColor(node: bgmBoolLabel, color: UIColor.white)
    bgmBoolLabel.zPosition = 7
    nodeNameSetting(node: bgmBoolLabel, name: "bgmBoolButton")

    labelSetting(node: sfxBoolLabel, str: SoundActiveStatus(status: sfxBool), align: .center, fontSize: CGFloat(frame.maxX * 0.15), fontName: "AppleSDGothicNeo-Bold", pos: CGPoint(x: frame.midX + frame.maxX * 0.25, y: frame.midY-circleRadius * 0.45))
    sfxBoolLabel.verticalAlignmentMode = .center
    labelNodeColor(node: sfxBoolLabel, color: UIColor.white)
    sfxBoolLabel.zPosition = 7
    nodeNameSetting(node: sfxBoolLabel, name: "sfxBoolButton")
}

func settingPanelDisactive(shadow: SKShapeNode, status: Bool) {
    shadow.isHidden = status
}

func boolButtonStatusChangeTo(node: SKLabelNode, status: Bool) {
    node.text = SoundActiveStatus(status: status)
}
func SoundActiveStatus(status: Bool) -> String {
    return status == true ? "ON" : "OFF"
}

func gameCenterTriggerSetting(node: SKSpriteNode, frame: CGRect) {
    let config = UIImage.SymbolConfiguration(pointSize: hasTopNotch == true ? 10 : 14, weight: .semibold, scale: .default)
    let image = UIImage(systemName: "crown", withConfiguration: config)!.withTintColor(UIColor(.parchmentColor))
    let data_ = image.pngData()
    let rImage = UIImage(data:data_!)
    node.texture = SKTexture(image: rImage!)
    nodeNameSetting(node: node, name: "GameCenterTrigger")
    node.size = rImage?.size ?? CGSize(width: 10, height: 10)
    node.position = CGPoint(x: frame.minX + frame.maxX * 0.2, y: hasTopNotch == true ? frame.maxY - frame.maxX * 0.35 : frame.maxY - frame.maxX * 0.24)
    node.zPosition = 8
}
