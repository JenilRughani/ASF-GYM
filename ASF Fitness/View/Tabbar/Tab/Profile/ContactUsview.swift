//
//  ContactUsview.swift
//  ASF
//
//  Created by Jenil Rughani on 22/03/25.
//

import SwiftUI
import MessageUI

struct ContactUsview: View {
    
    @State private var email: String = ""
    @State private var subject: String = ""
    @State private var descrition: String = ""
    @State private var isAlert: Bool = false
    @State private var isLoader: Bool = false
    @State private var showMailView = false
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil

    var body: some View {
        ZStack {
            VStack {
                BackView()
                
                Spacer()
                
                Image("contact")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
                
                Text("Contact us")
                    .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 30))
                    .padding(.bottom)
              
                HStack {
                    Text("Enter your email:")
                        .font(.caustenFont(customFontName: .CaustenBold, fontSize: 20))
                        .foregroundStyle(.blue)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                TextField("email", text: $email)
                    .padding()
                    .foregroundColor(.black)
                    .autocorrectionDisabled(true)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .background {
                        RoundedRectangle(cornerRadius: 35)
                            .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                    }
                    .padding([.horizontal])
                
                HStack {
                    Text("Enter your subject:")
                        .font(.caustenFont(customFontName: .CaustenBold, fontSize: 20))
                        .foregroundStyle(.blue)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top)
                
                TextField("Subject", text: $subject)
                    .padding()
                    .foregroundColor(.black)
                    .autocorrectionDisabled(true)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .background {
                        RoundedRectangle(cornerRadius: 35)
                            .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                    }
                    .padding([.horizontal])
                
                HStack {
                    Text("Enter your description:")
                        .font(.caustenFont(customFontName: .CaustenBold, fontSize: 20))
                        .foregroundStyle(.blue)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top)
                
                TextField("Description", text: $descrition)
                    .padding()
                    .foregroundColor(.black)
                    .autocorrectionDisabled(true)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .frame(maxHeight: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 35)
                            .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                    }
                    .padding([.bottom, .horizontal])
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isLoader = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.isLoader = false
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                if MFMailComposeViewController.canSendMail() {
                                    showMailView = true
                                } else {
                                    isAlert = true
                                }
                                
                                email = ""
                                subject = ""
                                descrition = ""
                            }
                        }
                    }
                }, label: {
                    Text("Submit")
                        .font(.title3)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                })
                .alert(isPresented: $isAlert, content: {
                    Alert(title: Text("Alert"), message: Text("❌ Mail services are not available in Simulator.❌"))
                })
                .sheet(isPresented: $showMailView) {
                    MailViewModel(result: $mailResult,
                             toEmail: "iosdevloper37@gmail.com",
                             subject: subject,
                             body: "From: \(email)\n\n\(descrition)")
                }
                .background{
                    Capsule()
                        .fill(Color("bluePurple"))
                }
                .padding()
            }
            
            if isLoader {
                CustomLoadingview(isShowing: isLoader)
            }
        }
    }
}

#Preview {
    NavigationView {
        ContactUsview()
    }
}
