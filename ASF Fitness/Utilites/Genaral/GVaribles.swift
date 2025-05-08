//
//  Gvaribles.swift
//  MusicAPP
//
//  Created by Jenil Rughani on 22/02/23.
//

import Foundation
import UIKit

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
