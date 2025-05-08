//
//  EditProfileView.swift
//  ASF
//
//  Created by Jenil Rughani on 22/03/25.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var img: String = ""
    @State private var fName: String = ""
    @State private var email: String = ""
    @State private var Phone: String = ""
    @State private var gender: String = ""
    @State private var verification: LoginVerification = .EmailAndPassAuth
    @State private var isAlertView: Bool = false
    @State private var isOpenGalleryActionSheet: Bool = false
    @State private var isOpenGalleryView: Bool = false
    @State private var isStartLoader: Bool = false
    @AppStorage("userInfoDetail") var userInfoDetail: Data = Data()
    @Environment(\.dismiss) var dismiss
    @State private var selectedImage: UIImage? = nil
    
    var body: some View {
        ZStack {
            VStack {
                //MARK: - Back Button
                BackView()
                
                //MARK: - Img
                HStack {
                    VStack(alignment: .leading) {
                        Image("ASF")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .foregroundStyle(Color("bluePurple"))
                        
                        Text("Edit Profile")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 30))
                            .foregroundStyle(Color("bluePurple"))
                        
                    }
                    
                    Spacer()
                }
                .padding([.bottom, .horizontal])
                
                //MARK: - Textfileds
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 18) {
                        
                        if verification == .EmailAndPassAuth {
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
                        } else {
                            AsyncImage(url: URL(string: img)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 180, height: 180)
                                        .clipShape(Circle())
                                        .shadow(radius: 5)
                                } else {
                                    ProgressView()
                                }
                            }
                            .foregroundStyle(Color("bluePurple"))
                        }
                        
                        HStack {
                            Text("Your first name:")
                                .foregroundStyle(.black)
                                .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        
                        TextField("Jack", text: $fName)
                            .padding()
                            .foregroundColor(.black)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                            }
                        
                        HStack {
                            Text("Your email id:")
                                .foregroundStyle(.black)
                                .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        
                        TextField("email", text: $email)
                            .padding()
                            .foregroundColor(.black)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                            }
                        
                        HStack {
                            Text("Your mobile number:")
                                .foregroundStyle(.black)
                                .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        
                        TextField("1234567890", text: $Phone)
                            .padding()
                            .foregroundColor(.black)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                            }
                        
                        HStack {
                            Text("Your Gernder:")
                                .foregroundStyle(.black)
                                .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        
                        Picker("Select Gender", selection: $gender) {
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                        }
                        .pickerStyle(.wheel)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(uiColor: UIColor.systemGray6))
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Button(action: {
                        fName = ""
                        gender = ""
                        email = ""
                        Phone = ""
                    }, label: {
                        Text("Clear")
                            .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(ASFCapsuleButtonStyle())
                    
                    Button(action: {
                        if fName.isEmpty || gender.isEmpty || email.isEmpty || Phone.isEmpty {
                            isAlertView = true
                        } else {
                            userInfoDetail = saveUserInfo(userInfo: UserInfoDetails(fName: fName, email: email, phone: Phone, photo: img, gender: gender, login: verification))!
                            
                            isStartLoader = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.isStartLoader = false
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                dismiss.callAsFunction()
                            }
                        }
                    }, label: {
                        Text("Save")
                            .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(ASFCapsuleButtonStyle())
                    .alert("Data is Empty", isPresented: $isAlertView) {
                        Button(action: {
                            fName = ""
                            gender = ""
                            email = ""
                            Phone = ""
                        }, label: {
                            Text("OK")
                        })
                    }
                }
                .padding(.horizontal)
            }
            
            if isStartLoader {
                CustomLoadingview(isShowing: isStartLoader)
            }
        }
        .onAppear() {
            //TODO:- Add the Firebase get User details Info
            
            self.verification = loadUserInfo(userInfoData: userInfoDetail)?.login ?? LoginVerification.EmailAndPassAuth
            self.img = loadUserInfo(userInfoData: userInfoDetail)?.photo ?? ""
            self.fName = loadUserInfo(userInfoData: userInfoDetail)?.fName ?? "Jason Mann"
            self.gender = "male"
            self.email = loadUserInfo(userInfoData: userInfoDetail)?.email ?? "abc@xyz.com"
            self.Phone = loadUserInfo(userInfoData: userInfoDetail)?.phone ?? "1234567890"
        }
    }
}

#Preview {
    EditProfileView()
}
