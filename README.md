# Flutter Platform Channel Demo

A comprehensive demonstration app showing how Flutter communicates with native code using Platform Channels across Android, iOS, and Web platforms. Perfect for teaching fresher students about Flutter's platform integration capabilities.

## 🚀 Features

### 1. **Platform Information Display**
- Shows current platform details (Android version, iOS version, Web browser info)
- Demonstrates **MethodChannel** for one-time data retrieval

### 2. **Battery Level Monitoring**
- Real-time battery level display with visual indicator
- Platform-specific battery API integration
- Color-coded battery status (green, orange, red)

### 3. **Device Information**
- Comprehensive device details (manufacturer, model, OS version, etc.)
- Platform-specific information retrieval
- Structured data display

### 4. **Native Arithmetic Operations**
- Basic arithmetic calculations performed at native level
- Addition, subtraction, multiplication, and division
- Error handling for division by zero
- Platform-specific implementation details

### 5. **Device Flashlight Control**
- Hardware flashlight control using native camera APIs
- Android: Camera2 API with torch mode
- iOS: AVFoundation with torch control
- Web: Graceful fallback with informative messages
- Real-time status monitoring and error handling

### 6. **Real-time Sensor Data**
- Live sensor data streaming using **EventChannel**
- Start/Stop controls for data monitoring
- Visual representation of sensor values

### 7. **Native Alert System**
- Platform-specific alert implementations
- Android: Toast messages
- iOS: Alert dialogs
- Web: JavaScript alerts

## 🏗️ Architecture

### Flutter Side
```
lib/
├── main.dart                          # App entry point
├── services/
│   └── platform_channel_service.dart  # Platform channel abstraction
├── screens/
│   └── platform_channel_demo_screen.dart  # Main demo UI
└── widgets/                           # Individual demo components
    ├── platform_info_card.dart
    ├── battery_level_card.dart
    ├── device_info_card.dart
    ├── arithmetic_operations_card.dart
    ├── flashlight_card.dart           # NEW: Hardware control demo
    ├── sensor_data_card.dart
    └── alert_demo_card.dart
```

### Native Side
- **Android**: Kotlin implementation in `MainActivity.kt`
- **iOS**: Swift implementation in `AppDelegate.swift`
- **Web**: JavaScript implementation in `web/js/platform_channel_web.js`

## 🔌 Platform Channels Used

### 1. **MethodChannel** (`platform_channel_demo`)
Used for one-time method calls:
- `getPlatformInfo()` - Retrieve platform information
- `getBatteryLevel()` - Get device battery level
- `getDeviceInfo()` - Get comprehensive device details
- `showNativeAlert(message)` - Display native alerts
- `performArithmetic(a, b, operation)` - Perform arithmetic operations
- `controlFlashlight(turnOn)` - Control device flashlight
- `isFlashlightAvailable()` - Check flashlight availability

### 2. **EventChannel** (`platform_events`)
Used for continuous data streaming:
- Real-time sensor data (accelerometer on mobile, simulated on web)

## 📱 Platform-Specific Implementations

### Android (Kotlin)
```kotlin
// Method Channel
MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
    when (call.method) {
        "controlFlashlight" -> {
            val turnOn = call.argument<Boolean>("turnOn") ?: false
            val flashlightResult = controlFlashlight(turnOn)
            result.success(flashlightResult)
        }
        "isFlashlightAvailable" -> {
            val isAvailable = isFlashlightAvailable()
            result.success(isAvailable)
        }
        // ... other methods
    }
}

// Flashlight control using Camera2 API
private fun controlFlashlight(turnOn: Boolean): Map<String, Any> {
    return try {
        if (cameraId == null) {
            return mapOf("error" to "No camera with flash found", "success" to false)
        }
        cameraManager?.setTorchMode(cameraId!!, turnOn)
        mapOf("success" to true, "turnOn" to turnOn)
    } catch (e: Exception) {
        mapOf("error" to "Failed to control flashlight: ${e.message}", "success" to false)
    }
}
```

### iOS (Swift)
```swift
// Method Channel
case "controlFlashlight":
    if let args = call.arguments as? [String: Any],
       let turnOn = args["turnOn"] as? Bool {
        let flashlightResult = controlFlashlight(turnOn: turnOn)
        result(flashlightResult)
    }

// Flashlight control using AVFoundation
private func controlFlashlight(turnOn: Bool) -> [String: Any] {
    do {
        guard let device = device else {
            return ["error": "No camera device found", "success": false]
        }
        
        guard device.hasFlash else {
            return ["error": "Device does not have flash capability", "success": false]
        }
        
        try device.lockForConfiguration()
        device.torchMode = turnOn ? .on : .off
        device.unlockForConfiguration()
        
        return ["success": true, "turnOn": turnOn]
    } catch {
        return ["error": "Failed to control flashlight: \(error.localizedDescription)", "success": false]
    }
}
```

