// Web Platform Channel Implementation
// This file provides web-specific implementations for platform channel functionality

class WebPlatformChannel {
    constructor() {
        this.eventListeners = new Map();
        this.sensorInterval = null;
        this.sensorCounter = 0;
    }

    // Get platform information
    getPlatformInfo() {
        return new Promise((resolve) => {
            setTimeout(() => {
                const userAgent = navigator.userAgent;
                const platform = navigator.platform;
                resolve(`Web Platform - ${platform} (${userAgent})`);
            }, 100);
        });
    }

    // Get battery level (if supported)
    getBatteryLevel() {
        return new Promise((resolve) => {
            if ('getBattery' in navigator) {
                navigator.getBattery().then(battery => {
                    resolve(Math.round(battery.level * 100));
                }).catch(() => {
                    resolve(75); // Fallback value
                });
            } else {
                resolve(75); // Fallback value
            }
        });
    }

    // Get device information
    getDeviceInfo() {
        return new Promise((resolve) => {
            setTimeout(() => {
                resolve({
                    platform: 'Web',
                    userAgent: navigator.userAgent,
                    platform: navigator.platform,
                    language: navigator.language,
                    cookieEnabled: navigator.cookieEnabled,
                    onLine: navigator.onLine,
                    screenWidth: screen.width,
                    screenHeight: screen.height,
                    colorDepth: screen.colorDepth,
                    pixelDepth: screen.pixelDepth
                });
            }, 100);
        });
    }

    // Show web alert
    showNativeAlert(message) {
        console.log('Web Alert:', message);
        // You could implement a custom web alert here
        alert(`Platform Channel Demo: ${message}`);
    }

    // Perform arithmetic operations
    performArithmetic(a, b, operation) {
        return new Promise((resolve) => {
            setTimeout(() => {
                let result;
                let operationSymbol;
                let error = null;

                try {
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
                            if (b === 0) {
                                error = 'Division by zero';
                                result = null;
                                break;
                            }
                            result = a / b;
                            operationSymbol = '÷';
                            break;
                        default:
                            error = 'Invalid operation';
                            result = null;
                            break;
                    }

                    if (error) {
                        resolve({
                            error: error,
                            result: null,
                            operation: operation,
                            a: a,
                            b: b
                        });
                    } else {
                        resolve({
                            result: result,
                            operation: operation,
                            operationSymbol: operationSymbol,
                            a: a,
                            b: b,
                            expression: `${a} ${operationSymbol} ${b} = ${result}`,
                            platform: 'Web (JavaScript)'
                        });
                    }
                } catch (e) {
                    resolve({
                        error: `Arithmetic operation failed: ${e.message}`,
                        result: null,
                        operation: operation,
                        a: a,
                        b: b
                    });
                }
            }, 100);
        });
    }

    // Control flashlight (not available on web)
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

    // Check if flashlight is available (always false on web)
    isFlashlightAvailable() {
        return new Promise((resolve) => {
            setTimeout(() => {
                resolve(false);
            }, 100);
        });
    }

    // Start sensor data stream
    startSensorDataStream(callback) {
        this.sensorCounter = 0;
        this.sensorInterval = setInterval(() => {
            const sensorValue = Math.sin(this.sensorCounter * 0.1) * 5.0;
            callback(sensorValue);
            this.sensorCounter += 0.5;
        }, 500);
    }

    // Stop sensor data stream
    stopSensorDataStream() {
        if (this.sensorInterval) {
            clearInterval(this.sensorInterval);
            this.sensorInterval = null;
        }
    }

    // Add event listener
    addEventListener(event, callback) {
        if (!this.eventListeners.has(event)) {
            this.eventListeners.set(event, []);
        }
        this.eventListeners.get(event).push(callback);
    }

    // Remove event listener
    removeEventListener(event, callback) {
        if (this.eventListeners.has(event)) {
            const listeners = this.eventListeners.get(event);
            const index = listeners.indexOf(callback);
            if (index > -1) {
                listeners.splice(index, 1);
            }
        }
    }

    // Trigger event
    triggerEvent(event, data) {
        if (this.eventListeners.has(event)) {
            this.eventListeners.get(event).forEach(callback => {
                callback(data);
            });
        }
    }
}

// Create global instance
window.webPlatformChannel = new WebPlatformChannel();

// Expose methods for Flutter web
window.flutterPlatformChannel = {
    getPlatformInfo: () => window.webPlatformChannel.getPlatformInfo(),
    getBatteryLevel: () => window.webPlatformChannel.getBatteryLevel(),
    getDeviceInfo: () => window.webPlatformChannel.getDeviceInfo(),
    showNativeAlert: (message) => window.webPlatformChannel.showNativeAlert(message),
    performArithmetic: (a, b, operation) => window.webPlatformChannel.performArithmetic(a, b, operation),
    controlFlashlight: (turnOn) => window.webPlatformChannel.controlFlashlight(turnOn),
    isFlashlightAvailable: () => window.webPlatformChannel.isFlashlightAvailable(),
    startSensorDataStream: (callback) => window.webPlatformChannel.startSensorDataStream(callback),
    stopSensorDataStream: () => window.webPlatformChannel.stopSensorDataStream()
};

console.log('Web Platform Channel loaded successfully!');
