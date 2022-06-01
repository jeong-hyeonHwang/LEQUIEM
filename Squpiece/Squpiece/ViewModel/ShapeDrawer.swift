//
//  ShapeDrawer.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/31.
//

import SwiftUI

//func timerBar(center: CGPoint, value: Angle, radius: CGFloat) -> CGPath {
//    var path = Path()
//    path.addLines([center])
//    path.addArc(center: center, radius: radius, startAngle: .degrees(90) - value, endAngle: .degrees(90) + value, clockwise: false)
//    path.addLine(to: center)
//    return path.cgPath
//}

func timerBar(center: CGPoint, startAngle: Angle, radius: CGFloat) -> CGPath {
    var path = Path()
    path.addLines([center])
    path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: .degrees(125), clockwise: false)
    path.addLine(to: center)
    return path.cgPath
}

//https://gist.github.com/KanshuYokoo/a78223ffec27319a548d52dc09b660e4
func Arc(center: CGPoint, startAngle: Angle, endAngle: Angle, clockwise: Bool, radius: CGFloat) -> CGPath {
    var path = Path()
    path.addLines([center])
    path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    path.addLine(to: center)
    return path.cgPath
}

func Cir(center: CGPoint, radius: CGFloat) -> CGPath {
    var path = Path()
    path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
    return path.cgPath
}

func Rect(startPosition: CGPoint, xSize: CGFloat, ySize: CGFloat) -> CGPath {
    var path = Path()
    path.addRect(CGRect(x: startPosition.x, y: startPosition.y, width: xSize, height: ySize))
    return path.cgPath
}
