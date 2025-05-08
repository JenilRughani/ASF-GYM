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
