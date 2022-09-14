//
//  Variables.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/31.
//

import SwiftUI

var change = false
var touched = false

var rotateAngle: CGFloat = 5
var rotationStop =  false
var randomStop = false

var waitSec: Double = 1

var numberOfPiece: Int = 2

let bgColor = UIColor(.bgColor)

let pieceName: [String] = ["Pattern_D3", "Pattern_EH", "Pattern_S", "Pattern_F", "Pattern_T", "Pattern_A"]
let leaderBoardName: [String] = ["I_Record", "T_Record", "A_Record", "E_Record", "FINAL_Record"]

//https://stackoverflow.com/questions/52402477/ios-detect-if-the-device-is-iphone-x-family-frameless
var hasTopNotch: Bool {
    if #available(iOS 11.0, tvOS 11.0, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    return false
}

var bgmBool = dataGetB(key: "bgmBool")
var sfxBool = dataGetB(key: "sfxBool")
