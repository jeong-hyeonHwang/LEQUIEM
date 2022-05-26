//
//  GameTopView.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/26.
//

import SwiftUI

struct GameTopView: View {
    var body: some View {
        HStack(spacing: 0) {
            ScoreView()
            StopButtonView()
                .frame(width: width * 0.2)
        }
    }
}

struct GameTopView_Previews: PreviewProvider {
    static var previews: some View {
        GameTopView()
    }
}
