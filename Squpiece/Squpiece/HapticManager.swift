//
//  HapticManager.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/30.
//

import SwiftUI

//https://seons-dev.tistory.com/entry/SwiftUI-Haptic-Feedback-haptics-vibrations
class HapticManager {
    
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
