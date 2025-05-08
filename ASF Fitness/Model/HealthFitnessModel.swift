//
//  HealthFitnessModel.swift
//  ASF
//
//  Created by Jenil Rughani on 26/03/25.
//

import Foundation

struct HealthFitnessModel:Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String
    var author: String
    var urlToImage: String
    var url: String
    var description: String
    var content: String
    var publishedAt: String
}
