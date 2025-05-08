//
//  WelcomeView.swift
//  ASF
//
//  Created by Jenil Rughani on 02/04/25.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var isLogin: Bool = false
    @State private var isRegister: Bool = false
    @State private var isLoading: Bool = false
    @State private var isEmptyAlert: Bool = false
    @State private var isSignUp: Bool? = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var googleAuthVM : GoogleAutheticationViewModel
    private var heightAndWidth: CGFloat = 25
    private var colors: [Color] = [Color("lightPink"), Color("lightBlue"), Color("lightYellow"), .white, .white]
    
    var body: some View {
        ZStack {
            
            Image("SignINSample_Back")
                .resizable()
                .scaledToFit()
                .offset(y: -logicalHeight/5.5)
            
            VStack {
                
                Spacer()
                
                VStack(spacing: 10) {
                    
                    Image("app_degine_icone_remove_bg")
                        .resizable()
                        .frame(width: 160, height: 160)
                    
                    VStack(spacing: 0) {
                        Text("Welcome to")
                            .font(.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                        
                        Text("AI Strength Factory")
                            .font(.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                            .foregroundStyle(.purple)
                    }
                    .padding(.bottom)
                    
                    Text("just a few clicks, you can find a workout\n that fits your schedule and start exercising\n right away.")
                        .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 16))
                        .foregroundStyle(.gray)
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                    
                    
                    //MARK: - Google Authentication
                    Button {
                        googleAuthVM.signIn()
                    } label: {
                        HStack {
                            Image("google")
                                .resizable()
                                .frame(width: heightAndWidth, height: heightAndWidth)
                            
                            Text("Google")
                                .foregroundStyle(.black)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background{
                        Capsule()
                            .fill(Color(uiColor: UIColor(named: "textfileColor")!))
                            .shadow(radius: 1)
                    }
                    .alert("Alert", isPresented: $googleAuthVM.isAlert) {
                        Button("OK", role: .cancel) {
                            dismiss.callAsFunction()
                        }
                    } message: {
                        Text(googleAuthVM.errorMessage)
                    }
                    .navigationDestination(isPresented: $googleAuthVM.isLogin) {
                        ASFTabbarView()
                            .navigationBarBackButtonHidden()
                    }
                    .padding(.top)
                }
                .padding()
                .background {
                    Rectangle()
                        .fill(.white)
                        .cornerRadius(radius: 35, corners: [.topLeft, .topRight])
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(GoogleAutheticationViewModel())
        .environmentObject(EmailAuthenticationViewModel())
}
