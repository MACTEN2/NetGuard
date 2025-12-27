//
//  NetworkManager.swift
//  NetGuard
//
//  Created by miguel corachea on 26/12/2025.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published var networkType: String = "Unknown"
    @Published var isConnected: Bool = false
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.isConnected = path.status == .satisfied
                
                if path.usesInterfaceType(.wifi) {
                    self.networkType = "Wi-Fi"
                } else if path.usesInterfaceType(.cellular) {
                    self.networkType = "Cellular"
                } else if path.usesInterfaceType(.wiredEthernet) {
                    self.networkType = "Ethernet"
                } else {
                    self.networkType = "Unknown"
                }
            }
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}

