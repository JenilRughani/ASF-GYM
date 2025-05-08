//
//  ASFTabbarView.swift
//  ASF
//
//  Created by Jenil Rughani on 21/03/23.
//

import SwiftUI

struct ASFTabbarView: View {
    
    @State private var verification: LoginVerification = .EmailAndPassAuth
    @StateObject var healthDataVM = HealthViewModel()
    @StateObject private var notificationManager = NotificationManagerViewModel()
    @EnvironmentObject var emailAuthVM : EmailAuthenticationViewModel
    @EnvironmentObject var googleAuthVM : GoogleAutheticationViewModel
    @AppStorage("welcomeNotify") var isWelcomeNotify: Bool = true
    @AppStorage("userInfoDetail") var userInfoDetail: Data = Data()
    
    var body: some View {
        VStack {
            TabView {
                ExploreView()
                    .tabItem {
                        CustomTabItem(img: "dumbbell", name: "Explore")
                    }
                    .tag(0)
                    .clipped()
                
                MyStatusView()
                    .tabItem {
                        Image("acitivy")
                        Text("Seats")
                    }
                    .tag(1)
                    .clipped()
                
                AIChatView()
                    .tabItem {
                        CustomTabItem(img: "chat", name: "AI")
                    }
                    .tag(2)
                    .clipped()
                
                ProfileView()
                    .tabItem {
                        CustomTabItem(img: userDetails?.gender == "male" ? "man" : "woman", name: "Profile")
                    }
                    .tag(3)
                    .clipped()
            }
            .navigationBarBackButtonHidden(true)
            .tint(Color("bluePurple"))
        }
        .environmentObject(healthDataVM)
        .onAppear() {
            
            //TODO:- Add the Firebase get User details Info
            userDetails?.login = loadUserInfo(userInfoData: userInfoDetail)?.login ?? LoginVerification.EmailAndPassAuth
            userDetails?.fName = loadUserInfo(userInfoData: userInfoDetail)?.fName ?? "-"
            email = loadUserInfo(userInfoData: userInfoDetail)?.email ?? "-"
            
            UNUserNotificationCenter.current().setBadgeCount(0) { error in
                if let error = error {
                    print("Failed to set badge count: \(error.localizedDescription)")
                } else {
                    print("Badge count updated successfully.")
                }
            }
            
            notificationManager.requestAuthNotify { result in
                switch result {
                case .success( _):
                    print("Sucuss")
                case .failure(let failure):
                    isWelcomeNotify = false
                    print(failure.localizedDescription)
                }
            }
            
            if isWelcomeNotify {
                notificationManager.notifySchedule(email: email, title: "Hello!", body: "Welcome to ASF Gym App!")
                
                self.isWelcomeNotify = false
            }
        }
        .ignoresSafeArea()
    }
}

struct ASFTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ASFTabbarView()
                .environmentObject(GoogleAutheticationViewModel())
                .environmentObject(EmailAuthenticationViewModel())
                .environmentObject(HealthViewModel())
        }
    }
}
