//
//  RecipeModel.swift
//  ASF
//
//  Created by Jenil Rughani on 25/03/25.
//

import Foundation

//MARK: - RecipeModel
struct RecipeModel: Identifiable, Hashable {
    var id: UUID = UUID()
    var image: String
    var title: String
    var sourceUrl: String
    var vegetarian: Bool
    var dishTypes: String
    var healthScore: String
    var instructions: String
    var summery: String
}
