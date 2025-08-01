# Flutter Theme Demo App

A comprehensive Flutter application that demonstrates theme management using GetX for state management. This app showcases how to create and switch between light and dark themes with custom styling for various UI components.

## Features

### 🎨 Theme Management
- **Light and Dark Themes**: Complete theme switching with custom color schemes
- **GetX Integration**: Reactive state management for seamless theme transitions
- **Material 3 Design**: Modern Material Design 3 implementation

### 📝 Custom Text Styles
- **Typography System**: Custom text styles for different text types
- **Responsive Design**: Text styles that adapt to theme changes
- **Consistent Styling**: Unified typography across the app

### 🎯 Component Theming
- **Button Themes**: Custom styling for ElevatedButton, OutlinedButton, and TextButton
- **Form Fields**: Themed TextFormField with validation
- **Cards**: Custom card styling with elevation and rounded corners
- **Icons**: Themed icons with appropriate colors

### 🔄 Interactive Features
- **Theme Switch**: Toggle between light and dark modes
- **Demo Form**: Interactive form with validation
- **Theme Showcase**: Visual demonstration of themed components
- **Color Palette**: Display of theme colors

## Project Structure

```
lib/
├── controllers/
│   └── theme_controller.dart      # GetX controller for theme management
├── pages/
│   └── home_page.dart            # Main app page
├── widgets/
│   ├── theme_switch_widget.dart  # Theme toggle widget
│   ├── demo_form_widget.dart     # Interactive form demo
│   └── theme_showcase_widget.dart # Component showcase
└── main.dart                     # App entry point
```

## Getting Started

### Prerequisites
- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd practice_theme_demo
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Usage

### Theme Switching
- Use the theme switch widget to toggle between light and dark modes
- The app will instantly update all components to reflect the new theme

### Exploring Components
- **Theme Showcase**: View different text styles, buttons, and color palettes
- **Demo Form**: Test form validation and themed input fields
- **Interactive Elements**: Try different button types and form interactions

## Key Implementation Details

### GetX Controller
```dart
class ThemeController extends GetxController {
  final _isDarkMode = false.obs;
  
  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
```

### Custom Theme Data
```dart
ThemeData get lightTheme {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    // Custom text styles, button themes, etc.
  );
}
```

### Widget Organization
Each widget is created in a separate file following Flutter best practices:
- `ThemeSwitchWidget`: Handles theme toggling
- `DemoFormWidget`: Shows form theming
- `ThemeShowcaseWidget`: Displays component examples

## Dependencies

- `flutter`: Flutter SDK
- `get: ^4.6.6`: GetX for state management
- `cupertino_icons: ^1.0.8`: iOS-style icons

## Features Demonstrated

1. **Theme Switching**: Seamless light/dark mode toggle
2. **Custom Text Styles**: Typography system with theme adaptation
3. **Button Theming**: Consistent button styling across themes
4. **Form Styling**: Themed input fields with validation
5. **Color Management**: Dynamic color schemes
6. **GetX State Management**: Reactive UI updates
7. **Material 3**: Modern design system implementation

## Contributing

Feel free to contribute to this project by:
- Adding new theme variations
- Improving component styling
- Adding more interactive features
- Enhancing documentation

## License

This project is for educational purposes and demonstrates Flutter theme management best practices.
