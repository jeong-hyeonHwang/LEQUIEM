//
//  StartButtonView.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/26.
//

import SwiftUI

struct StartButtonView: View {
    var body: some View {
        HStack {
            Button(action: {
                print("hi")
            })
            {
                Text("START")
                    .font(.system(size: 40, weight: .semibold))
                    .minimumScaleFactor(fontFactor)
                    .foregroundColor(Color.textColor)
                    .padding()
            }
        }.frame(width: width, height: height * 0.25, alignment: .top)
    }
}

struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView()
    }
}
