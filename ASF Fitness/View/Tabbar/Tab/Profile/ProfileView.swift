//
//  ProfileView.swift
//  ASF
//
//  Created by Jenil Rughani on 21/03/23.
//

import SwiftUI
import StoreKit

struct ProfileView: View {
    
    @State private var img: String = ""
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var verification: LoginVerification = .EmailAndPassAuth
    
    @EnvironmentObject var emailAuthVM : EmailAuthenticationViewModel
    @EnvironmentObject var googleAuthVM : GoogleAutheticationViewModel
    
    @State private var isEditView: Bool = false
    @State private var isLoader: Bool = false
    @State private var isLogout: Bool = false
    @State private var isLogoutAction: Bool = false
    
    @AppStorage("userInfoDetail") var userInfoDetail: Data = Data()
    
    @EnvironmentObject var healthDataVM: HealthViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Profile")
                    .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 35))
                    .foregroundStyle(.black)
                
                Spacer()
            }
            .padding()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    if verification == .EmailAndPassAuth {
                        Image(uiImage: convertBase64StringToImage(imageBase64String: img))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 180)
                            .clipShape(Circle())
                            .shadow(radius: 5)
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
                    }
                    
                    Text(name)
                        .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                        .foregroundStyle(.black)
                    
                    Text(email)
                        .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 18))
                        .foregroundStyle(.gray)
                        .padding(.bottom)
                    
                    //MARK: - HEALTH SETTINGS
                    HStack {
                        Text("HEALTH SETTINGS")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 20))
                            .foregroundStyle(Color("headingColor"))
                        
                        Spacer()
                    }
                    .padding([.top, .horizontal])
                    .padding(.horizontal, 10)
                    
                    VStack {
                        NavigationLink {
                            AddHealthData().navigationBarBackButtonHidden()
                                .environmentObject(healthDataVM)
                        } label: {
                            HStack {
                               Text("Add Health Data:")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.forward")
                            }
                            .foregroundStyle(.black)
                        }
                        .padding()
                        
                        Divider()
                            .padding(.horizontal)
                        
                        NavigationLink {
                            DisplayAllHealthData().navigationBarBackButtonHidden()
                                .environmentObject(healthDataVM)
                        } label: {
                            HStack {
                               Text("List Of Health Data:")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.forward")
                            }
                            .foregroundStyle(.black)
                        }
                        .padding()
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .shadow(radius: 2)
                    }
                    .padding()
                    
                    //MARK: - Help & Support
                    HStack {
                        Text("HELP & SUPPORT")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 20))
                            .foregroundStyle(Color("headingColor"))
                        
                        Spacer()
                    }
                    .padding([.top, .horizontal])
                    .padding(.horizontal, 10)
                    
                    VStack {
                        NavigationLink {
                            AboutUsView()
                                .navigationBarBackButtonHidden()
                        } label: {
                            HStack {
                               Text("About Us")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.forward")
                            }
                            .foregroundStyle(.black)
                        }
                        .padding()
                        
                        Divider()
                            .padding(.horizontal)
                        
                        NavigationLink {
                            ContactUsview()
                                .navigationBarBackButtonHidden()
                        } label: {
                            HStack {
                               Text("Contact Us")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.forward")
                            }
                            .foregroundStyle(.black)
                        }
                        .padding()
                        
                        Divider()
                            .padding(.horizontal)
                        
                        NavigationLink {
                            TermsAndconditionView()
                                .navigationBarBackButtonHidden()
                        } label: {
                            HStack {
                               Text("Terms & Condition")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.forward")
                            }
                            .foregroundStyle(.black)
                        }
                        .padding()
                        
                        Divider()
                            .padding(.horizontal)
                        
                        Button(action: {
                            SKStoreReviewController.requestReview()
                        }, label: {
                            HStack {
                               Text("Rate The App")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.forward")
                            }
                            .foregroundStyle(.black)
                        })
                        .padding()
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .shadow(radius: 2)
                    }
                    .padding()
                    
                    //MARK: - ACCOUNT SETTINGS
                    HStack {
                        Text("ACCOUNT SETTINGS")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 20))
                            .foregroundStyle(Color("headingColor"))
                        
                        Spacer()
                    }
                    .padding([.top, .horizontal])
                    .padding(.horizontal, 10)
                    
                    VStack {
                        Button(action: {
                            withAnimation {
                                self.isEditView = true
                            }
                        }, label: {
                            HStack {
                               Text("Edit Account")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.forward")
                            }
                            .foregroundStyle(.black)
                        })
                        .padding()
                        .navigationDestination(isPresented: $isEditView) {
                            EditProfileView()
                                .navigationBarBackButtonHidden()
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
                        Button(action: {
                            withAnimation {
                                self.isLogoutAction = true
                            }
                        }, label: {
                            HStack {
                               Text("Sign OUT")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.forward")
                            }
                            .foregroundStyle(.black)
                        })
                        .padding()
                    }
                    .actionSheet(isPresented: $isLogoutAction, content: {
                        ActionSheet(title: Text("Action"), message: Text("Are you sure you want to logout?"), buttons: [
                            .destructive(Text("Sign Out"), action: {
                                if verification == .EmailAndPassAuth {
                                    emailAuthVM.signOut()
                                    print("Email Logout")
                                } else {
                                    googleAuthVM.signOut()
                                    print("Google Logout")
                                }
                                
                                withAnimation {
                                    self.isLogout = true
                                }
                            }),
                            .cancel()
                        ])
                    })
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .shadow(radius: 2)
                    }
                    .padding()
                    .navigationDestination(isPresented: $isLogout) {
                        SignInView()
                            .navigationBarBackButtonHidden()
                    }
                }
            }
        }
        .background {
            Color("lightwhite")
                .ignoresSafeArea()
        }
        .onAppear() {
            //TODO:- Add the Firebase get User details Info
            
            self.verification = loadUserInfo(userInfoData: userInfoDetail)?.login ?? LoginVerification.EmailAndPassAuth
            self.img = loadUserInfo(userInfoData: userInfoDetail)?.photo ?? ""
            self.name = loadUserInfo(userInfoData: userInfoDetail)?.fName ?? "Jason Mann"
            self.email = loadUserInfo(userInfoData: userInfoDetail)?.email ?? "abc@xyz.com"
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(GoogleAutheticationViewModel())
            .environmentObject(EmailAuthenticationViewModel())
            .environmentObject(HealthViewModel())
    }
}
