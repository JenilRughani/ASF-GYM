//
//  OnBoardingView.swift
//  ASF
//
//  Created by Jenil Rughani on 22/03/23.
//

import SwiftUI

struct WalkthroughView: View {
    
    @State var image: String
    @State var title: String
    @State var description: String
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Image(image)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 20)
                .padding(.bottom)
            
            Text(title)
                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 28))
                .padding(.bottom, 17)
            
            Text(description)
                .multilineTextAlignment(.center)
                .font(.caustenFont(customFontName: .CaustenRegular, fontSize: 16))
            
            Spacer()
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughView(image: "onBordingImg1", title: "Testing Title", description: "This is Sample Paragraph. This is Sample Paragraph This is Sample Paragraph This is Sample Paragraph This is Sample Paragraph")
    }
}
