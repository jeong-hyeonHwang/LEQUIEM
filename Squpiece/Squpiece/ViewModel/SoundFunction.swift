//
//  SoundFunction.swift
//  Squpiece
//
//  Created by 황정현 on 2022/06/23.
//

import SpriteKit

func backgroundMusicPlay(node: SKAudioNode) {
    let waitASec = SKAction.wait(forDuration: 1)
    let play = SKAction.run {
        node.run(SKAction.play())
    }
    let wait = SKAction.wait(forDuration: 65)
    let sequence = SKAction.sequence([play, wait])
    let repeatSequence = SKAction.repeatForever(sequence)
    let lastResult = SKAction.sequence([waitASec, repeatSequence])
    
    node.run(lastResult)
}

func sfxPlay(soundFileName: String, scene: SKScene) {
    let gotoGameSceneSFX = SKAction.playSoundFileNamed("\(soundFileName).mp3", waitForCompletion: false)
    scene.run(gotoGameSceneSFX)
}
