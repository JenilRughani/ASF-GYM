//
//  LifeStyleViewModel.swift
//  ASF
//
//  Created by Jenil Rughani on 27/03/25.
//

import Foundation
import SwiftUI

class LifeStyleViewModel: ObservableObject {
    
    @Published var model = LifestyleModel()
    
//    var bmi: Double {
//        print(model.bmi)
//        return model.bmi
//    }
//    
//    var bmiCategory: String {
//        model.bmiCategory
//    }
//    
//    var bmr: Double {
//        model.bmr
//    }
//    
//    var fitnessStatus: String {
//        model.fitnessStatus
//    }
//    
//    // Methods to update the model
//    func updateHeight(_ height: String) {
//        if let value = Double(height) {
//            model.height = value
//        }
//    }
//    
//    func updateWeight(_ weight: String) {
//        if let value = Double(weight) {
//            model.weight = value
//        }
//    }
//    
//    func updateAge(_ age: String) {
//        if let value = Int(age) {
//            model.age = value
//        }
//    }
//    
//    func updateGender(_ gender: String) {
//        model.gender = gender
//    }
    
    
    // MARK: - BMI Calculation
    func bmi(height: Double, weight: Double) -> Double {
        guard height > 0 && weight > 0 else { return 0.0 }
        let heightInMeters = height / 100
        return weight / (heightInMeters * heightInMeters)
    }
    
    func bmiCategory(bmi: Double) -> String {
        switch bmi {
        case ..<18.5: return "Underweight"
        case 18.5..<25: return "Normal"
        case 25..<30: return "Overweight"
        case 30..<35: return "Obese"
        case 35...: return "Severely Obese"
        default: return "Unknown"
        }
    }
    
    // MARK: - BMR Calculation
    func bmr(height: Double, weight: Double, age: Double, gender: String) -> Double {
        guard height > 0 && weight > 0 && age > 0 else { return 0.0 }
        
        if gender.lowercased() == "male" {
            return 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * Double(age))
        } else {
            return 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * Double(age))
        }
    }
    
    //MARK: - fitnessStatus
    func fitnessStatus(bmi: Double, bmr: Double) -> String {
        switch bmi {
        case ..<18.5:
            return "Underweight – Not Fit 🚫"
        case 18.5..<25:
            if bmr > 1500 {
                return "Fit ✅"
            } else {
                return "Moderate Fit ⚠️"
            }
        case 25..<30:
            return "Overweight – Moderate Risk ⚠️"
        case 30..<35:
            return "Obese – Not Fit ❌"
        case 35...:
            return "Severely Obese – High Risk ❌"
        default:
            return "Unknown"
        }
    }
}
