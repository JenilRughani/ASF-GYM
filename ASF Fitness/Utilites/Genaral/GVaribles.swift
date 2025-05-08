//
//  Gvaribles.swift
//  MusicAPP
//
//  Created by Jenil Rughani on 22/02/23.
//

import Foundation
import UIKit
import SwiftUI

//NOTE: - Find the Device and Return the Screen Logical Width And height
let logicalWidth = UIScreen.main.bounds.width
let logicalHeight = UIScreen.main.bounds.height

//NOTE: - diviceScreen Width divied by 320 [minimum Divices Width = 320]
var diviceFont: CGFloat {
    if UIDevice().userInterfaceIdiom == .pad {
        //debugPrint("DiviceFont:- \(multiFontSizeWidth / 768)")
        return logicalWidth / 768
    }
    //debugPrint("DiviceFont:- \(multiFontSizeWidth / 375)")
    return logicalWidth / 375
}

//NOTE:- App can easy find the mobile or wifi is On Or Off
var isOnDataConnection: Bool = false

var email: String = ""
var fName: String = ""

var userDetails: UserInfoDetails? = nil

//MARK: - arrOFWorkout
var arrOFWorkout: [WorkoutModel] = [
    WorkoutModel(img: "ex1", name: "Upper Arms", color: LinearGradient(colors: [.orange, .orange, .yellow], startPoint: .topTrailing, endPoint: .bottomLeading)),
    WorkoutModel(img: "ex2", name: "Cardio Cut Strength", color: LinearGradient(colors: [Color("bluePurple"), .purple], startPoint: .topTrailing, endPoint: .bottomLeading)),
    WorkoutModel(img: "ex3", name: "Chest Strength", color: LinearGradient(colors: [.blue, .blue.opacity(0.35), Color("bluePurple")], startPoint: .topTrailing, endPoint: .bottomLeading)),
    WorkoutModel(img: "ex4", name: "Lower Legs", color: LinearGradient(colors: [.blue, .blue.opacity(0.75), .cyan], startPoint: .topTrailing, endPoint: .bottomLeading)),
    WorkoutModel(img: "ex5", name: "Shoulders Strength", color: LinearGradient(colors: [Color("bluePurple").opacity(0.75), .orange.opacity(0.35), .yellow.opacity(0.25)], startPoint: .topTrailing, endPoint: .bottomLeading)),
    WorkoutModel(img: "ex6", name: "Full Waist Strength", color: LinearGradient(colors: [.cyan, .cyan.opacity(0.9), .green.opacity(0.35)], startPoint: .topTrailing, endPoint: .bottomLeading)),
]
