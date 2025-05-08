//
//  HealthModel.swift
//  ASF
//
//  Created by Jenil Rughani on 22/03/25.
//

import Foundation
import SwiftUI

//MARK: - HealthModel
struct HealthModel: Codable, Identifiable {
    var id = UUID()
    var steps: String
    var heartRate: String
    var training: String
    var calories: String
    var sleep: String
    var distance: String
    var dateTime: Date
}
