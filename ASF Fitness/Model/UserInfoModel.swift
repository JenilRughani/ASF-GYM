//
//  UserInfoModel.swift
//  ASF
//
//  Created by Jenil Rughani on 21/03/25.
//

import Foundation

//MARK: - UserInfoDetails
struct UserInfoDetails: Identifiable, Codable {
    var id: String = ""
    var fName: String
    var lName: String?
    var email: String
    var phone: String
    var photo: String?
    var gender: String = "male"
    var login: LoginVerification
}

// Save function
func saveUserInfo(userInfo: UserInfoDetails) -> Data?  {
    do {
        let saveData = try JSONEncoder().encode(userInfo)
        print("User info saved successfully")
        return saveData
    } catch {
        print("Failed to encode user info: \(error.localizedDescription)")
        return nil
    }
}

// Load function
func loadUserInfo(userInfoData: Data) -> UserInfoDetails? {
    do {
        let userData = try JSONDecoder().decode(UserInfoDetails.self, from: userInfoData)
        print("User info loaded successfully")
        return userData
    } catch {
        print("Failed to decode user info: \(error.localizedDescription)")
        return nil
    }
}
