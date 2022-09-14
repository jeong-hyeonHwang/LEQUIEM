//
//  ShapeDrawer.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/31.
//

import SwiftUI

//https://gist.github.com/KanshuYokoo/a78223ffec27319a548d52dc09b660e4
func Arc(center: CGPoint, startAngle: Angle, endAngle: Angle, clockwise: Bool, radius: CGFloat) -> CGPath {
    var path = Path()
    path.addLines([center])
    path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    path.addLine(to: center)
    return path.cgPath
}

func Donut_(center: CGPoint, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool, radius: CGFloat, width: CGFloat) -> CGPath {
    var path = Path()
    let s: CGFloat = CGFloat(startAngle) * .pi / 180
    let e = CGFloat(endAngle) * .pi / 180
    let sA: Angle = .degrees(startAngle)
    let eA: Angle = .degrees(endAngle)
    path.move(to: CGPoint(x: radius * cos(s), y: radius * sin(s)))
    path.addArc(center: center, radius: radius-width, startAngle: sA, endAngle: eA, clockwise: clockwise)
    path.addLine(to: CGPoint(x: radius * cos(e), y: radius * sin(e)))
    path.addArc(center: center, radius: radius, startAngle: eA, endAngle: sA, clockwise: !clockwise)
    path.addLine(to: CGPoint(x: (radius-width) * cos(s), y: (radius-width) * sin(s)))
    return path.cgPath
}

func Donut(center: CGPoint, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool, radius: CGFloat, width: CGFloat) -> CGPath {
    var path = Path()
    let s: CGFloat = CGFloat(startAngle) * .pi / 180
    let e = CGFloat(endAngle) * .pi / 180
    let sA: Angle = .degrees(startAngle)
    let eA: Angle = .degrees(endAngle)
    path.addArc(center: center, radius: radius-width, startAngle: sA, endAngle: eA, clockwise: clockwise)
    path.addLine(to: CGPoint(x: radius * cos(e), y: radius * sin(e)))
    path.addArc(center: center, radius: radius, startAngle: eA, endAngle: sA, clockwise: !clockwise)
    path.addLine(to: CGPoint(x: (radius-width) * cos(s), y: (radius-width) * sin(s)))
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
