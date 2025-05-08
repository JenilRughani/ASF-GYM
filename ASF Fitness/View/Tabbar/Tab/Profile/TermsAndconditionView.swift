//
//  TermsAndconditionView.swift
//  ASF
//
//  Created by Jenil Rughani on 22/03/25.
//

import SwiftUI

struct TermsAndconditionView: View {
    var body: some View {
        VStack {
            BackView()
            
            HStack(content: {
                Text("Terms & Policy")
                    .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 35))
                
                Spacer()
            })
            .padding()
            
            ScrollView(showsIndicators: false) {
                Image("backImage")
                    .resizable()
                    .scaledToFill()
                    .overlay {
                        Color.black.opacity(0.25)
                            .overlay {
                                Image("ASF")
                                    .resizable()
                                    .scaledToFit()
                                                .frame(width: 130)
                                    .foregroundStyle(.white)
                            }
                    }
                
                Text("""
These terms and conditions for a website set out key issues such as acceptable use, privacy, cookies, registration and passwords, intellectual property, links to other sites, termination and disclaimers of responsibility.
""")
                .padding()
                
                HStack {
                    Text("These terms and conditions for a website set out key issues")
                        .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                        .padding(.horizontal)
                    
                    Spacer()
                }
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris quis quis aenean cursus parturient. Integer dui donec sapien elit. Habitant tristique accumsan, id dictumst ")
                    .padding()
                
                HStack {
                    Text("Usage Restrictions")
                        .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                        .padding(.horizontal)
                        
                    Spacer()
                }
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris quis quis aenean cursus parturient. Integer dui donec sapien elit. Habitant tristique accumsan, id dictumst ")
                    .padding()
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris quis quis aenean cursus parturient. Integer dui donec sapien elit. Habitant tristique accumsan, id dictumst ")
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    TermsAndconditionView()
}
