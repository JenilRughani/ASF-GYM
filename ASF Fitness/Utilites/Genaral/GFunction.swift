//
//  GFunction.swift
//  MusicAPP
//
//  Created by Jenil Rughani on 10/03/23.
//

import Foundation
import SwiftUI

func convertImageToBase64String (img: UIImage) -> String {
    guard let imageData = img.jpegData(compressionQuality: 0.3) else { return "" }
    return imageData.base64EncodedString()
}

func convertBase64StringToImage (imageBase64String:String) -> UIImage {
    guard let imageData = Data(base64Encoded: imageBase64String) else { return UIImage() }
    return UIImage(data: imageData) ?? UIImage()
}

func dateFormatted(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM,YYY  hh:mm a"
    return formatter.string(from: date)
}

func timeFormatted(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter.string(from: date)
}

func getCurrentDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, yy hh:mm a"
    return formatter.string(from: Date())
}

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

func replayMessage(message: String) -> String {
    
    let tempMessage = message.lowercased()
    
    if tempMessage.contains("hello") {
        return "Hey there!"
    }
    else if tempMessage.contains("hi") {
        return "Hey there!"
    }
    else if tempMessage.contains("goodbye") {
        return "Talk to you later!"
    }
    else if tempMessage.contains("by") {
        return "Talk to you later!"
    }
    else if tempMessage.contains("how are you") {
        return "I'm fine, how about you?"
    }
    else {
        return "That's cool."
    }
}
