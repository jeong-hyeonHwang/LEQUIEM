//
//  ButtonSettingFunction.swift
//  Squpiece
//
//  Created by 황정현 on 2022/06/23.
//

import Foundation
import SpriteKit

func setSettingButton(settingButton: SKSpriteNode, frame: CGRect) {
    let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .semibold, scale: .default)
    let image = UIImage(systemName: "gearshape.fill", withConfiguration: config)!.withTintColor(UIColor(.parchmentColor))
    let data_ = image.pngData()
    let rImage = UIImage(data:data_!)
    settingButton.texture = SKTexture(image: rImage!)
    nodeNameSetting(node: settingButton, name: "settingButton")
    settingButton.size = rImage?.size ?? CGSize(width: 10, height: 10)
    settingButton.position = CGPoint(x: frame.maxX - frame.maxX * 0.16, y: frame.maxY - frame.maxX * 0.24)
    settingButton.zPosition = 5
}
