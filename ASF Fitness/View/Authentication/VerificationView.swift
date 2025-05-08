//
//  VerificationView.swift
//  ASF
//
//  Created by Jenil Rughani on 17/03/25.
//

import SwiftUI

struct VerificationView: View {
    
    @Binding var number: String
    @State private var otpDigits: [String] = Array(repeating: "", count: 4)
    @FocusState private var focusedField: Int?
    @State private var isVerify: Bool = false
    @State private var isAlert: Bool = false
    @State private var isEnableResend: Bool = false
    @EnvironmentObject var googleAuthVM : GoogleAutheticationViewModel
    
    var body: some View {
        VStack {
            BackView()
            
            Spacer()
            
            Image("phone")
                .resizable()
                .frame(width: 78, height: 78)
                .padding()
            
            Text("Phone verification")
                .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 28))
                .padding(.bottom, 5)
            
            Text("We sent a code to your mobile number\n \(number)")
                .foregroundStyle(.gray)
                .font(Font.caustenFont(customFontName: .CaustenRegular, fontSize: 18))
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .padding(.bottom)
            
            HStack(spacing: 10) {
                ForEach(0..<4, id: \.self) { index in
                    TextField("", text: $otpDigits[index])
                        .frame(width: 70, height: 70)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .focused($focusedField, equals: index)
                        .onChange(of: otpDigits[index]) { newValue in
                            handleInputChange(newValue, index: index)
                        }
                }
            }
            
            Button(action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                    //googleAuthVM.sendOTP(phoneNumber: number)
                    self.isEnableResend = true
                }
            }, label: {
                HStack {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(isEnableResend ? .blue : .gray)
                        .padding(10)
                        .background {
                            RoundedRectangle(cornerRadius: 60)
                                .fill(Color("lightBlue"))
                        }
                    Text("Resend code")
                        .foregroundColor(isEnableResend ? .blue : .gray)
                }
            })
            .padding(.top)
            .disabled(!isEnableResend)
            
            Button(action: {
                if otpDigits == Array(repeating: "", count: 4) {
                    withAnimation {
                        isAlert = true
                    }
                } else {
                    withAnimation {
                        //googleAuthVM.phoneSignIn(no: number)
                    }
                }
            }, label: {
                Text("Verify")
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
//            .navigationDestination(isPresented: $googleAuthVM.isPhoneVerify) {
//                SignInView()
//                    .navigationBarBackButtonHidden()
//            }
            .alert("Alert", isPresented: $isAlert) {
                Button(action: {
                    
                }, label: {
                    Text("Cancle")
                })
            } message: {
                Text("Please enter a OTP.")
            }
            
            Spacer()
        }
        .onAppear {
            print("On appear")
            //googleAuthVM.sendOTP(phoneNumber: number)
        }
    }
    
    private func handleInputChange(_ newValue: String, index: Int) {
        if newValue.count > 1 {
            otpDigits[index] = String(newValue.prefix(1))
        }
        
        // Move to next field automatically
        if !newValue.isEmpty && index < 3 {
            focusedField = index + 1
        }
        
        // Move back on delete
        if newValue.isEmpty && index > 0 {
            focusedField = index - 1
        }
    }
    
    private func verifyOTP() {
        print("Entered OTP: \(otpDigits.joined())")
    }
}

#Preview {
    VerificationView(number: .constant("123456789"))
        .environmentObject(GoogleAutheticationViewModel())
        .environmentObject(EmailAuthenticationViewModel())
}
