//
//  CalenderEvent.swift
//  ASF
//
//  Created by Jenil Rughani on 01/04/25.
//

import Foundation
import SwiftUI

// MARK: - Event Model
struct Event: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let date: Date
}
