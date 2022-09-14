//
//  GameViewController.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/28.
//

import AVFAudio
import GameplayKit
import SpriteKit
import UIKit

final class GameViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //https://stackoverflow.com/questions/29024320/how-can-i-allow-background-music-to-continue-playing-while-my-app-still-plays-it
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        try? AVAudioSession.sharedInstance().setActive(true)
        
        //https://stackoverflow.com/questions/66037782/swiftui-how-do-i-lock-a-particular-view-in-portrait-mode-whilst-allowing-others
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        AppDelegate.orientationLock = .portrait
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "StartScene") {
                let fade = SKTransition.fade(withDuration: 2)
                // Present the scene
                view.presentScene(scene, transition: fade)
            }
            
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
            
        }
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
}
