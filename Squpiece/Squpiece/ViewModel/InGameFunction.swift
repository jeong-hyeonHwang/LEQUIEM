//
//  InGameFunction.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/31.
//

import Foundation
import SpriteKit

//https://www.hackingwithswift.com/example-code/language/how-to-convert-radians-to-degrees
func rad2deg(_ number: Double) -> Double {
    return number * 180 / .pi
}

func rotationRestartAction(node: SKNode, rotateNodes: [SKNode]) {
    
    for node in rotateNodes {
        node.removeAction(forKey: "Rotation")
    }
    rotateAction(rotateNodes)
    let wait = SKAction.wait(forDuration: 2)
    let action = SKAction.run {
        rotationStop = false
    }
    let sequence = SKAction.sequence([wait, action])
    node.run(sequence)
}

func randomRestartAction(node: SKNode) {
    let wait = SKAction.wait(forDuration: 2)
    let action = SKAction.run {
        randomStop = false
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

func labelScaleAction (node: SKNode) {
    node.alpha = 1.0
    let to = SKAction.scale(to: 1.2, duration: 0.05)
    let end = SKAction.scale(to: 1.0, duration: 0.05)
    let fadeOut = SKAction.fadeOut(withDuration: 0.2)
    let sequence = SKAction.sequence([to, end, fadeOut])

    node.run(sequence)
}

func shadowDisappear(node: SKNode, labels: [SKNode]) {
    
    for label in labels {
        label.alpha = 0.0
    }
    let shadowAppear = SKAction.run {
        node.alpha = 1.0
        node.isHidden = false
    }
    //let wait = SKAction.wait(forDuration: waitSec - 0.2)
    let fadeOut = SKAction.fadeOut(withDuration: waitSec/2)
    let shadowDisappear = SKAction.run {
        labelAppear(labels: labels)
        node.isHidden = true
        node.alpha = 0.8
    }
    
    //let sequence = SKAction.sequence([shadowAppear, wait, fadeOut, shadowDisappear])
    let sequence = SKAction.sequence([shadowAppear, fadeOut, shadowDisappear])
    node.run(sequence)
}

func shadowAppear(node: SKNode, hiddenNodes: [SKNode]) {
    node.alpha = 0.0
    node.isHidden = false
    let fadeIn = SKAction.fadeIn(withDuration: waitSec/2)
    let shadowAppear = SKAction.run {
        for node in hiddenNodes {
            node.isHidden = false
        }
    }
    let sequence = SKAction.sequence([fadeIn, shadowAppear])
    node.run(sequence)
}

func labelAppear(labels: [SKNode]) {
    
    for label in labels {
        label.alpha = 0.0
        label.isHidden = false
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.15)
        label.run(fadeIn)
    }
}

func pieceRotation (node: SKShapeNode, index: Int) {
    let rotateAction = SKAction.rotate(toAngle: 2 * .pi/CGFloat(numberOfPiece) * CGFloat(index), duration: 0)
    node.run(rotateAction)
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

func resetVar() {
    change = false
    touched = false
    
    rotationStop =  false
    randomStop = false
    
    degree = Double(55)
}
