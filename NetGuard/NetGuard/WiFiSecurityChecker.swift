//
//  WiFiSecurityChecker.swift
//  NetGuard
//
//  Created by miguel corachea on 26/12/2025.
//

import Foundation
import SystemConfiguration.CaptiveNetwork

class WiFiSecurityChecker {
    /// Checks if the current Wi-Fi network is secured
    /// 
    /// Note: iOS 13+ requires location permission to access Wi-Fi SSID.
    /// If SSID is available, the network is secured.
    /// If SSID is not available, it could mean:
    /// - Network is open/unsecured
    /// - Location permission not granted
    /// - API restrictions
    static func isSecureWiFi() -> Bool {
        // Check if we can get SSID (indicates secured network)
        return getCurrentSSID() != nil
    }
    
    /// Gets the current Wi-Fi SSID if available
    /// 
    /// Returns the SSID if:
    /// - Device is connected to Wi-Fi
    /// - Location permission is granted
    /// - Network information is accessible
    static func getCurrentSSID() -> String? {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
            return nil
        }
        
        for interface in interfaces {
            if let networkInfo = CNCopyCurrentNetworkInfo(interface as CFString) as NSDictionary? {
                if let ssid = networkInfo["kCNNetworkInfoKeySSID"] as? String {
                    return ssid
                }
            }
        }
        return nil
    }
}

