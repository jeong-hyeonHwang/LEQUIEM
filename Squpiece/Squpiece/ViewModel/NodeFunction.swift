//
//  NodeFunction.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/31.
//

import SpriteKit

func labelSetting(node: SKLabelNode, str: String, align: SKLabelHorizontalAlignmentMode, fontSize: CGFloat, fontName: String, pos: CGPoint) {
    //https://www.hackingwithswift.com/example-code/games/how-to-write-text-using-sklabelnode
    node.text = str
    node.horizontalAlignmentMode = align
    node.fontSize = fontSize
    node.fontName = fontName
    node.position =  pos
}

func shapeNodeColorSetting(node: SKShapeNode, fillColor: UIColor, strokeColor: UIColor) {
    node.fillColor = fillColor
    node.strokeColor = strokeColor
}

func labelNodeColor(node: SKLabelNode, color: UIColor) {
    node.fontColor = color
}

func nodeNameSetting(node: SKNode, name: String) {
    node.name = name
}

func nodelineWidthSetting(node: SKShapeNode, width: CGFloat) {
    node.lineWidth = width
}
