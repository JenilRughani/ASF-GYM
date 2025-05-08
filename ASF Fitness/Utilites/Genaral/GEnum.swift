//
//  GEnum.swift
//  ASF
//
//  Created by Jenil Rughani on 09/03/25.
//

import SwiftUI

//MARK: - ChatColorTheme
enum ChatColorTheme: String {
    case lightBlue
    case lightPink
    case lightYellow
    case textfileColor
}

//MARK: - LoginFlow
enum LoginVerification: String, Codable {
    case EmailAndPassAuth
    case PhoneAuth
    case GoogleAuth
}

//MARK: - APIMethods
enum APIMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

//MARK: - StatusCode
enum StatusCode: Int {
    case Seccuss = 200
    case ok = 201
    case failer = 404
}

//MARK: - WorkoutCat
enum WorkoutCat: String {
    case ex1 = "upper arms"
    case ex2 = "cardio"
    case ex3 = "chest"
    case ex4 = "lower legs"
    case ex5 = "shoulders"
    case ex6 = "waist"
}

//MARK: - FirebaseMainCollection
enum FirebaseMainCollection: String {
    case userInfoDetails = "UserInfoDetails"
    case userFunDetails = "AppDetails"
}

//MARK: - FirebaseSubCollection
enum FirebaseSubCollection: String {
    case userInfoDetails = "UserInfoDetails"
    case userFunDetails = "AppDetails"
}
