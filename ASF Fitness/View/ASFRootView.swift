//
//  ASFRootView.swift
//  ASF
//
//  Created by Jenil Rughani on 21/03/23.
//

import SwiftUI

struct ASFRootView: View {
    
    @State private var isAlert: Bool = false
    @StateObject private var networkMonitor = NetworkMonitor()
    @AppStorage("isWelcome") var isSignInView: Bool = false
    @AppStorage("login_Status") var isLogin: Bool = false
    
    //MARK: - Font Testing Medthod
    init() {
        for familyName in UIFont.familyNames {
            print(familyName)
            
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print(" -- \(fontName)")
            }
        }
    }
    
    var body: some View {
        Group {
            if isSignInView {
                if isLogin {
                    ASFTabbarView()
                } else {
                    WelcomeView()
                }
            } else {
                OnBoardingMangeView()
            }
        }
        .onReceive(networkMonitor.$isNetworkAvailable) { isAvailable in
            if isAvailable {
                if networkMonitor.isUsingWiFi {
                    print("Connected via Wi-Fi")
                } else if networkMonitor.isUsingCellular {
                    print("Connected via Cellular")
                } else {
                    print("Connected via Unknown Network")
                }
                isOnDataConnection = true
            } else {
                print("No Internet Connection")
                isOnDataConnection = false
            }
        }
    }
}

struct ASFRootView_Previews: PreviewProvider {
    static var previews: some View {
        ASFRootView()
            .environmentObject(GoogleAutheticationViewModel())
            .environmentObject(EmailAuthenticationViewModel())
    }
}
