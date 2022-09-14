//
//  StartScene+.swift
//  Squpiece
//
//  Created by 황정현 on 2022/09/14.
//

import SpriteKit

extension StartScene {
    func blinkEffect(node: SKNode, duration: CGFloat) {
        let fadeOut = SKAction.fadeOut(withDuration: duration)
        let wait = SKAction.wait(forDuration: duration * 0.25)
        let fadeIn = SKAction.fadeIn(withDuration: duration)
        let sequence = SKAction.sequence([fadeOut, wait, fadeIn])
        let repeatSeq = SKAction.repeatForever(sequence)
        node.run(repeatSeq)
    }
}
