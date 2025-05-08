//
//  ForgotPasswordView.swift
//  ASF
//
//  Created by Jenil Rughani on 10/03/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email: String = ""
    
    var body: some View {
        VStack {
            BackView()
            
            Spacer()
            
            Image("forgot-password")
                .resizable()
                .frame(width: 78, height: 78)
                .padding()
            
            Text("Forgot Password?")
                .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 28))
                .padding(.bottom, 5)
            
            Text("Please enter the email or phone\n number. We will send you OTP for\n reset your password. ?")
                .foregroundStyle(.gray)
                .font(Font.caustenFont(customFontName: .CaustenRegular, fontSize: 18))
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .padding(.bottom)
            
            TextField("Email", text: $email)
                .padding()
                .foregroundColor(.black)
                .autocorrectionDisabled(true)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .background {
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(!email.isEmpty ? Color("bluePurple") : .clear , lineWidth: !email.isEmpty ?  3 : 0)
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color(UIColor(named: "textfileColor")!).opacity(0.95))
                }
                .padding(.horizontal)
            
            Button(action: {
                
            }, label: {
                Text("Login")
                    .font(.title3)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
            })
            .background{
                Capsule()
                    .fill(Color("bluePurple"))
            }
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    ForgotPasswordView()
}
