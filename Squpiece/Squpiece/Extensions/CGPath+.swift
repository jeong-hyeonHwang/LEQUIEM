//
//  CGPath+.swift
//  Squpiece
//
//  Created by 황정현 on 2022/09/14.
//

import UIKit

extension CGPath {
    func arcWithWidth(center: CGPoint, start:CGFloat, end:CGFloat, radius:CGFloat, clockwise:Bool) -> UIBezierPath {
        // The radius parameter specifies the middle of the arc; adjust this as needed

        // Note the arc is upside down because CGPath uses UIKit coordinates
        let path = UIBezierPath()
        // Add inner ring.
        path.addArc(withCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        path.addLine(to: center)
        path.close()

        return path
    }
}
