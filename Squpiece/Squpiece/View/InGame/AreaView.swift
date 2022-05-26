//
//  AreaView.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/26.
//

import SwiftUI

struct AreaView: View {
    let areaWidth = width * 0.36
    let clickableAreaWidth = width * 0.42
    var body: some View {
        VStack {
            Image(systemName: "plus")
                .resizable()
                .padding()
                .frame(width: areaWidth, height: areaWidth)
        }
    }
}

struct AreaView_Previews: PreviewProvider {
    static var previews: some View {
        AreaView()
    }
}
