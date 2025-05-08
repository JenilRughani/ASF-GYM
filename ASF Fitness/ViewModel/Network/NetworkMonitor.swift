//
//  NetworkMonitor.swift
//  ASF
//
//  Created by Jenil Rughani on 16/03/25.
//

import Foundation
import Network
import SwiftUI

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    @Published var isNetworkAvailable: Bool = false
    @Published var isUsingWiFi: Bool = false
    @Published var isUsingCellular: Bool = false

    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isNetworkAvailable = path.status == .satisfied
                self.isUsingWiFi = path.usesInterfaceType(.wifi)
                self.isUsingCellular = path.usesInterfaceType(.cellular)
            }
        }
        monitor.start(queue: queue)
    }
}
