import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/features_controller.dart';
import '../widgets/feature_card.dart';

class GetXFeaturesScreen extends StatelessWidget {
  const GetXFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FeaturesController controller = Get.put(FeaturesController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('GetX Features Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'GetX Features Showcase',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Explore various GetX utilities and features',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  FeatureCard(
                    title: 'Snackbar',
                    subtitle: 'Show notifications',
                    icon: Icons.notifications,
                    color: Colors.blue,
                    onTap: () => controller.showSnackbar(),
                  ),
                                     FeatureCard(
                     title: 'Dialog',
                     subtitle: 'Custom dialogs',
                     icon: Icons.message,
                     color: Colors.green,
                     onTap: () => controller.showDialog(),
                   ),
                  FeatureCard(
                    title: 'Bottom Sheet',
                    subtitle: 'Modal bottom sheets',
                    icon: Icons.keyboard_arrow_up,
                    color: Colors.orange,
                    onTap: () => controller.showBottomSheet(),
                  ),
                  FeatureCard(
                    title: 'Navigation',
                    subtitle: 'Easy navigation',
                    icon: Icons.navigation,
                    color: Colors.purple,
                    onTap: () => controller.navigateToPage(),
                  ),
                  FeatureCard(
                    title: 'Storage',
                    subtitle: 'Local data storage',
                    icon: Icons.storage,
                    color: Colors.teal,
                    onTap: () => controller.demoStorage(),
                  ),
                  FeatureCard(
                    title: 'Theme',
                    subtitle: 'Dynamic theming',
                    icon: Icons.palette,
                    color: Colors.indigo,
                    onTap: () => controller.toggleTheme(),
                  ),
                  FeatureCard(
                    title: 'Locale',
                    subtitle: 'Internationalization',
                    icon: Icons.language,
                    color: Colors.red,
                    onTap: () => controller.changeLocale(),
                  ),
                  FeatureCard(
                    title: 'Counter',
                    subtitle: 'State management',
                    icon: Icons.add_circle,
                    color: Colors.amber,
                    onTap: () => controller.incrementCounter(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current State:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Counter: ${controller.counter.value}'),
                  Text('Theme: ${controller.isDarkMode.value ? 'Dark' : 'Light'}'),
                  Text('Locale: ${controller.currentLocale.value}'),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
} 