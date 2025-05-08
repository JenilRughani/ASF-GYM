//
//  SignUpView.swift
//  ASF
//
//  Created by Jenil Rughani on 21/03/23.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var fName: String = ""
    @State private var lName: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var createPassword: String = ""
    @State private var isShowPass: Bool = false
    @State private var isAlertView: Bool = false
    @State private var isOpenGalleryActionSheet: Bool = false
    @State private var isOpenGalleryView: Bool = false
    @State private var selectedImage: UIImage? = nil
    @EnvironmentObject var emailVM: EmailAuthenticationViewModel
    
    var body: some View {
        ZStack {
            VStack {
                //MARK: - Back Button
                BackView()
                
                Text("Create Account")
                    .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 28))
                    .padding(.top)
                Text("Create a strong password that\n you’ve never used before.")
                    .font(Font.caustenFont(customFontName: .CaustenRegular, fontSize: 18))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                //MARK: - Img
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 110, height: 110)
                        .scaledToFit()
                        .clipShape(Circle())
                        .padding(.bottom)
                } else {
                    Image("addSignUpImage")
                        .resizable()
                        .frame(width: 110, height: 110)
                        .scaledToFit()
                        .padding(.bottom)
                        .onTapGesture {
                            withAnimation {
                                isOpenGalleryActionSheet = true
                            }
                        }
                        .actionSheet(isPresented: $isOpenGalleryActionSheet, content: {
                            ActionSheet(title: Text("Action"), message: Text("Select your photo in gallery."), buttons: [
                                .destructive(Text("Gallery"), action: {
                                    isOpenGalleryView = true
                                }),
                                .cancel()
                            ])
                        })
                        .sheet(isPresented: $isOpenGalleryView) {
                            PhotoPickerView(selectedImage: $selectedImage)
                        }
                }
                
                //MARK: - Textfileds
                VStack(spacing: 18) {
                    TextField("First Name", text: $fName)
                        .padding()
                        .foregroundColor(.black)
                        .autocorrectionDisabled(true)
                        .textContentType(.givenName)
                        .keyboardType(.default)
                        .background {
                            RoundedRectangle(cornerRadius: 35)
                                .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                        }
                    
                    TextField("Last Name", text: $lName)
                        .padding()
                        .foregroundColor(.black)
                        .autocorrectionDisabled(true)
                        .textContentType(.familyName)
                        .keyboardType(.default)
                        .background {
                            RoundedRectangle(cornerRadius: 35)
                                .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                        }
                    
                    TextField("Email", text: $email)
                        .padding()
                        .foregroundColor(.black)
                        .autocorrectionDisabled(true)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .background {
                            RoundedRectangle(cornerRadius: 35)
                                .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                        }
                        .onChange(of: email) { oldValue, newValue in
                            email = newValue.lowercased()
                        }
                    
                    TextField("Phone Number", text: $phone)
                        .padding()
                        .foregroundColor(.black)
                        .autocorrectionDisabled(true)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
                        .background {
                            RoundedRectangle(cornerRadius: 35)
                                .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                        }
                    
//                    TextField("Create Password", text: $createPassword)
//                        .padding()
//                        .foregroundColor(.black)
//                        .autocorrectionDisabled(true)
//                        .textContentType(.password)
//                        .keyboardType(.default)
//                        .background {
//                            RoundedRectangle(cornerRadius: 35)
//                                .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
//                        }
                    
                    
                    if isShowPass {
                        HStack {
                            TextField("Create Password", text: $createPassword)
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
                            SecureField("Create Password", text: $createPassword)
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
                .padding(.horizontal)
                
                Button(action: {
                    if email.isEmpty || fName.isEmpty || lName.isEmpty || createPassword.isEmpty  || phone.isEmpty || selectedImage == nil {
                        isAlertView = true
                    } else {
                        emailVM.signUp(convertImageToBase64String(img: selectedImage!), fName, lName, email: email, pass: createPassword, phone: phone, verification: .EmailAndPassAuth)
                    }
                }, label: {
                    Text("Register")
                        .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                })
                .buttonStyle(ASFCapsuleButtonStyle())
                .padding(.horizontal)
                .alert("Alert", isPresented: $isAlertView) {
                    Button(action: {
                        email = ""
                        fName = ""
                        lName = ""
                        phone = ""
                        createPassword = ""
                    }, label: {
                        Text("OK")
                    })
                } message: {
                    Text("Data is Empty, Please fill all filed.")
                }
                .alert("Alert", isPresented: $emailVM.isAlert) {
                    Button(action: {
                        email = ""
                        fName = ""
                        lName = ""
                        phone = ""
                        createPassword = ""
                    }, label: {
                        Text("OK")
                    })
                } message: {
                    Text("Data Not found.\(emailVM.errMessage)")
                }
                .navigationDestination(isPresented: $emailVM.isNextLogin) {
                    ASFTabbarView()
                        .navigationBarBackButtonHidden()
                }
            }
            
            if emailVM.isLoader {
                CustomLoadingview(isShowing: emailVM.isLoader)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUpView()
                .environmentObject(EmailAuthenticationViewModel())
        }
    }
}
