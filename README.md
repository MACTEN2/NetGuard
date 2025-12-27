# NetGuard - iOS Network Security Monitor

An iOS app that detects network security risks and warns users about unsafe connections in real-time.

## 🎯 Problem

Public Wi-Fi networks expose users to man-in-the-middle attacks, credential theft, and data interception. Many users are unaware of the security risks when connecting to open or unsecured networks.

## ✅ Solution

NetGuard monitors your network connection and provides real-time security assessments:

- **Detects network type** (Wi-Fi vs Cellular)
- **Identifies Wi-Fi security level** (Secured vs Unsecured)
- **Flags risky networks** with clear warnings
- **Provides actionable recommendations** for safer browsing

## 🔒 Security Concepts Demonstrated

### Network Risk Assessment
The app implements a threat modeling approach:
- **Open Wi-Fi** → High risk (dangerous)
- **Secured Wi-Fi** → Medium risk (warning)
- **Cellular** → Low risk (safe)

### Endpoint Security
NetGuard simulates enterprise mobile security tools by:
- Monitoring network interface changes
- Assessing connection security posture
- Providing user-friendly risk warnings

### Real-World Threat Modeling
The risk assessment logic reflects actual security concerns:
- Open networks are vulnerable to packet sniffing
- Even secured Wi-Fi can be compromised in public spaces
- Cellular networks provide encrypted communication by default

## 🛠️ Technical Implementation

### Architecture

```
NetGuard/
├── NetworkManager.swift          # Monitors network type (Wi-Fi/Cellular)
├── WiFiSecurityChecker.swift     # Detects Wi-Fi security status
├── RiskAnalyzer.swift            # Assesses risk level
├── LocationManager.swift         # Handles location permissions
└── ContentView.swift             # SwiftUI dashboard
```

### Key Technologies

- **SwiftUI** - Modern declarative UI framework
- **Network Framework** - Network path monitoring
- **SystemConfiguration.CaptiveNetwork** - Wi-Fi information access
- **CoreLocation** - Required for Wi-Fi SSID access (iOS security requirement)

### iOS Security Model Compliance

⚠️ **Important Reality Check**

iOS does NOT allow apps to:
- Inspect raw packets
- See encryption keys
- Read router configurations
- Access detailed network internals

✅ **What NetGuard CAN do:**
- Detect if Wi-Fi is open vs secured
- Detect network type (Wi-Fi/Cellular)
- Infer risk based on known security indicators
- Provide user warnings and recommendations

This approach mirrors how real enterprise mobile security tools work within Apple's security constraints.

## 📱 Features

### Network Detection
- Real-time monitoring of network type
- Connection status indicator
- Wi-Fi SSID display (when available)

### Security Assessment
- Automatic risk level calculation
- Color-coded warnings (Green/Orange/Red)
- Plain English security messages

### User Guidance
- Actionable recommendations for risky networks
- VPN usage suggestions
- Best practices for safe browsing

## 🚀 Getting Started

### Requirements
- iOS 18.0+
- Xcode 15.0+
- Physical device (Wi-Fi detection requires real hardware)

### Setup

1. Open `NetGuard.xcodeproj` in Xcode
2. Select your development team in project settings
3. Build and run on a physical iOS device
4. Grant location permission when prompted (required for Wi-Fi info)

### Permissions

The app requires **Location Permission** (`NSLocationWhenInUseUsageDescription`) because iOS requires location access to retrieve Wi-Fi network information. This is an Apple security requirement, not a choice.

## 🧪 Testing Scenarios

Test the app in different network environments:

1. **Home Wi-Fi** - Should show "Secured Wi-Fi" with warning level
2. **Public Wi-Fi** - May show "Unsecured Wi-Fi" with danger level
3. **Cellular Data** - Should show "Safe" status
4. **Airplane Mode** - Should show "Disconnected"

## 📊 Risk Levels

### 🟢 Safe (Green)
- Cellular network connections
- Low risk for sensitive activities

### 🟠 Warning (Orange)
- Secured Wi-Fi networks
- Use VPN recommended for sensitive data

### 🔴 Dangerous (Red)
- Open or unsecured Wi-Fi
- Avoid banking, passwords, sensitive information

## 🔮 Future Enhancements

Potential extensions to level up the app:

- VPN detection and status
- Network change logging
- Security report export
- MDM-style compliance scoring
- Historical network risk tracking

## 🎓 Why This Project Matters

This project demonstrates:

- **Apple ecosystem specialization** - Deep understanding of iOS security model
- **Security mindset** - Thinking like a defender, not just a developer
- **Real-world application** - Solves actual user security problems
- **Enterprise relevance** - Maps directly to mobile security roles

## 📝 License

This project is created for educational and portfolio purposes.

## 👤 Author

Created as a demonstration of iOS network security monitoring capabilities.

---

**Note**: This app provides security awareness and recommendations. It does not provide active protection or prevent attacks. Always use VPNs and follow security best practices when using public networks.

