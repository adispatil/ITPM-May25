import Flutter
import UIKit
import CoreMotion
import AVFoundation

@main
@objc class AppDelegate: FlutterAppDelegate {
    private var methodChannel: FlutterMethodChannel?
    private var eventChannel: FlutterEventChannel?
    private var motionManager: CMMotionManager?
    private var eventSink: FlutterEventSink?
    private var timer: Timer?
    private var device: AVCaptureDevice?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // Setup platform channels
        setupPlatformChannels()
        
        // Initialize camera device for flashlight
        setupCameraDevice()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func setupCameraDevice() {
        // Find the back camera (which typically has flash)
        if let backCamera = AVCaptureDevice.default(for: .video) {
            device = backCamera
        }
    }
    
    private func setupPlatformChannels() {
        let controller = window?.rootViewController as! FlutterViewController
        
        // Method Channel for one-time method calls
        methodChannel = FlutterMethodChannel(
            name: "platform_channel_demo",
            binaryMessenger: controller.binaryMessenger
        )
        
        methodChannel?.setMethodCallHandler { [weak self] (call, result) in
            self?.handleMethodCall(call, result: result)
        }
        
        // Event Channel for continuous data streaming
        eventChannel = FlutterEventChannel(
            name: "platform_events",
            binaryMessenger: controller.binaryMessenger
        )
        
        eventChannel?.setStreamHandler(self)
    }
    
    private func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformInfo":
            let platformInfo = getPlatformInfo()
            result(platformInfo)
            
        case "getBatteryLevel":
            let batteryLevel = getBatteryLevel()
            result(batteryLevel)
            
        case "getDeviceInfo":
            let deviceInfo = getDeviceInfo()
            result(deviceInfo)
            
        case "showNativeAlert":
            if let args = call.arguments as? [String: Any],
               let message = args["message"] as? String {
                showNativeAlert(message)
            } else {
                showNativeAlert("Hello from Flutter!")
            }
            result(nil)
            
        case "performArithmetic":
            if let args = call.arguments as? [String: Any],
               let a = args["a"] as? Double,
               let b = args["b"] as? Double,
               let operation = args["operation"] as? String {
                let arithmeticResult = performArithmetic(a: a, b: b, operation: operation)
                result(arithmeticResult)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for arithmetic operation", details: nil))
            }
            
        case "controlFlashlight":
            if let args = call.arguments as? [String: Any],
               let turnOn = args["turnOn"] as? Bool {
                let flashlightResult = controlFlashlight(turnOn: turnOn)
                result(flashlightResult)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for flashlight control", details: nil))
            }
            
        case "isFlashlightAvailable":
            let isAvailable = isFlashlightAvailable()
            result(isAvailable)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func getPlatformInfo() -> String {
        let version = UIDevice.current.systemVersion
        let device = UIDevice.current.model
        return "iOS \(version) (\(device))"
    }
    
    private func getBatteryLevel() -> Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
        return batteryLevel
    }
    
    private func getDeviceInfo() -> [String: Any] {
        let device = UIDevice.current
        let systemInfo = ProcessInfo.processInfo
        
        return [
            "platform": "iOS",
            "version": device.systemVersion,
            "model": device.model,
            "name": device.name,
            "systemName": device.systemName,
            "localizedModel": device.localizedModel,
            "identifierForVendor": device.identifierForVendor?.uuidString ?? "Unknown",
            "processorCount": systemInfo.processorCount,
            "physicalMemory": systemInfo.physicalMemory,
            "systemUptime": systemInfo.systemUptime
        ]
    }
    
    private func showNativeAlert(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Platform Channel Demo",
                message: message,
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            ))
            
            if let rootViewController = self.window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func performArithmetic(a: Double, b: Double, operation: String) -> [String: Any] {
        do {
            let result: Double
            let operationSymbol: String
            
            switch operation {
            case "add":
                result = a + b
                operationSymbol = "+"
                
            case "subtract":
                result = a - b
                operationSymbol = "-"
                
            case "multiply":
                result = a * b
                operationSymbol = "×"
                
            case "divide":
                if b == 0.0 {
                    return [
                        "error": "Division by zero",
                        "result": NSNull(),
                        "operation": operation,
                        "a": a,
                        "b": b
                    ]
                }
                result = a / b
                operationSymbol = "÷"
                
            default:
                return [
                    "error": "Invalid operation",
                    "result": NSNull(),
                    "operation": operation,
                    "a": a,
                    "b": b
                ]
            }
            
            return [
                "result": result,
                "operation": operation,
                "operationSymbol": operationSymbol,
                "a": a,
                "b": b,
                "expression": "\(a) \(operationSymbol) \(b) = \(result)",
                "platform": "iOS (Swift)"
            ]
        } catch {
            return [
                "error": "Arithmetic operation failed: \(error.localizedDescription)",
                "result": NSNull(),
                "operation": operation,
                "a": a,
                "b": b
            ]
        }
    }
    
    private func controlFlashlight(turnOn: Bool) -> [String: Any] {
        do {
            guard let device = device else {
                return [
                    "error": "No camera device found",
                    "success": false,
                    "turnOn": turnOn
                ]
            }
            
            // Check if device has flash
            guard device.hasFlash else {
                return [
                    "error": "Device does not have flash capability",
                    "success": false,
                    "turnOn": turnOn
                ]
            }
            
            // Lock device for configuration
            try device.lockForConfiguration()
            
            if turnOn {
                device.torchMode = .on
            } else {
                device.torchMode = .off
            }
            
            // Unlock device
            device.unlockForConfiguration()
            
            return [
                "success": true,
                "turnOn": turnOn,
                "message": turnOn ? "Flashlight turned ON" : "Flashlight turned OFF",
                "platform": "iOS (Swift)"
            ]
        } catch {
            return [
                "error": "Failed to control flashlight: \(error.localizedDescription)",
                "success": false,
                "turnOn": turnOn
            ]
        }
    }
    
    private func isFlashlightAvailable() -> Bool {
        guard let device = device else { return false }
        return device.hasFlash
    }
}

// MARK: - FlutterStreamHandler
extension AppDelegate: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        startSensorDataStream()
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        stopSensorDataStream()
        eventSink = nil
        return nil
    }
    
    private func startSensorDataStream() {
        motionManager = CMMotionManager()
        
        if let motionManager = motionManager, motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.5
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self, let eventSink = self.eventSink else { return }
                
                if let data = data {
                    // Send accelerometer data (x-axis for demo)
                    let sensorValue = data.acceleration.x * 10.0
                    eventSink(sensorValue)
                }
            }
        } else {
            // Fallback to simulated data if accelerometer not available
            var counter = 0.0
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
                guard let self = self, let eventSink = self.eventSink else { return }
                
                let sensorValue = sin(counter * 0.1) * 5.0
                eventSink(sensorValue)
                counter += 0.5
            }
        }
    }
    
    private func stopSensorDataStream() {
        motionManager?.stopAccelerometerUpdates()
        motionManager = nil
        timer?.invalidate()
        timer = nil
    }
}
