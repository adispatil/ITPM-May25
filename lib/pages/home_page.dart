import 'package:flutter/material.dart';
import '../widgets/theme_switch_widget.dart';
import '../widgets/demo_form_widget.dart';
import '../widgets/theme_showcase_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Theme Demo'),
        actions: [
          IconButton(
            onPressed: () {
              // Show theme info
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Theme Demo App'),
                  content: const Text(
                    'This app demonstrates Flutter theme management with GetX.\n\n'
                    'Features:\n'
                    '• Light and Dark theme switching\n'
                    '• Custom text styles\n'
                    '• Themed buttons and form fields\n'
                    '• GetX state management\n'
                    '• Material 3 design',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.info),
            tooltip: 'App Info',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome text
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.palette,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Flutter Theme Demo',
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Demonstrating theme management with GetX',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Theme switch
            const ThemeSwitchWidget(),
            const SizedBox(height: 16),
            
            // Theme showcase
            const ThemeShowcaseWidget(),
            const SizedBox(height: 16),
            
            // Demo form
            const DemoFormWidget(),
            const SizedBox(height: 16),
            
            // Additional info card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Theme Features',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 16),
                    
                    _buildFeatureItem(
                      context,
                      Icons.palette,
                      'Custom Color Schemes',
                      'Light and dark themes with custom color palettes',
                    ),
                    const SizedBox(height: 8),
                    
                    _buildFeatureItem(
                      context,
                      Icons.text_fields,
                      'Typography',
                      'Custom text styles for different text types',
                    ),
                    const SizedBox(height: 8),
                    
                    _buildFeatureItem(
                      context,
                      Icons.input,
                      'Form Styling',
                      'Themed text fields with validation',
                    ),
                    const SizedBox(height: 8),
                    
                    _buildFeatureItem(
                      context,
                      Icons.smart_button,
                      'Button Themes',
                      'Consistent button styling across themes',
                    ),
                    const SizedBox(height: 8),
                    
                    _buildFeatureItem(
                      context,
                      Icons.get_app,
                      'GetX Integration',
                      'Reactive state management for theme switching',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFeatureItem(BuildContext context, IconData icon, String title, String description) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
} 