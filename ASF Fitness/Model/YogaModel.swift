//
//  YogaModel.swift
//  ASF
//
//  Created by Jenil Rughani on 03/04/25.
//

import Foundation
import SwiftUI

//MARK: - YogaModel
struct YogaModel: Identifiable, Codable {
    var id: UUID = UUID()
    var img: String
    var catName: String
    var englishName: String
    var pose_description: String
    var pose_benefits: String
}
