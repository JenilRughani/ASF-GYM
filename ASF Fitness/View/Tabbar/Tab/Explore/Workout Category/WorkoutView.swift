//
//  WorkoutView.swift
//  ASF
//
//  Created by Jenil Rughani on 13/03/25.
//

import SwiftUI

struct WorkoutView: View {
    
    var name: String
    var img: String
    var color: LinearGradient
    
    var body: some View {
        VStack {
            Text(name)
                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 23))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 120)
           
            Image(img)
                .resizable()
                .frame(width: 90, height: 130)
                .scaledToFit()
        }
        .padding(25)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(color)
                .frame(width: 171, height: 232)
        }
        .shadow(radius: 5)
    }
}

#Preview {
    WorkoutView(name: "Full Body Strength", img: "ex1", color: LinearGradient(colors: [.orange, .orange, .yellow], startPoint: .topTrailing, endPoint: .bottomLeading))
}
