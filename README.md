# GetX Demo App

A comprehensive Flutter demo application showcasing GetX features for training purposes.

## Features Demonstrated

### 1. Login with API Demo
- **State Management**: Using GetX controllers for reactive state management
- **API Integration**: HTTP requests with loading states and error handling
- **Form Validation**: Real-time validation with observable error states
- **UI Feedback**: Loading indicators, success/error messages using GetX Snackbar

### 2. GetX Features Demo
- **Snackbar**: Custom notifications with styling
- **Dialog**: Custom dialogs with actions
- **Bottom Sheet**: Modal bottom sheets with custom styling
- **Navigation**: Easy navigation with transitions
- **Storage**: Local data persistence using GetStorage
- **Theme**: Dynamic theme switching (Light/Dark)
- **Locale**: Internationalization support
- **Counter**: Simple state management example

## Demo Credentials

For the login demo, use these credentials:

**Admin User:**
- Email: `admin@example.com`
- Password: `password123`

**Regular User:**
- Email: `user@example.com`
- Password: `password123`

**Any other credentials will show an error message.**

## Project Structure

```
lib/
├── main.dart                 # App entry point with GetMaterialApp
├── screens/
│   ├── dashboard_screen.dart # Main dashboard
│   ├── login_screen.dart     # Login demo screen
│   └── getx_features_screen.dart # Features showcase
├── controllers/
│   ├── login_controller.dart # Login state management
│   └── features_controller.dart # Features demo controller
├── services/
│   └── auth_service.dart     # API service for login
└── widgets/
    ├── custom_text_field.dart # Reusable text field
    └── feature_card.dart     # Feature card widget
```

## Key GetX Concepts Demonstrated

### State Management
- `GetxController` for business logic
- `Rx` variables for reactive state
- `Obx()` widget for reactive UI updates

### Navigation
- `Get.to()` for navigation
- `Get.back()` for going back
- Custom transitions and durations

### Utilities
- `Get.snackbar()` for notifications
- `Get.dialog()` for dialogs
- `Get.bottomSheet()` for bottom sheets
- `GetStorage()` for local storage

### Dependency Injection
- `Get.put()` for controller injection
- Automatic lifecycle management

## Running the Demo

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

3. Navigate through the demos:
   - **Dashboard**: Choose between Login Demo or Features Demo
   - **Login Demo**: Test API integration with form validation
   - **Features Demo**: Explore various GetX utilities

## Training Points

### For Students Learning GetX:

1. **State Management**
   - How to create controllers with `GetxController`
   - Using `Rx` variables for reactive state
   - Connecting UI with `Obx()` widgets

2. **API Integration**
   - Handling async operations
   - Loading states and error handling
   - Form validation with reactive error states

3. **Navigation**
   - Simple navigation with `Get.to()`
   - Custom transitions
   - Parameter passing

4. **Utilities**
   - Snackbar for user feedback
   - Dialog for user interactions
   - Bottom sheet for modal content
   - Storage for data persistence

5. **Best Practices**
   - Separation of concerns (controllers, services, widgets)
   - Reactive programming patterns
   - Error handling and user feedback

## Code Highlights

### Controller Example:
```dart
class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString emailError = ''.obs;
  
  Future<void> login() async {
    isLoading.value = true;
    // API call logic
    isLoading.value = false;
  }
}
```

### UI with Obx:
```dart
Obx(() => ElevatedButton(
  onPressed: controller.isLoading.value ? null : controller.login,
  child: controller.isLoading.value 
    ? CircularProgressIndicator() 
    : Text('Login'),
))
```

### Snackbar Example:
```dart
Get.snackbar(
  'Success!',
  'Login successful!',
  snackPosition: SnackPosition.TOP,
  backgroundColor: Colors.green,
  colorText: Colors.white,
);
```

This demo provides a comprehensive overview of GetX capabilities, perfect for training sessions with students learning Flutter state management and GetX utilities.
