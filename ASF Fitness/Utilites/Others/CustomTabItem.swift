//
//  CustomTabItem.swift
//  ASF
//
//  Created by Jenil Rughani on 01/04/25.
//

import Foundation
import SwiftUI

struct CustomTabItem: View {
    
    var img: String
    var name: String
    
    var body: some View {
        VStack {
            Image(img)
                .resizable()
                .frame(width: 25, height: 25)
                .scaledToFit()
            Text(name)
        }
    }
}
