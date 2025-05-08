//
//  SignInView.swift
//  ASF
//
//  Created by Jenil Rughani on 21/03/23.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isShowPass: Bool = false
    @State private var isLoading: Bool = false
    private var heightAndWidth: CGFloat = 25
    private var colors: [Color] = [Color("lightPink"), Color("lightBlue"), Color("lightYellow"), .white, .white]
    
    @EnvironmentObject var emailAuthVM : EmailAuthenticationViewModel
    @EnvironmentObject var googleAuthVM : GoogleAutheticationViewModel
    
    @State private var isEmptyAlert: Bool = false
    @State private var isSignUp: Bool? = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                
                BackView()
                
                Spacer()
                
                Image("app_degine_icone_remove_bg")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .scaledToFit()
                
                Spacer()
                
                HStack() {
                    VStack(alignment: .leading) {
                        Text("SIGN IN")
                            .font(.caustenFont(customFontName: .CaustenBold, fontSize: 35))
                        Text("AI STRENGTH FACTORY")
                            .font(.caustenFont(customFontName: .CaustenBold, fontSize: 23))
                            .foregroundStyle(.purple)
                    }
                    
                    Spacer()
                }
                .padding()
                
                VStack(spacing: 10) {
                    
                    VStack {
                        //MARK: - email Textfile
                        TextField("Email", text: $email)
                            .padding()
                            .foregroundColor(.black)
                            .textContentType(.emailAddress)
                            .autocorrectionDisabled(true)
                            .keyboardType(.emailAddress)
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                            }
                            .padding(.vertical)
                            .onChange(of: email) { oldValue, newValue in
                                email = newValue.lowercased()
                            }
                        
                        //MARK: - password
                        if isShowPass {
                            HStack {
                                TextField("Password", text: $password)
                                    .padding()
                                    .foregroundColor(.black)
                                    .autocorrectionDisabled(true)
                                    .textContentType(.password)
                                    .keyboardType(.namePhonePad)
                                    .textInputAutocapitalization(.never)
                                Image(systemName: isShowPass ? "eye.slash" : "eye")
                                    .resizable()
                                    .frame(width: 23, height: 16)
                                    .padding(.trailing)
                                    .onTapGesture {
                                        isShowPass.toggle()
                                    }
                            }
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                            }
                            
                        } else {
                            HStack {
                                SecureField("Password", text: $password)
                                    .padding()
                                    .foregroundColor(.black)
                                    .autocorrectionDisabled(true)
                                    .textContentType(.password)
                                    .keyboardType(.namePhonePad)
                                    .textInputAutocapitalization(.never)
                                Image(systemName: isShowPass ? "eye.slash" : "eye")
                                    .resizable()
                                    .frame(width: 23, height: 16)
                                    .padding(.trailing)
                                    .onTapGesture {
                                        isShowPass.toggle()
                                    }
                            }
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                            }
                        }
                    }
                    
                    //MARK: - Login Button
                    Button(action: {
                        if email.isEmpty || password.isEmpty {
                            withAnimation {
                                isEmptyAlert = true
                            }
                        } else {
                            
                            isLoading = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isLoading = false
                            }
                            
                            emailAuthVM.signIn(email: email, pass: password, verification: .EmailAndPassAuth)
                        }
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
                    .padding([.top, .horizontal])
                    .navigationDestination(isPresented: $emailAuthVM.isLogin) {
                        ASFTabbarView()
                            .navigationBarBackButtonHidden()
                    }
                    .alert("Alert", isPresented: $isEmptyAlert) {
                        Button("Cancel", role: .cancel) {
                            email = ""
                            password = ""
                        }
                    } message: {
                        Text("Please enter email id and password.")
                    }
                    .alert("Alert", isPresented: $emailAuthVM.isAlert) {
                        Button("Retry", role: .destructive) {
                            email = ""
                            password = ""
                        }
                        Button("Cancel", role: .cancel) {
                            email = ""
                            password = ""
                        }
                    } message: {
                        Text("Email or password is incorrect.")
                    }
                    
                    //MARK: - Social Media
                    Text("- - - -  OR  - - - -")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                    
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
                    .padding(.horizontal)
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(GoogleAutheticationViewModel())
            .environmentObject(EmailAuthenticationViewModel())
    }
}
