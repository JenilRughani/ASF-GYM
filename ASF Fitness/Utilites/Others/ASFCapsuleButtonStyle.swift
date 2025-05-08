//
//  RedCapsuleButtonStyle.swift
//  ASF
//
//  Created by Jenil Rughani on 22/03/23.
//

import SwiftUI

struct ASFCapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(content: {
                Capsule()
                    .fill(Color("bluePurple"))
                    .opacity(configuration.isPressed ? 0.25 : 1)
                    .frame(height: 52)
            })
    }
}
