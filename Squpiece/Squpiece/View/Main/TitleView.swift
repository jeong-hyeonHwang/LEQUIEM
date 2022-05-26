//
//  TitleView.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/26.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        HStack {
            Text("SQUPIECE")
                .font(.system(size: 60, weight: .heavy))
                .minimumScaleFactor(fontFactor)
        }.frame(width: width, height: height * 0.25, alignment: .bottom)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
