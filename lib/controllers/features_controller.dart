import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FeaturesController extends GetxController {
  // Observable variables
  final RxInt counter = 0.obs;
  final RxBool isDarkMode = false.obs;
  final RxString currentLocale = 'en'.obs;
  final RxString storedData = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Load stored data on initialization
    loadStoredData();
  }

  // Snackbar Demo
  void showSnackbar() {
    Get.snackbar(
      'GetX Snackbar',
      'This is a GetX snackbar notification!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.info, color: Colors.white),
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
    );
  }

  // Dialog Demo
  void showDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('GetX Dialog'),
        content: const Text('This is a GetX dialog. You can customize it easily!'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              showSnackbar();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Bottom Sheet Demo
  void showBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'GetX Bottom Sheet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'This is a GetX bottom sheet. You can add any widgets here!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                    showSnackbar();
                  },
                  child: const Text('Show Snackbar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }

  // Navigation Demo
  void navigateToPage() {
    Get.to(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Navigation Demo'),
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.navigation,
                size: 80,
                color: Colors.purple,
              ),
              const SizedBox(height: 20),
              const Text(
                'Navigation Successful!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'This page was navigated using GetX',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }

  // Storage Demo
  void demoStorage() async {
    // Store data using GetStorage
    await GetStorage().write('demo_key', 'Hello from GetX Storage!');
    
    // Read data
    final data = await GetStorage().read('demo_key') ?? 'No data found';
    storedData.value = data;
    
    showSnackbar();
  }

  void loadStoredData() async {
    final data = await GetStorage().read('demo_key');
    if (data != null) {
      storedData.value = data;
    }
  }

  // Theme Demo
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    
    if (isDarkMode.value) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
    
    showSnackbar();
  }

  // Locale Demo
  void changeLocale() {
    if (currentLocale.value == 'en') {
      currentLocale.value = 'es';
      Get.updateLocale(const Locale('es', 'ES'));
    } else {
      currentLocale.value = 'en';
      Get.updateLocale(const Locale('en', 'US'));
    }
    
    showSnackbar();
  }

  // Counter Demo (State Management)
  void incrementCounter() {
    counter.value++;
    showSnackbar();
  }
} 