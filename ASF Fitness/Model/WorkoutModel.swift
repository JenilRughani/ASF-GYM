//
//  WorkoutModel.swift
//  ASF
//
//  Created by Jenil Rughani on 13/03/25.
//

import Foundation
import SwiftUI

//MARK: - WorkoutModel
struct WorkoutModel: Identifiable {
    var id: UUID = UUID()
    var img: String
    var name: String
    var color: LinearGradient
}
