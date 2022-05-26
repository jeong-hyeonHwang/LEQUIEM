//
//  TouchableAreaView.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/26.
//

import SwiftUI

struct TouchableAreaView: View {
    var body: some View {
        VStack(spacing: areaSpace) {
            HStack (spacing: areaSpace) {
                AreaView()
                AreaView()
            }
            HStack(spacing: areaSpace) {
                AreaView()
                AreaView()
            }
        }
    }
}

struct TouchableAreaView_Previews: PreviewProvider {
    static var previews: some View {
        TouchableAreaView()
    }
}
