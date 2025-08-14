import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class PlatformChannelService {
  static const MethodChannel _channel = MethodChannel('platform_channel_demo');
  static const EventChannel _eventChannel = EventChannel('platform_events');
  
  // Get platform information
  static Future<String> getPlatformInfo() async {
    try {
      if (kIsWeb) {
        return await _getWebPlatformInfo();
      }
      
      final dynamic result = await _channel.invokeMethod('getPlatformInfo');
      return result?.toString() ?? 'Unknown platform';
    } on PlatformException catch (e) {
      return 'Error: ${e.message}';
    }
  }
  
  // Get device battery level
  static Future<int> getBatteryLevel() async {
    try {
      if (kIsWeb) {
        return await _getWebBatteryLevel();
      }
      
      final dynamic result = await _channel.invokeMethod('getBatteryLevel');
      return result is int ? result : -1;
    } on PlatformException catch (e) {
      return -1;
    }
  }
  
  // Get device information
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      if (kIsWeb) {
        return await _getWebDeviceInfo();
      }
      
      final dynamic result = await _channel.invokeMethod('getDeviceInfo');
      return _convertToMap(result);
    } on PlatformException catch (e) {
      return {'error': e.message};
    }
  }
  
  // Show native toast/alert
  static Future<void> showNativeAlert(String message) async {
    try {
      if (kIsWeb) {
        _showWebAlert(message);
        return;
      }
      
      await _channel.invokeMethod('showNativeAlert', {'message': message});
    } on PlatformException catch (e) {
      print('Error showing native alert: ${e.message}');
    }
  }
  
  // Perform arithmetic operations at native level
  static Future<Map<String, dynamic>> performArithmeticOperation(
    double a, 
    double b, 
    String operation
  ) async {
    try {
      if (kIsWeb) {
        return await _performWebArithmetic(a, b, operation);
      }
      
      final dynamic result = await _channel.invokeMethod(
        'performArithmetic',
        {
          'a': a,
          'b': b,
          'operation': operation,
        }
      );
      return _convertToMap(result);
    } on PlatformException catch (e) {
      return {
        'error': e.message,
        'result': null,
        'operation': operation,
        'a': a,
        'b': b,
      };
    }
  }
  
  // Control device flashlight
  static Future<Map<String, dynamic>> controlFlashlight(bool turnOn) async {
    try {
      if (kIsWeb) {
        return await _controlWebFlashlight(turnOn);
      }
      
      final dynamic result = await _channel.invokeMethod(
        'controlFlashlight',
        {'turnOn': turnOn}
      );
      return _convertToMap(result);
    } on PlatformException catch (e) {
      return {
        'error': e.message,
        'success': false,
        'turnOn': turnOn,
      };
    }
  }
  
  // Check if flashlight is available
  static Future<bool> isFlashlightAvailable() async {
    try {
      if (kIsWeb) {
        return false; // Flashlight not available on web
      }
      
      final dynamic result = await _channel.invokeMethod('isFlashlightAvailable');
      return result is bool ? result : false;
    } on PlatformException catch (e) {
      return false;
    }
  }
  
  // Get real-time sensor data
  static Stream<double> getSensorData() {
    if (kIsWeb) {
      return _getWebSensorData();
    }
    
    return _eventChannel.receiveBroadcastStream().map((event) {
      if (event is num) {
        return event.toDouble();
      }
      return 0.0;
    });
  }
  
  // Helper method to convert platform channel results to Map<String, dynamic>
  static Map<String, dynamic> _convertToMap(dynamic result) {
    if (result is Map) {
      final Map<String, dynamic> converted = {};
      result.forEach((key, value) {
        if (key is String) {
          converted[key] = value;
        } else {
          converted[key.toString()] = value;
        }
      });
      return converted;
    }
    return {'error': 'Invalid result format', 'data': result};
  }
  
  // Web-specific implementations using JavaScript interop
  static Future<String> _getWebPlatformInfo() async {
    try {
      // Web implementation - return platform info
      return 'Web Platform - JavaScript interop available';
    } catch (e) {
      return 'Web Platform - JavaScript interop available';
    }
  }
  
  static Future<int> _getWebBatteryLevel() async {
    try {
      // Web implementation - return simulated battery level
      return 75; // Fallback value
    } catch (e) {
      return 75; // Fallback value
    }
  }
  
  static Future<Map<String, dynamic>> _getWebDeviceInfo() async {
    try {
      // Web implementation - return simulated device info
      return {
        'platform': 'Web',
        'userAgent': 'Flutter Web Demo',
        'screenWidth': 1920,
        'screenHeight': 1080,
        'language': 'en-US',
        'cookieEnabled': true,
        'onLine': true,
      };
    } catch (e) {
      return {
        'platform': 'Web',
        'userAgent': 'Flutter Web Demo',
        'screenWidth': 1920,
        'screenHeight': 1080,
        'error': 'JavaScript interop failed'
      };
    }
  }
  
  static void _showWebAlert(String message) {
    try {
      // Web implementation - log to console
      print('Web Alert: $message');
    } catch (e) {
      print('Web Alert: $message');
    }
  }
  
  static Future<Map<String, dynamic>> _performWebArithmetic(
    double a, 
    double b, 
    String operation
  ) async {
    try {
      double result;
      String operationSymbol;
      
      switch (operation) {
        case 'add':
          result = a + b;
          operationSymbol = '+';
          break;
        case 'subtract':
          result = a - b;
          operationSymbol = '-';
          break;
        case 'multiply':
          result = a * b;
          operationSymbol = '×';
          break;
        case 'divide':
          if (b == 0) {
            return {
              'error': 'Division by zero',
              'result': null,
              'operation': operation,
              'a': a,
              'b': b,
            };
          }
          result = a / b;
          operationSymbol = '÷';
          break;
        default:
          return {
            'error': 'Invalid operation',
            'result': null,
            'operation': operation,
            'a': a,
            'b': b,
          };
      }
      
      return {
        'result': result,
        'operation': operation,
        'operationSymbol': operationSymbol,
        'a': a,
        'b': b,
        'expression': '$a $operationSymbol $b = $result',
        'platform': 'Web (JavaScript)',
      };
    } catch (e) {
      return {
        'error': 'Web arithmetic failed: $e',
        'result': null,
        'operation': operation,
        'a': a,
        'b': b,
      };
    }
  }
  
  static Future<Map<String, dynamic>> _controlWebFlashlight(bool turnOn) async {
    // Web implementation - return not available message
    return {
      'error': 'Flashlight not available on web platform',
      'success': false,
      'turnOn': turnOn,
      'platform': 'Web',
    };
  }
  
  static Stream<double> _getWebSensorData() {
    return Stream.periodic(const Duration(milliseconds: 500), (i) {
      try {
        // Simulated sensor data for web
        return (i * 0.1) % 10.0;
      } catch (e) {
        // Fallback to simple counter
        return (i * 0.1) % 10.0;
      }
    });
  }
}
