//
//  SignINEmailPasswordViewModel.swift
//  ASF
//
//  Created by Jenil Rughani on 18/03/25.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class EmailAuthenticationViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var verification: LoginVerification = .EmailAndPassAuth
//    @Published var firstName: String = "unkown Name"
//    @Published var lastName: String = "unkown Surname"
//    @Published var email: String = "unkown@gmail.com"
//    @Published var phone: String = "+0 1234567890"
//    @Published var image: String = "plus"
    @Published var isAlert: Bool = false
    @Published var isNextLogin: Bool = false
    @Published var isLoader: Bool = false
    @Published var errMessage: String = ""
    @AppStorage("login_Status") var isLogin: Bool = false
    //@AppStorage("userInfoDetail") var userInfoDetail: Data = Data()
    
    //Get the User ID
    var user: User? {
        didSet {
            objectWillChange.send()
        }
    }
    
    func listenToAuthState() {
        auth.addStateDidChangeListener { [weak self] _ , nUser in
            guard let self = self else { return }
            self.user = nUser
        }
    }
    
    func resetPassEmailVerification(emailAdd: String) {
        DispatchQueue.main.async {
            self.auth.sendPasswordReset(withEmail: emailAdd) { err in
                if err == nil {
                    self.isAlert = false
                }
                else {
                    self.isAlert = true
                    self.errMessage = err!.localizedDescription
                    debugPrint("RESET PASSWORD FAILED!!: \(String(describing: err?.localizedDescription))")
                }
            }
        }
    }
    
    
    //Sign In the User, when his register useing email or password...
    func signIn(email: String, pass: String, verification: LoginVerification) {
        
        debugPrint("Email:- \(email)")
        debugPrint("pass:- \(pass)")
        
        auth.signIn(withEmail: email, password: pass) { result, err in
            
            guard result != nil, err == nil else {
                self.isAlert = true
                self.isLogin = false
                self.errMessage = err?.localizedDescription ?? "Sign In Failed!!"
                debugPrint("ERROR:- \(err!.localizedDescription)")
                return
            }
            
            self.isLogin = true
            self.isAlert = false
            self.verification = verification
            
            self.listenToAuthState()
        }
    }
    
    //register the user
    func signUp(_ image: String ,_ fName: String, _ lName: String ,email: String, pass: String, phone: String , verification: LoginVerification) {
        auth.createUser(withEmail: email, password: pass) { result, error in
            
            self.isLoader = true
            
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                self.isAlert = true
                self.isLoader = false
                self.errMessage = error?.localizedDescription ?? ""
                return
            }
            
            guard result != nil else {
                print("Result is Empty")
                self.isLoader = false
                return
            }
            
            DispatchQueue.main.async {
                
                //MARK: - Saved in Local DataBase
              //  self.userInfoDetail = saveUserInfo(userInfo: UserInfoDetails(fName: fName, lName: lName, email: email, phone: phone, photo: image, login: verification))!
                
                //print(loadUserInfo(userInfoData: self.userInfoDetail)!)
                
                let data: [String: Any] = [
                    "fName": fName,
                    "lName": lName,
                    "email": email,
                    "photo": image,
                    "phone": phone,
                    "verfication" : LoginVerification.EmailAndPassAuth.rawValue
                ]
                
                Firestore.firestore().collection(email).document(FirebaseMainCollection.userInfoDetails.rawValue).setData(data) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                       print("Saved User Data Successfully in Firebase! -> Email & Pass")
                    }
                }
                
                self.isAlert = false
                self.verification = verification
                self.isNextLogin = true
                self.isLoader = false
                self.listenToAuthState()
            }
        }
    }
    
    //logout the user...
    func signOut() {
        do {
            self.isLogin = false
            self.isAlert = false
            verification = .EmailAndPassAuth
            try auth.signOut()
        } catch {
            self.isAlert = true
            self.errMessage = error.localizedDescription
            debugPrint("PROMBLEM SETMENT:- SIGNOUT FAILED!! \(String(describing: error.localizedDescription))")
        }
    }
}
