//
//  FitnessGideModel.swift
//  ASF
//
//  Created by Jenil Rughani on 26/03/25.
//

import Foundation

//MARK: - FitnessGideModel
struct FitnessGideModel: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
    var type: String
    var muscle: String
    var equipment: String
    var difficulty: String
    var instructions: String
}