### Web (JavaScript)
```javascript
// Flashlight control (not available on web)
controlFlashlight(turnOn) {
    return new Promise((resolve) => {
        setTimeout(() => {
            resolve({
                error: 'Flashlight not available on web platform',
                success: false,
                turnOn: turnOn,
                platform: 'Web (JavaScript)'
            });
        }, 100);
    });
}
```

## 🎯 Learning Objectives

This demo helps students understand:

1. **Platform Channel Types**
   - MethodChannel vs EventChannel vs BasicMessageChannel
   - When to use each type

2. **Native Code Integration**
   - How Flutter communicates with platform-specific code
   - Platform-specific API usage
   - Delegating computational tasks to native code
   - **Hardware access and control**

3. **Cross-Platform Development**
   - Handling platform differences
   - Fallback implementations
   - Performance considerations
   - **Hardware capability detection**

4. **Real-time Data Handling**
   - Stream-based data communication
   - Event-driven programming

5. **Error Handling**
   - Platform-specific error handling
   - Graceful fallbacks
   - User-friendly error messages
   - **Hardware permission handling**

6. **Hardware Integration**
   - Camera flash control
   - Device capability detection
   - Platform-specific hardware APIs

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Android Studio / Xcode (for mobile development)
- Web browser (for web testing)
- **Physical device with camera flash for flashlight demo**

### Installation
1. Clone the repository
2. Run `flutter pub get`
3. Connect a device or start an emulator
4. Run `flutter run`

### Testing Different Platforms
```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web
flutter run -d chrome
```

## 📚 Teaching Guide

### Session 1: Introduction to Platform Channels
- Explain what platform channels are
- Show the demo app running on different platforms
- Discuss use cases and benefits

### Session 2: MethodChannel Deep Dive
- Walk through the Flutter service code
- Show native implementations (Android/iOS)
- Demonstrate method calls and responses

### Session 3: Arithmetic Operations Demo
- Show how calculations are performed at native level
- Discuss performance benefits of native computation
- Demonstrate error handling across platforms

### Session 4: Hardware Control Demo (Flashlight)
- Show how to access device hardware
- Discuss platform-specific hardware APIs
- Demonstrate capability detection and fallbacks
- **Show real hardware interaction**

### Session 5: EventChannel and Real-time Data
- Explain streaming vs one-time calls
- Show sensor data implementation
- Discuss performance implications

### Session 6: Platform-Specific Features
- Show how different platforms handle the same functionality
- Discuss platform limitations and workarounds
- Web-specific considerations

### Session 7: Hands-on Exercise
- Ask students to add a new platform channel method
- Implement it on all three platforms
- Test and debug the implementation

## 🔍 Code Examples

### Adding a New Platform Channel Method

1. **Flutter Service** (`platform_channel_service.dart`):
```dart
static Future<String> getCustomData() async {
  if (kIsWeb) {
    return await _getWebCustomData();
  }
  
  final String result = await _channel.invokeMethod('getCustomData');
  return result;
}
```

2. **Android** (`MainActivity.kt`):
```kotlin
"getCustomData" -> {
    val customData = getCustomData()
    result.success(customData)
}
```

3. **iOS** (`AppDelegate.swift`):
```swift
case "getCustomData":
    let customData = getCustomData()
    result(customData)
```

4. **Web** (`platform_channel_web.js`):
```javascript
getCustomData: () => window.webPlatformChannel.getCustomData()
```

## 🐛 Troubleshooting

### Common Issues
1. **Platform channel not working**: Check channel names match exactly
2. **Web not loading**: Ensure JavaScript file is properly included
3. **Native crashes**: Check permissions and API availability
4. **Hot reload issues**: Restart the app after native code changes
5. **Flashlight not working**: Check camera permissions and hardware availability

### Debug Tips
- Use `print()` statements in native code
- Check Flutter console for error messages
- Verify platform channel names match
- Test on physical devices when possible
- **Check device permissions for camera access**

## 📖 Additional Resources

- [Flutter Platform Channels Documentation](https://docs.flutter.dev/development/platform-integration/platform-channels)
- [Android Platform Integration](https://docs.flutter.dev/development/platform-integration/android)
- [iOS Platform Integration](https://docs.flutter.dev/development/platform-integration/ios)
- [Web Platform Integration](https://docs.flutter.dev/development/platform-integration/web)
- [Android Camera2 API](https://developer.android.com/reference/android/hardware/camera2/package-summary)
- [iOS AVFoundation](https://developer.apple.com/documentation/avfoundation)

## 🤝 Contributing

Feel free to contribute improvements, bug fixes, or additional platform channel examples!

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

**Happy Learning! 🎓**

This demo app demonstrates the power and flexibility of Flutter's platform channel system, making it an excellent tool for teaching mobile and web development concepts. The flashlight demo specifically shows how Flutter can access and control device hardware through native platform APIs, while the arithmetic operations demo shows how Flutter can delegate computational tasks to native code for better performance.
