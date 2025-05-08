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
