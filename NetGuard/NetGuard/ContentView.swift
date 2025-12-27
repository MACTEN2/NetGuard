//
//  ContentView.swift
//  NetGuard
//
//  Created by miguel corachea on 26/12/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var networkManager = NetworkManager()
    @StateObject private var locationManager = LocationManager()
    @State private var riskLevel: NetworkRiskLevel = .safe
    @State private var isSecureWiFi: Bool = false
    @State private var currentSSID: String? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: riskIcon(for: riskLevel))
                            .font(.system(size: 60))
                            .foregroundColor(riskColor(for: riskLevel))
                        
                        Text("NetGuard")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Network Security Monitor")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                    
                    // Network Status Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Network Status")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Connection Type")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(networkManager.networkType)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            
                            Spacer()
                            
                            Circle()
                                .fill(networkManager.isConnected ? Color.green : Color.red)
                                .frame(width: 12, height: 12)
                            
                            Text(networkManager.isConnected ? "Connected" : "Disconnected")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        if let ssid = currentSSID {
                            Divider()
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Wi-Fi Network")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text(ssid)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }
                                Spacer()
                            }
                        }
                        
                        // Location permission warning
                        if networkManager.networkType == "Wi-Fi" && 
                           locationManager.authorizationStatus != .authorizedWhenInUse &&
                           locationManager.authorizationStatus != .authorizedAlways {
                            Divider()
                            HStack(spacing: 8) {
                                Image(systemName: "location.fill")
                                    .foregroundColor(.orange)
                                Text("Location permission required to detect Wi-Fi security")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Button("Grant") {
                                    locationManager.requestPermission()
                                }
                                .font(.caption)
                                .buttonStyle(.borderedProminent)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // Risk Assessment Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Security Assessment")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(riskLevel.description)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(riskColor(for: riskLevel))
                                
                                Text(riskLevel.detailedMessage)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            Spacer()
                        }
                        
                        if networkManager.networkType == "Wi-Fi" {
                            Divider()
                            
                            HStack {
                                Image(systemName: isSecureWiFi ? "lock.fill" : "lock.open.fill")
                                    .foregroundColor(isSecureWiFi ? .green : .red)
                                
                                Text(isSecureWiFi ? "Secured Wi-Fi" : "Unsecured Wi-Fi")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // Recommendations Card
                    if riskLevel != .safe {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Recommendations")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                RecommendationRow(
                                    icon: "shield.fill",
                                    text: "Use a VPN for sensitive activities"
                                )
                                
                                RecommendationRow(
                                    icon: "eye.slash.fill",
                                    text: "Avoid accessing banking or personal accounts"
                                )
                                
                                RecommendationRow(
                                    icon: "network",
                                    text: "Consider switching to cellular data"
                                )
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                networkManager.startMonitoring()
                
                // Request location permission if not determined
                if locationManager.authorizationStatus == .notDetermined {
                    locationManager.requestPermission()
                }
                
                // Small delay to allow location permission to be processed
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    updateNetworkStatus()
                }
            }
            .onChange(of: networkManager.networkType) { _ in
                updateNetworkStatus()
            }
            .onChange(of: networkManager.isConnected) { _ in
                updateNetworkStatus()
            }
            .onChange(of: locationManager.authorizationStatus) { _ in
                updateNetworkStatus()
            }
        }
    }
    
    private func updateNetworkStatus() {
        isSecureWiFi = WiFiSecurityChecker.isSecureWiFi()
        currentSSID = WiFiSecurityChecker.getCurrentSSID()
        riskLevel = RiskAnalyzer.assess(
            networkType: networkManager.networkType,
            secureWiFi: isSecureWiFi,
            isConnected: networkManager.isConnected
        )
    }
    
    private func riskIcon(for level: NetworkRiskLevel) -> String {
        switch level {
        case .safe:
            return "checkmark.shield.fill"
        case .warning:
            return "exclamationmark.triangle.fill"
        case .dangerous:
            return "xmark.shield.fill"
        }
    }
    
    private func riskColor(for level: NetworkRiskLevel) -> Color {
        switch level {
        case .safe:
            return .green
        case .warning:
            return .orange
        case .dangerous:
            return .red
        }
    }
}

struct RecommendationRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
