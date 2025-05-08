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

//MARK: - arrOFWorkout
var arrOFWorkout: [WorkoutModel] = [
    WorkoutModel(img: "ex1", name: "Upper Arms", color: LinearGradient(colors: [.orange, .orange, .yellow], startPoint: .topTrailing, endPoint: .bottomLeading)),
    WorkoutModel(img: "ex2", name: "Cardio Cut Strength", color: LinearGradient(colors: [Color("bluePurple"), .purple], startPoint: .topTrailing, endPoint: .bottomLeading)),
    WorkoutModel(img: "ex3", name: "Chest Strength", color: LinearGradient(colors: [.blue, .blue.opacity(0.35), Color("bluePurple")], startPoint: .topTrailing, endPoint: .bottomLeading)),
    WorkoutModel(img: "ex4", name: "Lower Legs", color: LinearGradient(colors: [.blue, .blue.opacity(0.75), .cyan], startPoint: .topTrailing, endPoint: .bottomLeading)),
    WorkoutModel(img: "ex5", name: "Shoulders Strength", color: LinearGradient(colors: [Color("bluePurple").opacity(0.75), .orange.opacity(0.35), .yellow.opacity(0.25)], startPoint: .topTrailing, endPoint: .bottomLeading)),
    WorkoutModel(img: "ex6", name: "Full Waist Strength", color: LinearGradient(colors: [.cyan, .cyan.opacity(0.9), .green.opacity(0.35)], startPoint: .topTrailing, endPoint: .bottomLeading)),
]
