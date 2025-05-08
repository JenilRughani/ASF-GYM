//
//  SetNewPasswordView.swift
//  ASF
//
//  Created by Jenil Rughani on 17/03/25.
//

import SwiftUI

struct SetNewPasswordView: View {
    
    @State private var newPass: String = ""
    @State private var confirmPass: String = ""
    @State private var isShowPassConfirm: Bool = false
    @State private var isShowPass: Bool = false
    
    var body: some View {
        VStack {
            BackView()
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Set New Password")
                        .font(.caustenFont(customFontName: .CaustenBold, fontSize: 28))
                    
                    Text("Create a strong password that you’ve\n never used before.")
                        .multilineTextAlignment(.leading)
                        .font(.caustenFont(customFontName: .CaustenRegular, fontSize: 18))
                }
                
                Spacer()
            }
            .padding([.bottom, .horizontal])
            
            VStack {
                if isShowPass {
                    HStack {
                        TextField("New Password", text: $newPass)
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
                        SecureField("New Password", text: $newPass)
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
                
                if isShowPass {
                    HStack {
                        TextField("Confirm Password", text: $confirmPass)
                            .padding()
                            .foregroundColor(.black)
                            .autocorrectionDisabled(true)
                            .textContentType(.password)
                            .keyboardType(.namePhonePad)
                            .textInputAutocapitalization(.never)
                        Image(systemName: isShowPassConfirm ? "eye.slash" : "eye")
                            .resizable()
                            .frame(width: 23, height: 16)
                            .padding(.trailing)
                            .onTapGesture {
                                isShowPassConfirm.toggle()
                            }
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 35)
                            .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                    }
                    
                } else {
                    HStack {
                        SecureField("Confirm Password", text: $confirmPass)
                            .padding()
                            .foregroundColor(.black)
                            .autocorrectionDisabled(true)
                            .textContentType(.password)
                            .keyboardType(.namePhonePad)
                            .textInputAutocapitalization(.never)
                        Image(systemName: isShowPassConfirm ? "eye.slash" : "eye")
                            .resizable()
                            .frame(width: 23, height: 16)
                            .padding(.trailing)
                            .onTapGesture {
                                isShowPassConfirm.toggle()
                            }
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 35)
                            .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                    }
                }
                
            }
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    SetNewPasswordView()
}
