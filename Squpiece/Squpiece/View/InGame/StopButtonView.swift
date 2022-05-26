//
//  StopButtonView.swift
//  Squpiece
//
//  Created by 황정현 on 2022/05/26.
//

import SwiftUI

struct StopButtonView: View {
    var body: some View {
        let buttonWidth = width * 0.1
        Button(action: {
            print("STOP BUTTON PRESSED")
        })
        {
            Image(systemName: "pause.circle.fill")
                .resizable()
                .frame(width: buttonWidth, height: buttonWidth)
                .padding()
        }
    }
}

struct StopButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StopButtonView()
    }
}
