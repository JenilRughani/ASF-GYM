//
//  Font+Extenstion.swift
//  ASF
//
//  Created by Jenil Rughani on 22/03/23.
//

import Foundation
import SwiftUI

enum FontName: String {
    case CaustenBold
    case CaustenRegular
    case CaustenSemiBold
    case CaustenBlack
    case CaustenExtraBold 
    case CaustenMedium
}

//MARK: - Extenstion Font...
extension Font {
    static func caustenFont(customFontName : FontName, fontSize : CGFloat) -> Font {
        //return Font.custom(customFontName.rawValue, size: fontSize)
        
        switch customFontName {
        case .CaustenBold:
            return Font.system(size: fontSize, weight: .bold, design: .rounded)
        case .CaustenRegular:
            return Font.system(size: fontSize, weight: .regular, design: .rounded)
        case .CaustenSemiBold:
            return Font.system(size: fontSize, weight: .semibold, design: .rounded)
        case .CaustenBlack:
            return Font.system(size: fontSize, weight: .black, design: .rounded)
        case .CaustenExtraBold:
            return Font.system(size: fontSize, weight: .heavy, design: .rounded)
        case .CaustenMedium:
            return Font.system(size: fontSize, weight: .medium, design: .rounded)
        }
    }
}
