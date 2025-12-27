//
//  RiskAnalyzer.swift
//  NetGuard
//
//  Created by miguel corachea on 26/12/2025.
//

import Foundation

enum NetworkRiskLevel {
    case safe
    case warning
    case dangerous
    
    var description: String {
        switch self {
        case .safe:
            return "Low Risk Network"
        case .warning:
            return "Caution: Use VPN on this Wi-Fi"
        case .dangerous:
            return "Danger: Avoid Sensitive Activity"
        }
    }
    
    var color: String {
        switch self {
        case .safe:
            return "green"
        case .warning:
            return "orange"
        case .dangerous:
            return "red"
        }
    }
    
    var detailedMessage: String {
        switch self {
        case .safe:
            return "Your connection is relatively secure. Cellular networks provide encrypted communication."
        case .warning:
            return "This Wi-Fi network is secured, but public Wi-Fi can still be vulnerable. Consider using a VPN for sensitive activities."
        case .dangerous:
            return "⚠️ WARNING: This appears to be an open or unsecured Wi-Fi network. Avoid accessing sensitive information, banking, or entering passwords. Use cellular data or a VPN instead."
        }
    }
}

class RiskAnalyzer {
    /// Assesses the risk level based on network type and security status
    static func assess(networkType: String, secureWiFi: Bool, isConnected: Bool) -> NetworkRiskLevel {
        guard isConnected else {
            return .safe // Not connected, no risk
        }
        
        if networkType == "Wi-Fi" && !secureWiFi {
            return .dangerous
        } else if networkType == "Wi-Fi" && secureWiFi {
            return .warning
        } else if networkType == "Cellular" {
            return .safe
        } else {
            return .safe
        }
    }
}

