//
//  HealthFitnessView.swift
//  ASF
//
//  Created by Jenil Rughani on 26/03/25.
//

import SwiftUI
import Kingfisher

struct HealthFitnessView: View {
    var img: String
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: img))
                .resizable()
                .frame(height: 250)
                .frame(maxWidth: .infinity)
                .scaledToFit()
                .cornerRadius(radius: 15, corners: [.topLeft, .topRight])
            
            Text(title)
                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                .padding()
            
            Text("By ASF")
                .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 16))
                .foregroundStyle(.gray)
                .padding([.horizontal, .bottom])
        }
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .shadow(radius: 5)
        }
        .padding()
    }
}

#Preview {
    HealthFitnessView(img: "https://www.eatingwell.com/thmb/81ypzinmbpC6zKmIBmVNCtbydpo=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/weight-loss-habit-mar-2025-39f7899763294421b8975350316d9a56.jpg", title: "Challenges in reading research as a multilingual author")
}
