//
//  GuidanceAndTipsView.swift
//  ASF
//
//  Created by Jenil Rughani on 13/03/25.
//

import SwiftUI

struct GuidanceAndTipsView: View {
    
    var img: String
    var name: String
    var action: (() -> ())
    
    var body: some View {
        VStack {
            Image(img)
                .resizable()
                .scaledToFit()
                .frame(height: 110)
                .foregroundStyle(.pink)
                
            Text(name)
                .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 18))
                .multilineTextAlignment(.center)
            
            Button(action: {
                action()
            }, label: {
                Image(systemName: "arrow.right")
                    .foregroundColor(.black)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.white)
                            .frame(width: 56, height: 31)
                            .shadow(radius: 1)
                    }
            })
        }
        .offset(y: 26)
        .background {
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
                .frame(width: 171, height: 227)
                .shadow(radius: 3)
        }
        .padding(.horizontal)
    }
}

#Preview {
    GuidanceAndTipsView(img: "Nutritio", name: "Nutrition\n Guidance", action: {
        dump("print")
    })
}
