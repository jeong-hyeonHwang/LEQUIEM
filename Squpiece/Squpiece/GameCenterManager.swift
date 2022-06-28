//
//  GameCenterManager.swift
//  Squpiece
//
//  Created by 황정현 on 2022/06/28.
//

import GameKit
import Foundation

//https://www.johndav.com/zer0ed/adding-game-center-integration-to-spritekit-game
let singleton = GameKitHelper()


class GameKitHelper: NSObject, GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    
    static let PresentAuthenticationViewController = "PresentAuthenticationViewController"
     
    
    var authenticationViewController: UIViewController?
    var lastError: NSError?

    var gameCenterEnabled: Bool
    
    override init() { gameCenterEnabled = true
        super.init()
    }
    
    func ResetAchievements() {
        
        if GKLocalPlayer.local.isAuthenticated {
            
            let localPlayer = GKLocalPlayer.local
            
            if localPlayer.isAuthenticated {
                
            GKAchievement.resetAchievements(completionHandler: {(error : Error?) -> Void in
                if error != nil {
                    print("error")
                }
                else {
                    print("Achievements Reset?")
                }
            })
        }
        
        }
    }
    
    func authenticateLocalPlayer (view: SKView) {
           print("authenticating!")
           let localPlayer = GKLocalPlayer.local
           
                   localPlayer.authenticateHandler = {(viewController, error) -> Void in
           
                       if (viewController != nil) {
                           let vc: UIViewController = view.window!.rootViewController!
                           vc.present(viewController!, animated: true, completion: nil)
                       }
                       else if localPlayer.isAuthenticated {
                           self.gameCenterEnabled = true
                           print((GKLocalPlayer.local.isAuthenticated))
                       } else {
                           self.gameCenterEnabled = false
                           print("User not authenticated")
                       }
                   }
       }
       
    
    func showLeader(view: UIViewController) {
        
        if GKLocalPlayer.local.isAuthenticated {
                  
            let localPlayer = GKLocalPlayer.local
                   
            if localPlayer.isAuthenticated {
        
                let vc = view
                let gc = GKGameCenterViewController()
                gc.gameCenterDelegate = self
                vc.present(gc, animated: true, completion: nil)
                            
            }
        }
    }
    
    func reportAchievements(achievements: [GKAchievement]) {
        
        if !gameCenterEnabled {
            print("Local player is not authenticated")
            return
        }
        GKAchievement.report(achievements, withCompletionHandler: {(error : Error?) -> Void in
            if error != nil {
                print("error")
            }
            else {
                print("acheivements reported")
            }
        })
        
    }
    
    func reportScore(highScoreValue: Int, leaderboardIDs: String) {
        if !gameCenterEnabled {
            print("Local player is not authenticated")
            return
        }
        if GKLocalPlayer.local.isAuthenticated {
            GKLeaderboard.submitScore(
                highScoreValue,
                context: 0,
                player: GKLocalPlayer.local,
                leaderboardIDs: [leaderboardIDs]
            ) { error in
                print(error)
            }
        }
    }
    
   
    class var sharedInstance: GameKitHelper { return singleton
    }
}
