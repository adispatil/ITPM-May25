# Side Menu Web App

A Flutter web application featuring a responsive left sidebar menu with expandable submenus and dotted line connections, similar to modern dashboard interfaces.

## Features

- **Expandable Sidebar Menu**: Main menu items can be expanded/collapsed to show submenus
- **Dotted Line Connections**: Visual dotted lines connect submenu items to their parent menu
- **Interactive Navigation**: Click on menu items to navigate between different sections
- **Responsive Design**: Works well on different screen sizes
- **Modern UI**: Clean, professional design with orange accent colors
- **Dashboard Content**: Sample dashboard content with charts and analytics

## Menu Structure

The app includes the following menu structure:

- **Dashboard** (expanded by default)
  - Overview
  - Custom Charts
  - Alert Log
  - Alert Management
  - User Feedback
- **Infrastructure**
  - Servers
  - Networks
  - Storage
  - Monitoring
- **Applications**
  - Web Apps
  - Mobile Apps
  - Desktop Apps
  - APIs
  - Microservices
- **Analytics**
  - Reports
  - Metrics
  - Insights
- **Settings**
  - General
  - Security
  - Users
  - Integrations

## Getting Started

### Prerequisites

- Flutter SDK (3.9.0 or higher)
- Dart SDK
- Chrome browser (for web development)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd side_menu
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run -d chrome
```

The app will open in your default browser at `http://localhost:8080`.

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── menu_item.dart       # Menu item data model
├── screens/
│   └── dashboard/
│       └── dashboard_screen.dart  # Main dashboard screen
└── widgets/
    └── sidebar/
        └── sidebar_widget.dart    # Sidebar menu widget
```

## Customization

### Adding New Menu Items

To add new menu items, modify the `menuItems` list in `lib/screens/dashboard/dashboard_screen.dart`:

```dart
MenuItem(
  title: 'New Section',
  icon: Icons.new_icon,
  subItems: [
    MenuItem(title: 'Sub Item 1', icon: Icons.sub_icon_1),
    MenuItem(title: 'Sub Item 2', icon: Icons.sub_icon_2),
  ],
),
```

### Styling

The app uses Material Design 3 with an orange color scheme. You can customize colors and styling in:
- `lib/main.dart` - Theme configuration
- `lib/widgets/sidebar/sidebar_widget.dart` - Sidebar styling
- `lib/screens/dashboard/dashboard_screen.dart` - Content styling

## Technologies Used

- **Flutter**: UI framework
- **Dart**: Programming language
- **Material Design 3**: Design system
- **Custom Painters**: For dotted lines and charts

## License

This project is open source and available under the [MIT License](LICENSE).
