//
//  GameViewController.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/28.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            
            //view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
            
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
}
