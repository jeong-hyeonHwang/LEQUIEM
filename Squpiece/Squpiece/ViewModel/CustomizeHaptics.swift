//
//  CustomizeHaptics.swift
//  Squpiece
//
//  Created by 황정현 on 2022/06/22.
//

import Foundation

func haptic_ChangeStage() {
    let haptic = HapticProperty(count: 1, interval: [0.0], intensity: [0.6], sharpness: [0.6])
    playCustomHaptic(hapticType: Haptic.transient, hapticProperty: haptic)
}

func haptic_GoSelectScene() {
    let haptic = HapticProperty(count: 3, interval: [0, 0.1, 0.1], intensity: [0.8, 0.5, 0.3], sharpness: [0.6, 0.5, 0.75])
    playCustomHaptic(hapticType: Haptic.transient, hapticProperty: haptic)
}

func haptic_GoGameScene() {
    let haptic = HapticProperty(count: 1, interval: [0.04], intensity: [0.5], sharpness: [0.5])
    playCustomHaptic(hapticType: Haptic.dynamic, hapticProperty: haptic)
}
