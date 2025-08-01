import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class ThemeSwitchWidget extends StatelessWidget {
  const ThemeSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    
    return Obx(() => Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  themeController.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Theme Mode',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Switch(
              value: themeController.isDarkMode,
              onChanged: (value) => themeController.toggleTheme(),
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    ));
  }
} 