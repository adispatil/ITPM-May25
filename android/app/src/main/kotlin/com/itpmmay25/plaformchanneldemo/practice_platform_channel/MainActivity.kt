package com.itpmmay25.plaformchanneldemo.practice_platform_channel

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.hardware.camera2.CameraManager
import kotlinx.coroutines.*

class MainActivity : FlutterActivity() {
    private val CHANNEL = "platform_channel_demo"
    private val EVENT_CHANNEL = "platform_events"
    
    private var sensorManager: SensorManager? = null
    private var sensor: Sensor? = null
    private var sensorJob: Job? = null
    private var cameraManager: CameraManager? = null
    private var cameraId: String? = null
    
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Initialize camera manager for flashlight
        cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
        _findCameraWithFlash()
        
        // Method Channel for one-time method calls
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getPlatformInfo" -> {
                    result.success("Android ${Build.VERSION.RELEASE} (API ${Build.VERSION.SDK_INT})")
                }
                "getBatteryLevel" -> {
                    val batteryLevel = getBatteryLevel()
                    result.success(batteryLevel)
                }
                "getDeviceInfo" -> {
                    val deviceInfo = getDeviceInfo()
                    result.success(deviceInfo)
                }
                "showNativeAlert" -> {
                    val message = call.argument<String>("message") ?: "Hello from Flutter!"
                    showNativeAlert(message)
                    result.success(null)
                }
                "performArithmetic" -> {
                    val a = call.argument<Double>("a") ?: 0.0
                    val b = call.argument<Double>("b") ?: 0.0
                    val operation = call.argument<String>("operation") ?: "add"
                    val arithmeticResult = performArithmetic(a, b, operation)
                    result.success(arithmeticResult)
                }
                "controlFlashlight" -> {
                    val turnOn = call.argument<Boolean>("turnOn") ?: false
                    val flashlightResult = controlFlashlight(turnOn)
                    result.success(flashlightResult)
                }
                "isFlashlightAvailable" -> {
                    val isAvailable = isFlashlightAvailable()
                    result.success(isAvailable)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
        
        // Event Channel for continuous data streaming
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    events?.let { eventSink ->
                        startSensorDataStream(eventSink)
                    }
                }
                
                override fun onCancel(arguments: Any?) {
                    stopSensorDataStream()
                }
            }
        )
    }
    
    private fun _findCameraWithFlash() {
        try {
            cameraManager?.cameraIdList?.forEach { id ->
                val characteristics = cameraManager?.getCameraCharacteristics(id)
                val hasFlash = characteristics?.get(android.hardware.camera2.CameraCharacteristics.FLASH_INFO_AVAILABLE)
                if (hasFlash == true) {
                    cameraId = id
                    return
                }
            }
        } catch (e: Exception) {
            println("Error finding camera with flash: ${e.message}")
        }
    }
    
    private fun getBatteryLevel(): Int {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
    
    private fun getDeviceInfo(): Map<String, Any> {
        return mapOf(
            "platform" to "Android",
            "version" to Build.VERSION.RELEASE,
            "sdkVersion" to Build.VERSION.SDK_INT,
            "manufacturer" to Build.MANUFACTURER,
            "model" to Build.MODEL,
            "brand" to Build.BRAND,
            "product" to Build.PRODUCT,
            "device" to Build.DEVICE,
            "hardware" to Build.HARDWARE,
            "fingerprint" to Build.FINGERPRINT
        )
    }
    
    private fun showNativeAlert(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show()
    }
    
    private fun performArithmetic(a: Double, b: Double, operation: String): Map<String, Any> {
        return try {
            val result: Double
            val operationSymbol: String
            
            when (operation) {
                "add" -> {
                    result = a + b
                    operationSymbol = "+"
                }
                "subtract" -> {
                    result = a - b
                    operationSymbol = "-"
                }
                "multiply" -> {
                    result = a * b
                    operationSymbol = "×"
                }
                "divide" -> {
                    if (b == 0.0) {
                        return mapOf(
                            "error" to "Division by zero",
                            "result" to null,
                            "operation" to operation,
                            "a" to a,
                            "b" to b
                        )
                    }
                    result = a / b
                    operationSymbol = "÷"
                }
                else -> {
                    return mapOf(
                        "error" to "Invalid operation",
                        "result" to null,
                        "operation" to operation,
                        "a" to a,
                        "b" to b
                    )
                }
            }
            
            mapOf(
                "result" to result,
                "operation" to operation,
                "operationSymbol" to operationSymbol,
                "a" to a,
                "b" to b,
                "expression" to "$a $operationSymbol $b = $result",
                "platform" to "Android (Kotlin)"
            )
        } catch (e: Exception) {
            mapOf(
                "error" to "Arithmetic operation failed: ${e.message}",
                "result" to null,
                "operation" to operation,
                "a" to a,
                "b" to b
            )
        }
    }
    
    private fun controlFlashlight(turnOn: Boolean): Map<String, Any> {
        return try {
            if (cameraId == null) {
                return mapOf(
                    "error" to "No camera with flash found",
                    "success" to false,
                    "turnOn" to turnOn
                )
            }
            
            cameraManager?.setTorchMode(cameraId!!, turnOn)
            
            mapOf(
                "success" to true,
                "turnOn" to turnOn,
                "message" to if (turnOn) "Flashlight turned ON" else "Flashlight turned OFF",
                "platform" to "Android (Kotlin)"
            )
        } catch (e: Exception) {
            mapOf(
                "error" to "Failed to control flashlight: ${e.message}",
                "success" to false,
                "turnOn" to turnOn
            )
        }
    }
    
    private fun isFlashlightAvailable(): Boolean {
        return try {
            cameraId != null
        } catch (e: Exception) {
            false
        }
    }
    
    private fun startSensorDataStream(eventSink: EventChannel.EventSink) {
        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        sensor = sensorManager?.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
        
        if (sensor != null) {
            sensorJob = CoroutineScope(Dispatchers.Default).launch {
                var counter = 0.0
                while (isActive) {
                    // Simulate sensor data (in real app, you'd get actual sensor values)
                    val sensorValue = Math.sin(counter * 0.1) * 10.0
                    eventSink.success(sensorValue)
                    counter += 0.5
                    delay(500) // Update every 500ms
                }
            }
        } else {
            // Fallback to simulated data if no sensor available
            sensorJob = CoroutineScope(Dispatchers.Default).launch {
                var counter = 0.0
                while (isActive) {
                    val sensorValue = Math.sin(counter * 0.1) * 5.0
                    eventSink.success(sensorValue)
                    counter += 0.5
                    delay(500)
                }
            }
        }
    }
    
    private fun stopSensorDataStream() {
        sensorJob?.cancel()
        sensorJob = null
    }
    
    override fun onDestroy() {
        stopSensorDataStream()
        // Turn off flashlight when app is destroyed
        try {
            if (cameraId != null) {
                cameraManager?.setTorchMode(cameraId!!, false)
            }
        } catch (e: Exception) {
            // Ignore errors when turning off flashlight
        }
        super.onDestroy()
    }
}
