//
//  ScoreView.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/26.
//

import SwiftUI

struct ScoreView: View {
    var body: some View {
        VStack {
            Text("8506000")
                .font(.system(size: 32, weight: .regular))
                .padding()
                .frame(width: width * 0.8, alignment: .leading)
                .minimumScaleFactor(fontFactor)
        }.frame(width: width * 0.8, alignment: .center)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
