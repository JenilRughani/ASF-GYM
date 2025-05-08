//
//  ASF_FitnessApp.swift
//  ASF
//
//  Created by Jenil Rughani on 21/03/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FirebaseMessaging


@main
struct ASF_FitnessApp: App {
    
    @StateObject var googleAuthVM = GoogleAutheticationViewModel()
    @StateObject var emailAuthVM = EmailAuthenticationViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ASFRootView()
            }
            .environmentObject(emailAuthVM)
            .environmentObject(googleAuthVM)
        }
    }
}
