//
//  NutritionModel.swift
//  ASF
//
//  Created by Jenil Rughani on 24/03/25.
//

import SwiftUI

//MARK: - NutritionModel
struct NutritionModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var fat: String
    var fatSaturated: String
    var sodium: String
    var potassium: String
    var cholesterol: String
    var carbohydrates: String
    var fiber: String
    var sugar: String
}
